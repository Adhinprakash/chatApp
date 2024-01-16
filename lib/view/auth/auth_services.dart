import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authservices{
  // sign in

  final FirebaseAuth _auth=FirebaseAuth.instance;
 final FirebaseFirestore _firestore=FirebaseFirestore.instance;


 User? getcurrentuser(){
  return _auth.currentUser;
 }
  Future<UserCredential>signinwithEmailpassword(String email,password)async{
try {
 
 
    UserCredential userCredential= await
        _auth.signInWithEmailAndPassword(
            email: email,
            password: password);
            _firestore.collection('users').doc(userCredential.user!.uid).set({
  'uid':userCredential.user!.uid,
  'email':email
});
            return userCredential;
}on FirebaseAuthException catch (e){
throw Exception(e.code);
}
  }



  // signup

  Future<UserCredential>signupwithEmailPassword(String email,password)async{
try {
 
 
    UserCredential userCredential= await
        _auth.createUserWithEmailAndPassword(
            email: email,
            password: password);
_firestore.collection('users').doc(userCredential.user!.uid).set({
  'uid':userCredential.user!.uid,
  'email':email
});

            return userCredential;
}on FirebaseAuthException catch (e){
throw Exception(e.code);
}
  }
}