import 'package:firebase_demo/utilits/utils.dart';
import 'package:firebase_demo/view/auth/auth_services.dart';
import 'package:firebase_demo/view/auth/login_screen.dart';
import 'package:firebase_demo/view/post/post_screen.dart';
import 'package:firebase_demo/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';
class Signupscreen extends StatefulWidget {
  const Signupscreen({super.key});

  @override
  State<Signupscreen> createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen> {
  bool loading =false;
  final _formkey=GlobalKey<FormState>() ;
  final emailcontroller=TextEditingController();
  final passwordcontroller=TextEditingController();
    final _confirmpasswordcontroller=TextEditingController();
final  _auth=FirebaseAuth.instance;

@override
  void dispose() {
    
    super.dispose();
    emailcontroller.clear();
    passwordcontroller.clear();
  }

   signup(){
 Authservices authservices=Authservices();
    setState(() {
  loading =true;
});

 if(passwordcontroller==_confirmpasswordcontroller){
   try{
authservices.signupwithEmailPassword(emailcontroller.text.toString(), passwordcontroller.text.toString()).then((value) {setState(() {
  loading=false;
});

 Utils().toastmessage(value.user!.email.toString());
  Navigator.push(
          context, MaterialPageRoute(builder: (context) => const PostScreen()));
});

  }catch(e){
loading=false;

  }
 }else{
  Utils().toastmessage("password don't match!");
 }
        // setState(() {
        //                     loading=true;
        //                   });
        //             await   _auth.createUserWithEmailAndPassword(email: emailcontroller.text.toString(), password: passwordcontroller.text.toString()).then((value) {
        //               setState(() {
        //                 loading=false;
        //               });
        //                Navigator.push(
        //   context, MaterialPageRoute(builder: (context) => const PostScreen()));
        //              }).onError((error, stackTrace) {Utils().toastmessage(error.toString());
        //              setState(() {
        //                loading=false;
        //              });
        //              }
                     
        //              );
                     
  }
  @override
  Widget build(BuildContext context) {
    
    return  Scaffold(
     
      
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
             children: [

 SizedBox(
                height: 200,
                width: 300,
                child: Lottie.asset("assets/animations/Animation - 1705482962896.json",)),
                SizedBox(height: 20,),
              
         
              Form(
                key: _formkey,
                child: Column(children: [
                TextFormField(
                  controller: emailcontroller,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Email is required';
                          }
                          return null;
                        },
                        cursorColor: Colors.black,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                         hintText: "Email",
                          border: OutlineInputBorder(
                            
                              borderRadius: BorderRadius.circular(10)),
                        prefixIcon: const Icon(Icons.email),
                          labelStyle: const TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
          
          const SizedBox(height: 20,),
          
TextFormField(
  controller: passwordcontroller,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password is required';
                        }
                        return null;
                      },
                      cursorColor: Colors.black,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                       hintText: "password ",
                        border: OutlineInputBorder(
                          
                            borderRadius: BorderRadius.circular(10)),
                        prefixIcon: const Icon(Icons.lock_open_rounded),
                        labelStyle: const TextStyle(color: Colors.black),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                      
          const SizedBox(height: 20,),
TextFormField(
  controller:_confirmpasswordcontroller,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password is required';
                        }
                        return null;
                      },
                      cursorColor: Colors.black,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                      hintText: "confirm password ",
                        border: OutlineInputBorder(
                          
                            borderRadius: BorderRadius.circular(10)),
                        prefixIcon: const Icon(Icons.lock_open_rounded),
                        labelStyle: const TextStyle(color: Colors.black),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                      ),
                    ),

              ],)),
            
                      const SizedBox(height: 20,),

                       RoundButton(
                        loading: loading,
                        buttoncolor: Theme.of(context).colorScheme.primary, textcolor: Colors.white, title: "SignUp",
                       ontap: ()async{
                        if(_formkey.currentState!.validate()){
                      signup();
                        }
                       }),
                         Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      const Text("Already have an account"),
      TextButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>const LogiScreen()));
      }, child: const Text("Login"))
     ],)
    
             ],
          ),
        ),
      ),
    );
  }
}