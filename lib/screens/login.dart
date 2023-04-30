import 'package:auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Widget/mypasswordtextformfield.dart';
import 'package:food_delivery_app/Widget/mytextformfield.dart';
import 'package:food_delivery_app/Widget/toptittle.dart';
import 'package:food_delivery_app/screens/signup.dart';

import 'home.dart';


class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController email = TextEditingController();



  void validation(context){
    if(email.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Email is Empty"),
          )
      );
    } else if (password.text.isEmpty){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Password is Empty"),
          ),
        );
    } else if (password.text.length <8 ){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Password is Too Short"),
        ),
      );
    }
  }

  final GlobalKey<ScaffoldState> scaffold=GlobalKey<ScaffoldState>();

  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffold,
      backgroundColor: Color(0xfff8f8f8),
     body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
            TopTitle(subsTitle: "Welcome Back!!!", title: "Login"),
              Center(
                child: Container(

                  height: 300,
                  width: 350,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    MyTextFormField("Email", email),
                      SizedBox(
                        height: 10,
                      ),
                      MyPasswordTextFormField(title: "Password", controller: password),


                      SizedBox(height: 50,),
                      Container(
                        height: 60,
                        width: 350,
                        child: ElevatedButton(
                          child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 30),),
                          onPressed: () {
                            validation(context);
                            FirebaseAuth.instance.signInWithEmailAndPassword(email: email.text, password: password.text);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => Home(key: null,)));
                          },

                        ),
                      ),

                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have Account? ", style: TextStyle(
                            color: Colors.black,fontSize: 18,
                          ),
                          ),
                          TextButton(onPressed: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => SignUp()));

                          }, child: Text('Sign Up',style: TextStyle(fontSize: 20),),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  }
}


