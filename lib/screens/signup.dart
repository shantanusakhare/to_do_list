import 'package:auth/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_delivery_app/Widget/mypasswordtextformfield.dart';
import 'package:food_delivery_app/Widget/mytextformfield.dart';
import 'package:food_delivery_app/Widget/toptittle.dart';
import 'package:food_delivery_app/screens/home.dart';
import 'package:food_delivery_app/screens/login.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController email = TextEditingController();
  final TextEditingController fullName = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool isLoading=false;
  late UserCredential authResult;
  void submit()async{
    setState((){
      isLoading=false;
    });
    try{
      authResult=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.text, password: password.text);
    }on PlatformException catch(e){
      String message ="Please Check Internet";
      if(e.message != null){
        message = e.message.toString();

      }
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(""),
          ),);
      setState(() {
        isLoading = false;
      });
    }
    catch (e){
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()),
        ),);
    }
    /*final UserCredential ==*/
    authResult=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.text, password: password.text);
    await FirebaseFirestore.instance.collection("UserData").doc(authResult.user?.uid).set(
        { "UserName":fullName.text,
          "Email":email.text,
          "UserNumber":phoneNumber.text,
          "UserId":authResult.user?.uid,
          "UserAddress":address.text,
          //"Password":password.text,
        });


  }

  void validation(context){
    if(fullName.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Full Name is Empty"),
          )
      );
    }else if (email.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Email is Empty"),
        ),
      );
    }else if (phoneNumber.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Phone Number is Empty"),
        ),
      );
    }else if (address.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Address is Empty"),
        ),
      );
    }
    else if (password.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Password is Empty"),
        ),
      );
    } else if (password.text.length <8 ){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Password is Too Short"),
        ),
      );
    }else{
      submit();
    }
  }
  final GlobalKey<ScaffoldState> scaffold=GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffold,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(
          children: [
            TopTitle(subsTitle: "Create a Account", title: "Sign Up"),
            Container(
              height: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyTextFormField("Full Name", fullName),
                  MyTextFormField("Email", email),
                  MyTextFormField("Phone Number", phoneNumber),
                  MyTextFormField("Address", address),
                  MyPasswordTextFormField(title: "Password", controller: password),
                

                ],
              ),
            ),
            SizedBox(height: 20,),
            Container(
              height: 60,
              width: 350,
              child: ElevatedButton(
                child: Text("Sign Up", style: TextStyle(color: Colors.white, fontSize: 30),),
                onPressed: () {
                  validation(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                  },

              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have Account? ", style: TextStyle(
                  color: Colors.black,fontSize: 18,
                ),
                ),
                TextButton(onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));

                }, child: Text('Sign In',style: TextStyle(fontSize: 20),),
                )
              ],
            )

          ],
        )
      ),

    );
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    Future<String> signIn(final String email, final String password) async {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      final User user = userCredential.user!;
      return user.uid;
    }
  }
}
