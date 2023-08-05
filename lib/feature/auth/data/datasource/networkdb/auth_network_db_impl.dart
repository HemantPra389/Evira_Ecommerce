import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../product/domain/entities/address_entity.dart';
import '../../../../product/domain/entities/profile_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../../../../core/asset_constants.dart' as asset;
import '../../../domain/entities/user_credentail_entity.dart';
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
  Future<String> createUserProfile(Map<String, String> userCredentials,
      BuildContext context, File image) async {
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('user-images')
          .child(_firebaseAuth.currentUser!.uid + '.jpeg');

      final uploadTask = ref.putFile(image);
      final storageSnapshot = await uploadTask.whenComplete(() => null);

      // Get the download URL of the uploaded image
      final imageUrl = await storageSnapshot.ref.getDownloadURL();

      var data = await FirebaseFirestore.instance
          .collection('users')
          .doc(_firebaseAuth.currentUser!.uid)
          .set({
        'fullname': userCredentials['fullname'],
        'nickname': userCredentials['nickname'],
        'DOB': userCredentials['date'],
        'email': userCredentials['email'],
        'gender': userCredentials['gender'],
        'profileImageUrl': imageUrl,
        'address': "",
        "landmark": "",
      });
      Hive.box<ProfileEntity>(asset.hiveprofilebox)
          .put(
              _firebaseAuth.currentUser!.uid,
              ProfileEntity(
                  id: _firebaseAuth.currentUser!.uid,
                  fullname: userCredentials['fullname']!,
                  nickname: userCredentials['nickname']!,
                  email: userCredentials['email']!,
                  dob: userCredentials['date']!,
                  gender: userCredentials['gender']!,
                  imageUrl: imageUrl))
          .then((value) => print("Success"));
      Hive.box<AddressEntity>(asset.hiveaddressbox).put(
          _firebaseAuth.currentUser!.uid,
          AddressEntity(
              id: _firebaseAuth.currentUser!.uid, address: "", landmark: ""));

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
