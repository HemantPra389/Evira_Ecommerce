import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../widgets/back_app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/asset_constants.dart' as asset;

import '../../../widgets/cart_product_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _searchText = "";
  late FocusNode _searchFocusNode;
  @override
  void initState() {
    super.initState();

    _searchFocusNode = FocusNode();
    // Give focus to the TextFormField when the screen loads
    _searchFocusNode.requestFocus();
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var firebasefirestore = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: BackAppBar(context, "Search"),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(
              decelerationRate: ScrollDecelerationRate.fast),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: mediaQuery.width * .04,
                    right: mediaQuery.width * .04,
                    top: mediaQuery.height * .02,
                    bottom: mediaQuery.height * .02),
                child: TextFormField(
                  focusNode: _searchFocusNode,
                  onChanged: (value) {
                    setState(() {
                      _searchText = value;
                    });
                  },
                  style: asset.introStyles(20),
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      prefixIcon: IconTheme(
                        data: const IconThemeData(color: Colors.grey, size: 30),
                        child: const Icon(Icons.search_rounded),
                      ),
                      hintText: 'Search',
                      prefixIconColor: Colors.grey,
                      hintStyle: asset.introStyles(18, color: Colors.black45),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: asset.buttoncolour, width: 1.5)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: asset.buttoncolour, width: 1.5)),
                      filled: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12))),
                ),
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('products')
                    .where('title',
                        isGreaterThanOrEqualTo: _searchText.toLowerCase(),
                        isLessThan: _searchText.toLowerCase() + 'z')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.black87,
                        strokeWidth: 7,
                      ),
                    );
                  } else if (snapshot.hasData && snapshot.data!.size != 0) {
                    return ListView(
                      physics: BouncingScrollPhysics(
                          decelerationRate: ScrollDecelerationRate.fast),
                      shrinkWrap: true,
                      children: snapshot.data!.docs.map((document) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: CartProductCard(
                            id: document['id'],
                            rating: document['rating'].toString(),
                            sold: document['sold'].toString(),
                            imageUrl: document['imageUrls'][0],
                            title: document['title'],
                            price: document['price'].toString(),
                          ),
                        );
                      }).toList(),
                    );
                  } else {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(asset.empty_cart_error, width: 300),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'No products found',
                            textAlign: TextAlign.center,
                            style: asset.introStyles(22, color: Colors.black54),
                          ),
                        ],
                      ),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
