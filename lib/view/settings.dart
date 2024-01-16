import 'package:firebase_demo/provider/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: 
      AppBar(
        centerTitle: true,
        title: const Text("Settings"),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),

      body: Container(
        margin: EdgeInsets.all(25),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,

borderRadius: BorderRadiusDirectional.circular(12)        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Dark Mode"),
        
            CupertinoSwitch(value: Provider.of<ThemeProvider>(context,listen: false).isDarkmode,
            onChanged: (value)=>Provider.of<ThemeProvider>(context,listen: false).toggletheme(),)
          ],
        ),
      ),
    );
  }
}