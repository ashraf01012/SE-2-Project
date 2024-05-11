import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void signout(){
FirebaseAuth.instance.signOut();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
        title: const Text('E-Commerce',style: TextStyle(color: Colors.white)),
        actions: [
         IconButton(onPressed: signout, icon:const Icon( Icons.logout,color: Colors.white,)),
        ],
      ),
    );
  }
}