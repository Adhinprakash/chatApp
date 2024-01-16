import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_demo/utilits/utils.dart';
import 'package:firebase_demo/widgets/round_button.dart';
import 'package:flutter/material.dart';

class AddPostscreen extends StatefulWidget {
  const AddPostscreen({super.key});

  @override
  State<AddPostscreen> createState() => _AddPostscreenState();
}

class _AddPostscreenState extends State<AddPostscreen> {
  bool loading=false;
  final databaseRef=FirebaseDatabase.instance.ref("post");
  final postcontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(title: const Text("Add post",style: TextStyle(color: Colors.white),),backgroundColor: Colors.deepPurple,centerTitle: true, ),
    body:  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [

          const SizedBox(height: 20,),
          TextFormField(
            controller: postcontroller,
            maxLines: 4,
      decoration: const InputDecoration(
      
        hintText: "What's in your mind",
        border: OutlineInputBorder()
      ),
      
          ),
          const SizedBox(height: 30,) ,
           RoundButton(
            
            ontap:(){
              setState(() {
                loading=true;
              });
              String id =DateTime.now().microsecondsSinceEpoch.toString();
            databaseRef.child(id).set({
              "id":id,  
              "titile":postcontroller.text.toString()            
            }).then((value) {
              Utils().toastmessage("Post Added");
              setState(() {
                loading=false;
              });
            }).onError((error, stackTrace) {
              Utils().toastmessage(error.toString());
              setState(() {
                loading=false;
              });
            });
            } ,
            buttoncolor: Colors.deepPurple, textcolor: Colors.white, title: "Add")       ],
      ),
    ),
    );
  }
}