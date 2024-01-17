import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/utilits/utils.dart';
import 'package:firebase_demo/view/auth/verifycode.dart';
import 'package:firebase_demo/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoginWithPhonenumber extends StatefulWidget {
  const LoginWithPhonenumber({super.key});

  @override
  State<LoginWithPhonenumber> createState() => _LoginWithPhonenumberState();
}

class _LoginWithPhonenumberState extends State<LoginWithPhonenumber> {
  bool loading =false;
  final phonenumbercontroller=TextEditingController();
final _auth =FirebaseAuth.instance;

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        centerTitle: true,
        title: Text("Login"),
        backgroundColor: Colors.deepPurple,
        toolbarHeight: 50,
      
       ),
       body: Column(
        children: [

        
          TextFormField(
            keyboardType: TextInputType.number,
controller: phonenumbercontroller,
decoration: const InputDecoration(

  hintText: "+1 234 3455 234"
),
          ),
          const SizedBox(height: 20,),
          RoundButton(
            loading: loading,
            buttoncolor: Colors.deepPurpleAccent, textcolor: Colors.white, title: "Login",ontap: (){
              setState(() {
                loading=true;
              });
            _auth.verifyPhoneNumber(
              phoneNumber: phonenumbercontroller.text.toString(),
              verificationCompleted: (_){
                setState(() {
                  loading=false;
                });
              }, 
            verificationFailed: (e){
              Utils().toastmessage(e.toString());
            },
             codeSent: (String verificationId,int? token){
           Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Verifycodescreen(
                                  
                                  verificationId: verificationId,)));
                                setState(() {
                                  loading=false;
                                });

             },
              codeAutoRetrievalTimeout: (e){
                Utils().toastmessage(e.toString());
                setState(() {
                  loading=false;
                });
              }
              );
          },)
        ],
       ),
    );
  }
}