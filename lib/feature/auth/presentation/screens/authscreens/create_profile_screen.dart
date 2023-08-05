import 'dart:io';
import 'package:flutter/material.dart';
import '../../../../../core/asset_constants.dart' as asset;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../product/presentation/screens/home/main_home_screen.dart';
import '../../../../product/presentation/widgets/back_app_bar.dart';
import '../../../../product/presentation/widgets/transaction_button.dart';
import '../../bloc/auth_cubit.dart';

class CreateProfileScreen extends StatefulWidget {
  static const routename = '/createprofiescreen';

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  final dropdown_tile_items = ['Male', 'Female', 'Others'];
  String? _dropdown_value;
  bool isImageLoaded = false;
  dynamic image;
  DateTime dateTime = DateTime.now();
  Map<String, String> userProfileCredentials = {
    'fullname': '',
    'nickname': '',
    'date': '',
    'email': '',
    'gender': ''
  };
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: BackAppBar(context, 'Fill Your Profile'),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushNamedAndRemoveUntil(
                context, MainHomeScreen.routename, (route) => false);
          }
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.error),
              backgroundColor: Theme.of(context).errorColor,
            ));
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black87,
                strokeWidth: 7,
              ),
            );
          } else {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: ListView(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 120,
                      width: 120,
                      child: Stack(children: [
                        InkWell(
                          onTap: () {
                            _pickedImage();
                          },
                          child: CircleAvatar(
                            radius: 66,
                            backgroundColor: Colors.black,
                            child: CircleAvatar(
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
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: asset.buttoncolour,
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                              )),
                        )
                      ]),
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
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                hintText: 'Full Name',
                                hintStyle: asset.introStyles(18,
                                    color: Colors.black26),
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
                            validator: (value) {},
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                hintText: 'Nickname',
                                hintStyle: asset.introStyles(18,
                                    color: Colors.black26),
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
                                            colorScheme:
                                                const ColorScheme.light(
                                                    primary: Colors.black87),
                                            buttonTheme: const ButtonThemeData(
                                                textTheme:
                                                    ButtonTextTheme.primary),
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
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${dateTime.day}/${dateTime.month}/${dateTime.year}',
                                    style: asset.introStyles(18,
                                        color: Colors.black87),
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
                              validator: (value) {},
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  suffixIcon: const IconTheme(
                                    child: Icon(Icons.email),
                                    data: IconThemeData(
                                        color: Colors.black26, size: 20),
                                  ),
                                  hintText: 'Email',
                                  hintStyle: asset.introStyles(18,
                                      color: Colors.black26),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                          color: asset.buttoncolour, width: 2)),
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: asset.buttoncolour, width: 2),
                                      borderRadius:
                                          BorderRadius.circular(12)))),
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
                                value: _dropdown_value,
                                isExpanded: true,
                                hint: Text(
                                  'Select Gender',
                                  style: asset.introStyles(20,
                                      color: Colors.black26),
                                ),
                                items: dropdown_tile_items
                                    .map(buildMenuItem)
                                    .toList(),
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
            );
          }
        },
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
              trasaction_fun: () {
                BlocProvider.of<AuthCubit>(context)
                    .createProfile(userProfileCredentials, context, image);
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
