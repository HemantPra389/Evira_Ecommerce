import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../domain/entities/address_entity.dart';
import '../../../widgets/back_app_bar.dart';
import '../../../widgets/transaction_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/asset_constants.dart' as asset;
import 'package:hive/hive.dart';

import '../../../../domain/entities/profile_entity.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  String landmark = "";
  String address = "";

  @override
  void initState() {
    var data = Hive.box<AddressEntity>(asset.hiveaddressbox).values.first;

    landmark = data.landmark;
    address = data.address;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: BackAppBar(context, "Edit Address"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            SizedBox(
              height: 12,
            ),
            TextFormField(
              style: asset.introStyles(20),
              onChanged: (value) {
                setState(() {
                  landmark = value;
                });
              },
              initialValue: landmark,
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  hintText: "Landmark",
                  hintStyle: asset.introStyles(18, color: Colors.black26),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                          color: asset.buttoncolour, width: 1.5)),
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12))),
            ),
            SizedBox(
              height: 12,
            ),
            TextFormField(
              style: asset.introStyles(20),
              onChanged: (value) {
                setState(() {
                  address = value;
                });
              },
              initialValue: address,
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  hintText: 'Address',
                  hintStyle: asset.introStyles(18, color: Colors.black26),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                          color: asset.buttoncolour, width: 1.5)),
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12))),
            ),
          ],
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
                Hive.box<AddressEntity>(asset.hiveaddressbox).put(
                    FirebaseAuth.instance.currentUser!.uid,
                    AddressEntity(
                        id: FirebaseAuth.instance.currentUser!.uid,
                        address: address,
                        landmark: landmark));
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .update({'address': address, "landmark": landmark});
              },
            )),
      ),
    );
  }
}
