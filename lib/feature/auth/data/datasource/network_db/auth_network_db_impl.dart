import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evira_shop/feature/auth/domain/entities/user_credentail_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'auth_network_db.dart';

class AuthNetworkDBImpl implements AuthNetworkDB {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String? _verificationId;
  @override
  Future<String> createUser(
      UserCredentialEntity userCredentialEntity, BuildContext context) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: userCredentialEntity.email,
          password: userCredentialEntity.password);
      return "Success";
    } on FirebaseException catch (error) {
      return error.message.toString();
    } catch (error) {
      return error.toString();
    }
  }

  @override
  Future<String> createUserProfile(Map<String, String> usercredentials,
      BuildContext context, File image) async {
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('user-images')
          .child(_firebaseAuth.currentUser!.uid + '.jpeg');
      ref.putFile(image).whenComplete(() => null);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_firebaseAuth.currentUser!.uid)
          .set({
        'fullname': usercredentials['fullname'],
        'nickname': usercredentials['nickname'],
        'DOB': usercredentials['date'],
        'email': usercredentials['email'],
        'gender': usercredentials['gender']
      }).then((value) => print('Success'));
      return "Success";
    } on FirebaseException catch (error) {
      return error.message.toString();
    } catch (error) {
      return error.toString();
    }
  }

  @override
  Future<String> loginUser(
      UserCredentialEntity userCredentialEntity, BuildContext context) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: userCredentialEntity.email,
          password: userCredentialEntity.password);
      return "Success";
    } on FirebaseAuthException catch (error) {
      return error.message.toString();
    } catch (e) {
      return e.toString();
    }
  }

  //Phone auth only works when we have google play console developer account
  @override
  Future<String> authsendOTP(String phoneNumber) async {
    String returnStatus = "";
    print(phoneNumber);
    await _firebaseAuth
        .verifyPhoneNumber(
      phoneNumber: phoneNumber.toString(),
      codeSent: (verificationId, forceResendingToken) {
        _verificationId = verificationId;
        returnStatus = "AuthCodeSent";
      },
      verificationCompleted: (phoneAuthCredential) async {
        returnStatus = await signInWithPhone(phoneAuthCredential);
      },
      verificationFailed: (error) {
        returnStatus = error.message.toString();
      },
      codeAutoRetrievalTimeout: (verificationId) {
        _verificationId = verificationId;
      },
    )
        .then((value) {
      return returnStatus;
    });
    return returnStatus;
  }

  @override
  Future<String> authverifyOTP(int otp) async {
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: _verificationId!, smsCode: otp.toString());
    return await signInWithPhone(phoneAuthCredential);
  }

  Future<String> signInWithPhone(
      PhoneAuthCredential phoneAuthCredential) async {
    try {
      await _firebaseAuth.signInWithCredential(phoneAuthCredential);
      return "Success";
    } on FirebaseAuthException catch (error) {
      return error.message.toString();
    }
  }

  @override
  Future<String> forgotpassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return "Success";
    } on FirebaseAuthException catch (error) {
      return error.message.toString();
    }
  }
}
