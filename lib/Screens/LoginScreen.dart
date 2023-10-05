import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:untitled/Screens/sign_up_screen.dart';
import '../widgets/custom_text_form_filed.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email= TextEditingController();
  TextEditingController pass= TextEditingController();
 final GlobalKey<FormState> _globalkey= GlobalKey<FormState>();
 bool isLoading = false;
  Future signInWithGoogle() async {

    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if(googleUser == null){
      return;
    }
    final GoogleSignInAuthentication? googleAuth = await googleUser.authentication;


    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );


     await FirebaseAuth.instance.signInWithCredential(credential);
    Navigator.of(context).pushNamedAndRemoveUntil("HomePage", (route) => false);
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.amber,
      body:isLoading== true?Center(child: CircularProgressIndicator(),): Form(
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

            CustomText("Enter your email", Icons.email,email),
            SizedBox(
              height: 50,
            ),
            CustomText("Enter your password", Icons.lock,pass),
            SizedBox(height: 10,),
            InkWell(
              onTap: ()async{
                if(email.text == ""){
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.rightSlide,
                    title: 'Error',
                    desc: "Write Your Email",
                    btnCancelOnPress: () {},
                    btnOkOnPress: () {},
                  )..show();
                }
                try{
                  await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.success,
                    animType: AnimType.rightSlide,
                    title: 'Check Your EmailBox',
                    desc: "Check Your EmailBox To Rest Your password",
                    btnCancelOnPress: () {},
                    btnOkOnPress: () {},
                  )..show();
                }catch(e){
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.rightSlide,
                    title: 'Error',
                    desc: "$e",
                    btnCancelOnPress: () {},
                    btnOkOnPress: () {},
                  )..show();
                }
              },
              child: Container(
                margin: EdgeInsets.only(top: 10,bottom: 20),
                alignment: Alignment.topRight,
                child: Text("Forget Password",style: TextStyle(fontSize: 14),),
              ),
            ),
            SizedBox(height: 25,),
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
                      isLoading = true;
                      setState(() {

                      });
                      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: email.text,
                          password: pass.text,
                      );
                      isLoading = false;
                      setState(() {

                      });
                      if(credential.user!.emailVerified){
                        Navigator.of(context).pushReplacementNamed("HomePage");
                      }else{
                        AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            title: 'Check Your Verification',
                            desc: "Your Email Isn't Verification Please Go To Your Email Box And Check The Link",
                            btnCancelOnPress: () {},
                    btnOkOnPress: () {},
                    )..show();
                      }
                    } on FirebaseAuthException catch (e) {
                      isLoading = false;
                      setState(() {});
                      if (e.code == 'user-not-found') {
                        print('No user found for that email.');
                        AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            title: 'Error ',
                            desc: 'No user found for that email',
                            btnCancelOnPress: () {},
                    btnOkOnPress: () {},
                    )..show();
                      } else if (e.code == 'wrong-password') {
                        print('Wrong password provided for that user.');
                        AwesomeDialog(
                        context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.rightSlide,
                    title: 'Error',
                    desc: 'Wrong password provided for that user',
                    btnCancelOnPress: () {},
                    btnOkOnPress: () {},
                    )..show();
                      }
                    }
                    },
                  child: Text("login",style: TextStyle(color: Colors.white,),),),
              ),
            ),
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 120.0),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.red[700],
                      borderRadius: BorderRadius.circular(50)
                  ),
                  alignment: Alignment.center,
                  child: TextButton(onPressed: (){
                    signInWithGoogle();
                  },
                      child: Text("Login With Google",style: TextStyle(color: Colors.white,))
                  )
              ),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account",style: TextStyle(color: Colors.white,fontSize: 16),),
    TextButton(onPressed: (){Navigator.pushReplacementNamed(context, "SignUP");}, child: Text("Signup",style: TextStyle(color: Colors.black,fontSize: 16),)),
              ]
            ),
          ],
        ),
      ),
    );
  }
}