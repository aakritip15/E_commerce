import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '/services/database_service.dart';
import 'package:flutter/material.dart';

class AuthService {
  Future<String?> SignIn(
      {required String emailText, required String passwordText}) async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailText, password: passwordText);
      print('success');
      return 'success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future<String?> CreateAccount({
    required String name,
    required String emailText,
    required String numberText,
    required String addressText,
    required String passwordText,
  }) async {
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailText, password: passwordText);
      DatabaseService().addUser(
          name: name,
          email: emailText,
          number: numberText,
          address: addressText);
    } catch (e) {
      print('error');
      return 'error adding user';
    }
  }

  Future<String?> Reset({required String emailId}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailId);
      return 'success';
    } catch (e) {
      throw e;
    }
  }

  Future<String?> SignOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return 'success';
    } catch (e) {
      return 'error';
    }
  }
}
