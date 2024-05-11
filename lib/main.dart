import 'package:auth_module/auth/auth.dart';
import 'package:auth_module/firebase_options.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{//for initializing the firebase
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  MaterialApp materialApp = MaterialApp(
    builder: DevicePreview.appBuilder,//to make your app inside responsiveness
    useInheritedMediaQuery: true,
    debugShowCheckedModeBanner: false,

     home:const AuthPage(),
  );
  runApp(DevicePreview(//to make your app responsive 
    enabled: true,
    builder: (context) => materialApp, // Wrap your app
  ),);
}
