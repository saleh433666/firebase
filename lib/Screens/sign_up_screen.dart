import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/Screens/sign_up_screen.dart';
import '../widgets/custom_text_form_filed.dart';
class SignUP extends StatefulWidget {
  const SignUP({super.key});
  @override
  State<SignUP> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignUP> {
   TextEditingController email= TextEditingController();
   TextEditingController pass= TextEditingController();
   TextEditingController name= TextEditingController();
  final GlobalKey<FormState> _globalkey= GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.amber,
      body: Form(
        key: _globalkey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Container(
                height: MediaQuery.of(context).size.height*.2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image(image:AssetImage("images/icons/cart.png")),
                      Positioned(
                          bottom: 0,
                          child: Text("Buy it",style: TextStyle(fontFamily: "pacifico",fontSize: 25),))
                    ],
                  ),
                ),
              ),
            ),
           CustomText("Enter your name", Icons.person, name),
            SizedBox(height: 50,),
           CustomText("Enter your email", Icons.email,email,),
            SizedBox(
              height: 50,
            ),
          CustomText("Enter your password", Icons.lock,pass),
            SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 120.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(50)
                ),
                alignment: Alignment.center,

                child: TextButton(
                  onPressed: () async {
                    _globalkey.currentState!.validate();
                    try {
                      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: email.text,
                        password: pass.text,
                      );
                      FirebaseAuth.instance.currentUser!.sendEmailVerification();
                      Navigator.of(context).pushReplacementNamed("LoginScreen");
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        print('The password provided is too weak.');
                        AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            title: 'Error',
                            desc: 'e password provided is too weak.',
                            btnCancelOnPress: () {},
                    btnOkOnPress: () {},
                    )..show();
                      } else if (e.code == 'email-already-in-use') {
                        print('The account already exists for that email.');
                        AwesomeDialog(
                        context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.rightSlide,
                    title: 'Error',
                    desc: 'the account already exists for that email.',
                    btnCancelOnPress: () {},
                    btnOkOnPress: () {},
                    )..show();
                      }
                    } catch (e) {
                      print(e);
                    }
                    },
                  child: Text("sign",style: TextStyle(color: Colors.white,),),
                ),
              ),
            ),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(" Have an account",style: TextStyle(color: Colors.white,fontSize: 16),),
                TextButton(onPressed: (){Navigator.pushReplacementNamed(context, "LoginScreen");}, child: Text("Login",style: TextStyle(color: Colors.black,fontSize: 16),)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
