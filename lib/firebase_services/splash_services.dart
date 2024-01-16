import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_demo/view/auth/login_screen.dart';
import 'package:firebase_demo/view/firestore/firestore_list_screen.dart';
import 'package:firebase_demo/view/image_add_screen.dart';
import 'package:firebase_demo/view/post/post_screen.dart';
import 'package:flutter/material.dart';

class SplashService{
  void islogin(BuildContext context){


final  _auth = FirebaseAuth.instance;
final  user=_auth.currentUser;

if(user!=null){
Timer(const Duration(seconds: 3), ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>const PostScreen())));


}else{
Timer(const Duration(seconds: 3), ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>const LogiScreen())));

}

  }
}