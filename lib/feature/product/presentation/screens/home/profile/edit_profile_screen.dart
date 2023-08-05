import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../domain/entities/profile_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/asset_constants.dart' as asset;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../auth/presentation/bloc/auth_cubit.dart';
import '../../../../../auth/presentation/widgets/back_app_bar.dart';
import '../../../widgets/transaction_button.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final dropdown_tile_items = ['Male', 'Female', 'Others'];
  String? _dropdown_value;
  bool isImageLoaded = false;
  dynamic image;
  String imageUrl = "";
  DateTime dateTime = DateTime.now();
  Map<String, String> userProfileCredentials = {
    'fullname': '',
    'nickname': '',
    'date': '',
    'email': '',
    'gender': '',
  };
  @override
  void initState() {
    var data = Hive.box<ProfileEntity>(asset.hiveprofilebox).values.first;
    _dropdown_value = data.gender;
    imageUrl = data.imageUrl;

    userProfileCredentials['fullname'] = data.fullname;
    userProfileCredentials['nickname'] = data.nickname;
    userProfileCredentials['email'] = data.email;
    userProfileCredentials['date'] = data.dob;
    userProfileCredentials['gender'] = data.gender;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: BackAppBar(context, 'Edit Profile'),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: ListView(
            children: [
              Container(
                alignment: Alignment.center,
                color: Colors.white,
                height: 120,
                width: 120,
                child: InkWell(
                  onTap: () {
                    _pickedImage();
                  },
                  child: imageUrl.isEmpty
                      ? CircleAvatar(
                          radius: 60,
                          child: !isImageLoaded
                              ? Icon(
                                  Icons.camera_alt_outlined,
                                  size: 40,
                                  color: Colors.grey.shade700,
                                )
                              : null,
                          backgroundColor: Colors.white,
                          backgroundImage:
                              isImageLoaded ? FileImage(image!) : null,
                        )
                      : CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(imageUrl),
                        ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .1,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .45,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextFormField(
                      style: asset.introStyles(20),
                      onChanged: (value) {
                        userProfileCredentials['fullname'] = value;
                      },
                      initialValue: userProfileCredentials['fullname'],
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          hintText: "Fullname",
                          hintStyle:
                              asset.introStyles(18, color: Colors.black26),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  color: asset.buttoncolour, width: 2)),
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: asset.buttoncolour, width: 2),
                              borderRadius: BorderRadius.circular(12))),
                    ),
                    TextFormField(
                      style: asset.introStyles(20),
                      onChanged: (value) {
                        userProfileCredentials['nickname'] = value;
                      },
                      initialValue: userProfileCredentials['nickname'],
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          hintText: 'Nickname',
                          hintStyle:
                              asset.introStyles(18, color: Colors.black26),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  color: asset.buttoncolour, width: 2)),
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: asset.buttoncolour, width: 2),
                              borderRadius: BorderRadius.circular(12))),
                    ),
                    InkWell(
                      onTap: () async {
                        await showDatePicker(
                                context: context,
                                initialDate: dateTime,
                                builder: (context, child) {
                                  return Theme(
                                    data: ThemeData.light().copyWith(
                                      colorScheme: const ColorScheme.light(
                                          primary: Colors.black87),
                                      buttonTheme: const ButtonThemeData(
                                          textTheme: ButtonTextTheme.primary),
                                    ),
                                    child: child!,
                                  );
                                },
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100))
                            .then((value) {
                          if (value != null) {
                            setState(() {
                              dateTime = value;
                              userProfileCredentials['date'] =
                                  '${dateTime.day}/${dateTime.month}/${dateTime.year}';
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                              "No Date selected",
                              style: asset.introStyles(18),
                            )));
                          }
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.only(
                            top: 20, right: 15, bottom: 20, left: 10),
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              userProfileCredentials['date']!.isEmpty
                                  ? '${dateTime.day}/${dateTime.month}/${dateTime.year}'
                                  : userProfileCredentials['date']!.toString(),
                              style:
                                  asset.introStyles(18, color: Colors.black87),
                            ),
                            const Icon(
                              Icons.cake,
                              color: Colors.black26,
                              size: 20,
                            )
                          ],
                        ),
                      ),
                    ),
                    TextFormField(
                        style: asset.introStyles(20),
                        onChanged: (value) {
                          userProfileCredentials['email'] = value;
                        },
                        validator: (value) {
                          String pattern =
                              r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                              r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                              r"{0,253}[a-zA-Z0-9])?)*$";
                          RegExp regex = RegExp(pattern);
                          if (value == null ||
                              value.isEmpty ||
                              !regex.hasMatch(value)) {
                            return 'Enter a valid email address';
                          } else {
                            return null;
                          }
                        },
                        initialValue: userProfileCredentials['email'],
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            suffixIcon: const IconTheme(
                              child: Icon(Icons.email),
                              data: IconThemeData(
                                  color: Colors.black26, size: 20),
                            ),
                            hintText: 'Email',
                            hintStyle:
                                asset.introStyles(18, color: Colors.black26),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                    color: asset.buttoncolour, width: 2)),
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: asset.buttoncolour, width: 2),
                                borderRadius: BorderRadius.circular(12)))),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      width: double.infinity,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          iconEnabledColor: Colors.black26,
                          value: userProfileCredentials['gender']!.isEmpty
                              ? _dropdown_value
                              : userProfileCredentials['gender'],
                          isExpanded: true,
                          hint: Text(
                            'Select Gender',
                            style: asset.introStyles(20, color: Colors.black26),
                          ),
                          items:
                              dropdown_tile_items.map(buildMenuItem).toList(),
                          onChanged: (value) {
                            setState(() {
                              _dropdown_value = value;
                              if (value != null) {
                                userProfileCredentials['gender'] = value;
                              } else {
                                userProfileCredentials['gender'] = 'Male';
                              }
                            });
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: mediaQuery.height * .1,
        child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  color: Colors.blueGrey.shade100,
                  offset: Offset(-1, 0),
                  spreadRadius: 1,
                  blurRadius: 1)
            ]),
            child: TransactionButton(
              mediaQuery: mediaQuery.width * .9,
              title: 'Continue',
              suffixIcon: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white,
                size: 18,
              ),
              trasaction_fun: () async {
                try {
                  final ref = FirebaseStorage.instance
                      .ref()
                      .child('user-images')
                      .child(FirebaseAuth.instance.currentUser!.uid + '.jpeg');

                  final uploadTask = ref.putFile(image);
                  final storageSnapshot =
                      await uploadTask.whenComplete(() => null);

                  // Get the download URL of the uploaded image
                  final imageUrl = await storageSnapshot.ref.getDownloadURL();

                  var data = await FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .set({
                    'fullname': userProfileCredentials['fullname'],
                    'nickname': userProfileCredentials['nickname'],
                    'DOB': userProfileCredentials['date'],
                    'email': userProfileCredentials['email'],
                    'gender': userProfileCredentials['gender'],
                    'profileImageUrl': imageUrl,
                    'address': "",
                    "landmark": "",
                  });
                  Hive.box<ProfileEntity>(asset.hiveprofilebox)
                      .put(
                          FirebaseAuth.instance.currentUser!.uid,
                          ProfileEntity(
                              id: FirebaseAuth.instance.currentUser!.uid,
                              fullname: userProfileCredentials['fullname']!,
                              nickname: userProfileCredentials['nickname']!,
                              email: userProfileCredentials['email']!,
                              dob: userProfileCredentials['date']!,
                              gender: userProfileCredentials['gender']!,
                              imageUrl: imageUrl))
                      .then((value) => print("Success"));
                } on FirebaseException catch (error) {
                  print(error.message.toString());
                } catch (error) {
                  print(error.toString());
                }
              },
            )),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: asset.introStyles(20, color: Colors.black87),
        ),
      );
  Future<void> _pickedImage() async {
    /*
    *For Picking the file from any source which can be gallery or camera the syntax written below which returns us the future 
    *we just have to put the file inside the image by just creating a file of the pickedimagefile.path 
     */
    var pickedImageFile = await ImagePicker.platform
        .getImage(source: ImageSource.gallery, imageQuality: 40, maxWidth: 150);
    setState(() {
      if (pickedImageFile == null) {
        return;
      }
      image = File(pickedImageFile.path);
      isImageLoaded = true;
    });
  }
}
