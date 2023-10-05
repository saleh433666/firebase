import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/Text_Form_Add.dart';

class AddCategories extends StatefulWidget {
  const AddCategories({super.key});

  @override
  State<AddCategories> createState() => _AddCategoriesState();
}

class _AddCategoriesState extends State<AddCategories> {
  TextEditingController myname= TextEditingController();
  final GlobalKey<FormState> formstate= GlobalKey<FormState>();
  CollectionReference categories = FirebaseFirestore.instance.collection('categories');
  bool isLoading = false;
  Future<void> addCategory() {
    if(formstate.currentState!.validate()){
      try{
        isLoading = true;
        setState(() {
        });
        Future<DocumentReference<Object?>> response = categories.add({"name" :myname.text,"id" : FirebaseAuth.instance.currentUser!.uid });
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
                    addCategory();
                  }
              )
            ],
          )
      ),
    );
  }
}
