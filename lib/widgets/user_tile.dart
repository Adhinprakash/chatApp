import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String text;
  final void Function() ? ontap;
  const UserTile({super.key, required this.text, this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child:  Container(
        margin: EdgeInsets.symmetric(vertical: 5,horizontal: 25),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          
          borderRadius: BorderRadius.circular(
            12
          ),
          
            color: Colors.grey,
            
        ),
        
        child: Row(
          children: [
            const Icon(Icons.person),
            SizedBox(width: 25,),
            Text(text.toString() )
          ],
        ),
      ),
    )  ;
  }
}