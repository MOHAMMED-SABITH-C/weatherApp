
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newtok_wether/adminhome.dart';
import 'package:newtok_wether/userhome.dart';
// import 'package:newtok_wether/login.dart';

// class AuthService{
//     final FirebaseFirestore _firestore=FirebaseFirestore.instance();

//     final FirebaseAuth _auth=FirebaseAuth.instance;
// }
class AuthService {
  final String emailAddress;
  final String password;
  final BuildContext context;
  final String role;
  AuthService(this.emailAddress, this.password,String choise, this.context,this.role) {
    
    choise =='register'?createUserWithEmailAndPassword():
    signInWithEmailAndPassword();
    
  }
  createUserWithEmailAndPassword() async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,

      );
      User? user = credential.user;
      if (user != null) {
        await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .set({
            // 'email': emailAddress,
            'role': role,
            // 'createdAt': FieldValue.serverTimestamp(),
          });
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) {
          return role=='Admin'?homepage():Userhome();
        }), (route) => false);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: const Color.fromARGB(255, 51, 53, 53),
            margin: EdgeInsets.all(10),
            content: Text(
              'The password provided is too weak.',
              style: TextStyle(color: Colors.red),
            )));
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: const Color.fromARGB(255, 51, 53, 53),
            margin: EdgeInsets.all(10),
            content: Text(
              'The account already exists for that email.',
              style: TextStyle(color: Colors.red),
            )));
        print('The account already exists for that email.');
      }else if(e.code=='invalid-email'){
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: const Color.fromARGB(255, 51, 53, 53),
            margin: EdgeInsets.all(10),
            content: Text(
              'invalid email.',
              style: TextStyle(color: Colors.red),
            )));
        print(e.code);
      }
    } catch (e) {
      print(e);
    }
  }

  signInWithEmailAndPassword() async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
          User? user = credential.user;
      if (user != null) {
        print("User signed in: ${user.email}");
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        String rolei = userDoc['role'];
      if(rolei==role){

        Navigator.of(context).//pushNamed('/user');
        pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) {
          return rolei=='Admin'?homepage()
          :Userhome();
          // return ProductListPage();
        }), (route) => false);
      }else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: const Color.fromARGB(255, 51, 53, 53),
            margin: EdgeInsets.all(10),
            content: Text(
              'You are not the $role',
              style: TextStyle(color: Colors.red),
            )));
      }
      }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Color.fromARGB(255, 51, 53, 53),
            margin: EdgeInsets.all(10),
            content: Text(
              'No user found for that email.',
              style: TextStyle(color: Colors.red),
            )));
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Color.fromARGB(255, 51, 53, 53),
            margin: EdgeInsets.all(10),
            content: Text(
              'Wrong password provided for that user.',
              style: TextStyle(color: Colors.red),
            )));
        print('Wrong password provided for that user.');
      }
      else if(e.code=='invalid-email'){
         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Color.fromARGB(255, 51, 53, 53),
            margin: EdgeInsets.all(10),
            content: Text(
              'invalid email.',
              style: TextStyle(color: Colors.red),
            )));
        print(e.code);
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Color.fromARGB(255, 51, 53, 53),
            margin: EdgeInsets.all(10),
            content: Text(
              'No user found for that email.',
              style: TextStyle(color: Colors.red),
            )));
        print('No user found for that email.');
        print("Error signing in: $e");
      }
    }
  }
}