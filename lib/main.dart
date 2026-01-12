import 'package:blooddonation/screens/add.dart';
import 'package:blooddonation/screens/homescreen.dart';
import 'package:blooddonation/screens/update.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Demo App",
      routes: {
        '/':(context) => Homescreen(),
        '/add':(context)=>AddUser(),
        '/update':(context)=>UpdateDonor(),
      },
      initialRoute: '/',
    );
  }
}