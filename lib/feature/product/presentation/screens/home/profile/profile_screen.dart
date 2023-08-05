import '../../../../../auth/presentation/screens/authscreens/auth_screen.dart';
import '../../../../domain/entities/profile_entity.dart';
import 'address_screen.dart';
import 'edit_profile_screen.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/asset_constants.dart' as asset;
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../widgets/default_app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: DefaultAppBar('Profile'),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 42,
                ),
                ValueListenableBuilder(
                  valueListenable: Hive.box<ProfileEntity>(asset.hiveprofilebox)
                      .listenable(),
                  builder: (context, profilebox, _) {
                    if (profilebox
                        .containsKey(FirebaseAuth.instance.currentUser!.uid)) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 120,
                            width: 120,
                            child: Stack(children: [
                              CircleAvatar(
                                radius: 60,
                                backgroundImage: NetworkImage(
                                    profilebox.values.first.imageUrl),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                        color: asset.buttoncolour,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: const Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    )),
                              )
                            ]),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            profilebox.values.first.fullname,
                            style: asset.introStyles(24),
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          SizedBox(
                            height: 120,
                            width: 120,
                            child: Stack(children: [
                              const CircleAvatar(
                                radius: 60,
                                backgroundImage: NetworkImage(
                                    "https://cdn.pixabay.com/photo/2021/04/25/14/30/man-6206540_1280.jpg"),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                        color: asset.buttoncolour,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: const Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    )),
                              )
                            ]),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Andrew Ainsley',
                            style: asset.introStyles(24),
                          ),
                        ],
                      );
                    }
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                    child: ListView(
                  children: [
                    setting_btn("Edit Profile", () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EditProfileScreen(),
                      ));
                    }, Icons.person),
                    setting_btn("Address", () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AddressScreen(),
                      ));
                    }, Icons.location_pin),
                    setting_btn(
                        "Privacy Policy", () {}, Icons.lock_outline_rounded),
                    setting_btn("Help Center", () {}, Icons.help),
                    setting_btn(
                        "Invite Friends", () {}, Icons.group_add_outlined),
                    GestureDetector(
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.of(context)
                            .popAndPushNamed(AuthScreen.routename);
                      },
                      child: ListTile(
                        minLeadingWidth: 0,
                        leading: Icon(Icons.logout_rounded,
                            size: 30, color: Colors.red.shade300),
                        title: Text(
                          'Logout',
                          style:
                              asset.introStyles(18, color: Colors.red.shade300),
                        ),
                      ),
                    )
                  ],
                ))
              ],
            ),
          ),
        ));
  }

  GestureDetector setting_btn(
    String title,
    VoidCallback fun,
    IconData leadingIcon,
  ) {
    return GestureDetector(
      onTap: fun,
      child: ListTile(
        visualDensity: const VisualDensity(vertical: -2),
        minLeadingWidth: 0,
        leading: Icon(
          leadingIcon,
          size: 24,
          color: Colors.black54,
        ),
        title: Text(
          title,
          style: asset.introStyles(18),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          color: Colors.black54,
        ),
      ),
    );
  }
}
