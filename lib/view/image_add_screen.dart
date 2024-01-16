import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_demo/utilits/utils.dart';
import 'package:firebase_demo/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ImageAddingScreen extends StatefulWidget {
  const ImageAddingScreen({super.key});

  @override
  State<ImageAddingScreen> createState() => _ImageAddingScreenState();
}

class _ImageAddingScreenState extends State<ImageAddingScreen> {
  bool loading = false;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  DatabaseReference databaseReference = FirebaseDatabase.instance.ref("post");
  File? image;
  final picker = ImagePicker();
  Future imagefromgaller() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {
        print("no images picked");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Image"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: InkWell(
                onTap: () {
                  imagefromgaller();
                },
                child: Container(
                  height: 200,
                  width: 200,
                  child: image != null
                      ? Image.file(image!.absolute)
                      : Icon(Icons.image),
                  decoration: BoxDecoration(border: Border.all()),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            RoundButton(
              buttoncolor: Colors.deepPurple,
              textcolor: Colors.white,
              title: "Add photo",
              ontap: () async {
                setState(() {
                  loading = true;
                });
                firebase_storage.Reference ref = firebase_storage
                    .FirebaseStorage.instance
                    .ref("/Adhin/" + DateTime.now().microsecondsSinceEpoch.toString());
                firebase_storage.UploadTask uploadTask =
                    ref.putFile(image!.absolute);
                Future.value(uploadTask).then((value) {
                  var newUrl = ref.getDownloadURL();

                  databaseReference
                      .child("1")
                      .set({'id': "1212", 'titile': newUrl.toString()}).then(
                          (value) {
                    setState(() {
                      Utils().toastmessage("Photo uploaded");
                      loading = false;
                    });
                  }).onError((error, stackTrace) {
                    Utils().toastmessage(error.toString());
                    setState(() {
                      loading = false;
                    });
                  });
                }).onError((error, stackTrace) {
                  Utils().toastmessage(error.toString());
                  setState(() {
                    loading = false;
                  });
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
