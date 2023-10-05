import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextAdd extends StatelessWidget {
  final String hint;

  final TextEditingController mycontroller;

  CustomTextAdd(this.hint, this.mycontroller);

  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        controller: mycontroller,
        validator: (val) {
          if (val!.isEmpty) {
            return "$hint";
          }
        },
        decoration: InputDecoration(
            hintText: hint,
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