import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_demo/utilits/utils.dart';
import 'package:firebase_demo/view/auth/auth_services.dart';
import 'package:firebase_demo/view/auth/login_screen.dart';
import 'package:firebase_demo/view/chatservices/chat_services.dart';
import 'package:firebase_demo/view/post/add_post.dart';
import 'package:firebase_demo/view/post/chat_page.dart';
import 'package:firebase_demo/widgets/my_drawer.dart';
import 'package:firebase_demo/widgets/user_tile.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final _auth = FirebaseAuth.instance;
  final Chatservices _chatservices = Chatservices();
  final Authservices _authservices = Authservices();
  final searchtext = TextEditingController();
  final editcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          "Home",
        ),

        toolbarHeight: 50,
        foregroundColor: Colors.grey,
        backgroundColor: Colors.transparent,
        // actions: [

        //   IconButton(
        //       onPressed: () {
        //         _auth.signOut().then((value) {
        //           Navigator.push(
        //               context,
        //               MaterialPageRoute(
        //                   builder: (context) => const LogiScreen()));
        //         }).onError((error, stackTrace) {
        //           Utils().toastmessage(error.toString());
        //         });
        //       },
        //       icon: const Icon(
        //         Icons.logout_rounded,
        //         color: Colors.white,
        //       ))
        // ]
      ),
      drawer: Mydrawer(),
      body: _builduserList(),
    );
  }

  Widget _builduserList() {
    return StreamBuilder(
        stream: _chatservices.getUsersStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Error");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading');
          }

          return ListView(
            children: snapshot.data!
                .map<Widget>(
                    (userdata) => _builduserListitems(userdata, context))
                .toList(),
          );
        });
  }

// building individual items
  Widget _builduserListitems(
      Map<String, dynamic> userData, BuildContext context) {
    if (userData['email'] != _authservices.getcurrentuser()!.email) {
      return UserTile(
        text: userData["email"],
        ontap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatPage(
                        receiverEmail: userData['email'],
                        receiverID: userData['uid'],
                      )));
        },
      );
    } else {
      return Container();
    }
  }
}












          // body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextFormField(
//               controller: searchtext,
//               decoration: InputDecoration(
//                   hintText: "Search", border: OutlineInputBorder()),
//               onChanged: (String value) {
//                 setState(() {});
//               },
//             ),
//           ),
//           Expanded(
//               child: StreamBuilder(
//                   stream: ref.onValue,
//                   builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
//                     if (!snapshot.hasData) {
//                       return const CircularProgressIndicator();
//                     } else {
//                       Map<dynamic, dynamic> map =
//                           snapshot.data!.snapshot.value as dynamic;
//                       List<dynamic> list = [];
//                       list.clear();
//                       list = map.values.toList();
//                       return ListView.builder(
//                           itemCount: snapshot.data!.snapshot.children.length,
//                           itemBuilder: (context, index) {
//                             final title = list[index]["titile"].toString();
//                             final id = list[index]["id"] ?? "No Id".toLowerCase();
//                             if (searchtext.text.isEmpty ||
//                                 title
//                                     .toLowerCase()
//                                     .contains(searchtext.text.toLowerCase())) {
//                               return ListTile(
//                                 title:
//                                     Text(list[index]["titile"] ?? "NO title"),
//                                 subtitle: Text(list[index]["id"] ?? "No Id"),
//                                 trailing: PopupMenuButton(
//                                     itemBuilder: (context) => [
//                                           PopupMenuItem(
//                                               value: 1,
//                                               child: ListTile(
//                                                 onTap: () {
//                                                   Navigator.pop(context);
//                                                   ShowMydialoag(title,id);
//                                                 },
//                                                 leading: const Icon(Icons.edit),
//                                                 title: const Text("Edit"),
//                                               )),
//                                            PopupMenuItem(
//                                               value: 1,
//                                               child: ListTile(
//                                                 onTap: (){
//                                                   ref.child(id).remove();
//                                                   Navigator.pop(context);
//                                                 },
//                                                 leading: const Icon(Icons.delete),
//                                                 title: const Text("delete"),
//                                               ))
//                                         ]),
//                               );
//                             } else {
//                               return Container();
//                             }
//                           });
//                     }
//                   }))
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//           onPressed: () {
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => AddPostscreen()));
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
//                                 ref.child(id).update({"titile":editcontroller.text.toLowerCase()}).then((value) =>Utils().toastmessage("Post updated") ).onError((error, stackTrace) => Utils().toastmessage(e.toString()));

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