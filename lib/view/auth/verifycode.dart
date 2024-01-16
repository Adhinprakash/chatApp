import 'package:firebase_demo/widgets/round_button.dart';
import 'package:flutter/material.dart';

class Verifycodescreen extends StatefulWidget {
  final String verificationId;
  const Verifycodescreen({super.key, required this.verificationId});

  @override
  State<Verifycodescreen> createState() => _VerifycodescreenState();
}

class _VerifycodescreenState extends State<Verifycodescreen> {
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
          ),
          const SizedBox(height: 20,),
          RoundButton(buttoncolor: Colors.deepPurpleAccent, textcolor: Colors.white, title: "Login",ontap: (){
            
          },)
        ],
       ),
    );
  }
}