import 'package:auth_module/auth/login_or_register.dart';
import 'package:auth_module/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import'package:flutter/material.dart';
class AuthPage extends StatelessWidget {
  const AuthPage({super.key});


  @override
  Widget build(BuildContext context) {//for firebase auth
    return Scaffold(
body:StreamBuilder(
stream: FirebaseAuth.instance.authStateChanges(),//that line makes the action of transfering into the home page
  builder: (context , snapshot){                 //and also when i did not logged out it still logged in
//user logged in
if(snapshot.hasData){
  return const HomePage();
}
//useris not logged in
else{
return const LoginOrRegister();
}

},)
    );
  }
}