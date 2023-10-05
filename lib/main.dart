import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:untitled/Screens/LoginScreen.dart';
import 'package:untitled/Screens/sign_up_screen.dart';
import 'Screens/home_page.dart';
import 'categories/add.dart';
main ()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  runApp(const MyApp());
}
class MyApp extends StatefulWidget{
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp>{
  @override
  void initState() {
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return    MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.lightGreen,
          titleTextStyle: TextStyle(fontSize: 15,color: Colors.deepOrange),
          iconTheme: IconThemeData(color: Colors.red)
        )
      ),
      debugShowCheckedModeBanner: false,
      home: FirebaseAuth.instance.currentUser != null && FirebaseAuth.instance.currentUser!.emailVerified ? HomePage() : LoginScreen(),
      routes: {
        "LoginScreen":(context)=>LoginScreen(),
        "SignUP":(context) => SignUP(),
        "HomePage":(context)=> HomePage(),
        "AddCategories":(context) => AddCategories(),
      },

    );

  }
}