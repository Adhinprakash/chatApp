import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  const RoundButton({super.key, this.ontap, required this.buttoncolor, required this.textcolor, required this.title, this.loading=false});
final VoidCallback? ontap;
final Color?  buttoncolor;
final Color? textcolor;  
final String title;
final bool loading;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:ontap ,
      child: Container(
        
       height: 50,
       width:400 ,
        decoration: BoxDecoration(

            color: buttoncolor, borderRadius: BorderRadius.circular(8),border: Border.all(color: Colors.deepPurple)),
        child:  Center(
          child: 
          loading ?  const CircularProgressIndicator(strokeWidth: 4,color: Colors.white,)
         : Text(
            title,
            style: TextStyle(
                color: textcolor, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
