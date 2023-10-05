import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/Text_Form_Add.dart';

class EditCategory extends StatefulWidget {
  final String docid;
  final String oldname;
  const EditCategory({super.key, required this.docid, required this.oldname});
  @override
  State<EditCategory> createState() => _EditCategoryState();
}
class _EditCategoryState extends State<EditCategory> {
  TextEditingController myname= TextEditingController();
  final GlobalKey<FormState> formstate= GlobalKey<FormState>();
  CollectionReference categories = FirebaseFirestore.instance.collection('categories');
  bool isLoading = false;
   EditCategory()async {
    if(formstate.currentState!.validate()){
      try{
        isLoading = true;
        setState(() {
        });
       await categories.doc(widget.docid).update({
         "name": myname.text,//"id" : FirebaseAuth.instance.currentUser!.uid(في حاله set)
       });
        Navigator.of(context).pushNamedAndRemoveUntil("HomePage", (route) => false);
      }catch(e){
        isLoading = false;
        setState(() {
        });
        print(e);
      }
    }
    return categories
        .add({
      'name': myname.text,
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    myname.dispose();
  }
  @override
  void initState() {
    super.initState();
    myname.text = widget.oldname;
  }
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: Form(
          key:formstate ,
          child:isLoading==true?Center(child: CircularProgressIndicator(),): ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:25,vertical: 20),
                child: CustomTextAdd("Enter Your Name",  myname),
              ),
              MaterialButton(
                  child: Icon(Icons.add,size: 40,color: Colors.orange,),
                  onPressed: (){
                    EditCategory();
                  }
              )
            ],
          )
      ),
    );
  }
}
