import 'package:flutter/material.dart';
class CustomText extends StatelessWidget{
   final String hint;
   final IconData icon;
   final TextEditingController mycontroller;
   CustomText( this.hint,  this.icon,   this.mycontroller);
  Widget build(BuildContext context) {
    // TODO: implement build
   return  Padding(
     padding: const EdgeInsets.symmetric(horizontal: 20.0),
     child: TextFormField(
       controller: mycontroller,
       validator: (val){
         if(val!.isEmpty){
           return "$hint";
         }
       },
       decoration: InputDecoration(
           hintText:hint,
           prefixIcon: Icon(icon,color: Colors.amber,),
           filled: true,
           fillColor: Colors.white30,
           focusedBorder: OutlineInputBorder(
               borderSide: BorderSide(),
               borderRadius: BorderRadius.circular(25)
           ),
           enabledBorder: OutlineInputBorder(
               borderRadius: BorderRadius.circular(25),
               borderSide: BorderSide(color: Colors.white)
           )
       ),
     ),
   );
  }


}