import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_demo/utilits/utils.dart';
import 'package:firebase_demo/view/auth/auth_services.dart';
import 'package:firebase_demo/view/auth/login_with_phone.dart';
import 'package:firebase_demo/view/auth/signup_screen.dart';
import 'package:firebase_demo/view/post/post_screen.dart';
import 'package:firebase_demo/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LogiScreen extends StatefulWidget {
  const LogiScreen({super.key});

  @override
  State<LogiScreen> createState() => _LogiScreenState();
}

class _LogiScreenState extends State<LogiScreen> {
  bool loading = false;
  final _auth = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  void login() {

  Authservices authservices=Authservices();
setState(() {
  loading =true;
});
  try{
authservices.signinwithEmailpassword(emailcontroller.text.toString(), passwordcontroller.text.toString()).then((value) {setState(() {
  loading=false;
});

 Utils().toastmessage(value.user!.email.toString());
  Navigator.push(
          context, MaterialPageRoute(builder: (context) => const PostScreen()));
});

  }catch(e){
loading=false;

  }
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [


              SizedBox(
                height: 200,
                width: 200,
                child: Lottie.asset("assets/animations/Animation - 1705480449535.json")),
                SizedBox(height: 20,),
              Form(
                  key: _formkey,
                  child: Column(
                    children: [
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
                            prefixIcon: Icon(Icons.email_outlined),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelStyle: const TextStyle(color: Colors.black),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Colors.black),
                            ),
                            fillColor: Colors.white),
                          
                      ),
                      SizedBox(
                        height: 20,
                      ),
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
                          hintText: "Password",
                            prefixIcon: const Icon(Icons.lock_open),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelStyle: const TextStyle(color: Colors.black),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Colors.black),
                            ),
                            fillColor: Colors.white),
                      ),
                    ],
                  )),
              SizedBox(
                height: 20,
              ),
              RoundButton(
                  loading: loading,
                  buttoncolor: Theme.of(context).colorScheme.primary,
                  textcolor: Colors.white,
                  title: "Login",
                  ontap: () {
                    if (_formkey.currentState!.validate()) {
                    login();
                    }
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account"),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Signupscreen()));
                      },
                      child: const Text("SignUp",style: TextStyle(color: Colors.grey),))
                ],
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: (){
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginWithPhonenumber()));
                },
                child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.black)),
                    child: const Center(
                        child: Text(
                      "Login with Phonenumber",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w600),
                    ))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
