import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_demo/utilits/utils.dart';
import 'package:firebase_demo/widgets/round_button.dart';
import 'package:flutter/material.dart';
class AddFirestore extends StatefulWidget {
  const AddFirestore({super.key});

  @override
  State<AddFirestore> createState() => _AddFirestoreState();
}

class _AddFirestoreState extends State<AddFirestore> {
  bool loading=false;
  final postcontroller=TextEditingController();
 final  fireStore = FirebaseFirestore.instance.collection("users");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(title: const Text("Add Firestore data",style: TextStyle(color: Colors.white),),backgroundColor: Colors.deepPurple,centerTitle: true, ),
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
            fireStore.doc(id).set({
              "id":id,  
              "title":postcontroller.text.toString()            
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