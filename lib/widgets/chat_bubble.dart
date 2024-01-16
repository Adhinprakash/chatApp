import 'package:firebase_demo/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool iscurrentUser;
  const ChatBubble({super.key, required this.message, required this.iscurrentUser});

  @override
  Widget build(BuildContext context) {
    bool isDarkmode=Provider.of<ThemeProvider>(context,listen: false).isDarkmode;
    return Container(
      decoration: BoxDecoration(
        color: iscurrentUser?
    
        (isDarkmode?Colors.green.shade600:Colors.green.shade500)
        :(isDarkmode?Colors.grey.shade800:Colors.grey.shade200),
        borderRadius: BorderRadius.circular(14)
      ),
      padding: const EdgeInsets.all(16),
      
      margin: const EdgeInsets.symmetric(vertical: 2.5,horizontal: 25),
      child: Text(message,style:  TextStyle(color:iscurrentUser?Colors.white:(isDarkmode?Colors.white:Colors.black),),
    ) );
  }
}