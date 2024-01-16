

// import 'dart:math';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_demo/utilits/utils.dart';
// import 'package:firebase_demo/view/auth/login_screen.dart';
// import 'package:firebase_demo/view/firestore/add_firestore_data.dart';
// import 'package:flutter/material.dart';

// class FirestoreScreen extends StatefulWidget {
//   const FirestoreScreen({super.key});

//   @override
//   State<FirestoreScreen> createState() => _FirestoreScreenState();
// }

// class _FirestoreScreenState extends State<FirestoreScreen> {
//   final editcontroller = TextEditingController();
//    final  fireStore = FirebaseFirestore.instance.collection("users").snapshots();
//    CollectionReference ref=FirebaseFirestore.instance.collection("users");
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           automaticallyImplyLeading: false,
//           centerTitle: true,
//           title: Text(
//             "Firestore",
//             style: TextStyle(color: Colors.white),
//           ),
//           toolbarHeight: 50,
//           backgroundColor: Colors.deepPurple,
//           actions: [
//             IconButton(
//                 onPressed: () {
                
//                 },
//                 icon: const Icon(
//                   Icons.logout_rounded,
//                   color: Colors.white,
//                 ))
//           ]),
//       body: Column(
//         children: [
//         StreamBuilder<QuerySnapshot>(stream: fireStore, builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){

//           if(snapshot.connectionState==ConnectionState.waiting)
//             return CircularProgressIndicator();
          

//           if(snapshot.hasError)
//           return Text("No data found");


//           return  Expanded(
//               child: ListView.builder(
//                  itemCount: snapshot.data!.docs.length,
//                 itemBuilder: (context,index){
//                 return ListTile(
//                   onTap: (){
//                     // ref.doc(snapshot.data!.docs[index]["id"].toString()).update({
//                     // "title":"heyyyy"
//                     // }).then((value) {
//                     //   Utils().toastmessage("Post updated");
//                     // }).onError((error, stackTrace) {
//                     //   Utils().toastmessage(error.toString());
//                     // });

//                     ref.doc(snapshot.data!.docs[index]["id"].toString()).delete();
//                   },
//                   title: Text( snapshot.data!.docs[index]["title"].toString()),
//                   subtitle: Text( snapshot.data!.docs[index]["id"].toString()),
//                 ) ;
//               }));
//         }),
        
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             Navigator.push(context,
//                 MaterialPageRoute(builder: (context) => AddFirestore()));
//           },
//           child: const Icon(Icons.add)),
//     );
//   }

//   Future<void> ShowMydialoag(String title,String id)async {
//     editcontroller.text=title;
//     return showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: const Text("Update"),
//             content: Container(
//               child: TextField(
//                 controller: editcontroller,
//                 decoration: InputDecoration(hintText: "Edit"),
//               ),
//             ),
//             actions: [
//               TextButton(onPressed: () {
                               

//                 Navigator.pop(context);
//               }, child: const Text("Edit")),
//               TextButton(onPressed: () {

//                 Navigator.pop(context);
//               }, child: const Text("delete"))
//             ],
//           );
//         });
//   }
// }
