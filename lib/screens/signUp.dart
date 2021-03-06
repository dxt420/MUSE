import 'package:flutter/material.dart';
import '../services/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/helper_classes.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  bool loader = false;
  String email, password;
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ModalProgressHUD(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Stack(children: [
              Positioned(
                top: -70,
                left: -70,
                child: Container(
                  width: 300.0,
                  height: 300.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: blackPink,
                  ),
                ),
              ),
              Positioned(
                top: .2 * MediaQuery.of(context).size.height,
                left: .4 * MediaQuery.of(context).size.width,
                child: Container(
                  width: 500,
                  height: 500,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: brickRed,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                margin: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "SIGN UP",
                      style: headingStyleW,
                    ),
                    SizedBox(height: 30.0),
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _controller1,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white70,
                          hintText: 'Email',
                          hintStyle: TextStyle(
                            color: brickRed,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          )),
                      onChanged: (value) {
                        email = value;
                      },
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    TextField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: _controller2,
                      obscureText: true,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white70,
                          hintText: 'Password',
                          hintStyle: TextStyle(
                            color: brickRed,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          )),
                      onChanged: (value) {
                        password = value;
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    RaisedButton(
                      onPressed: () async{
                        setState(() {
                          loader = true;
                        });
                        try {
                            final newUser = await _auth
                                .createUserWithEmailAndPassword(
                                email: email, password: password);
                            if (newUser != null) {
                              Navigator.pushReplacementNamed(context, '/home');
                            }
                            setState(() {
                              loader = false;
                            });
                        }catch(e){
                          print(e);
                        }
                      },
                      textColor: Colors.black,
                      padding: const EdgeInsets.all(0.0),
                      child: BtnStyle(),
                    ),
                    SizedBox(height: 20.0,),
                    InkWell(
                      splashColor: deepBlue.withOpacity(0.6),
                      onTap: ()=>{
                        Navigator.pushReplacementNamed(context, '/login')
                      },
                      child: Text("Already a user: Log in", style: redirectTextStyle,),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
        inAsyncCall: loader,
      ),
    );
  }
}

