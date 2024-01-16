

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_demo/provider/theme_provider.dart';
import 'package:firebase_demo/view/splash_screen.dart';
import 'package:firebase_demo/view/themes/light_mode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(create: (context)=>ThemeProvider(),
    child:const MyApp() ,
    )
    
    
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: SplashScreen(),
    );
  }
}
