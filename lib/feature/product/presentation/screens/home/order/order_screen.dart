import 'package:flutter/material.dart';

import '../../../../../../core/asset_constants.dart' as asset;
import 'completed_order.dart';
import 'ongoing_order.dart';

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: SafeArea(
              child: AppBar(
                elevation: 2,
                primary: false,
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                titleSpacing: 10,
                title: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Image.asset(asset.logo1),
                    ),
                    const Text(
                      'My Order',
                      style: TextStyle(
                          color: asset.buttoncolour,
                          fontFamily: 'Ubuntu',
                          fontSize: 20),
                    )
                  ],
                ),
                actions: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.search,
                        color: Colors.black54,
                        size: 30,
                      ))
                ],
                bottom: TabBar(
                  indicatorColor: Colors.grey.shade800,
                  indicatorWeight: 3,
                  unselectedLabelColor: Colors.grey,
                  labelStyle: asset.introStyles(20),
                  labelColor: asset.buttoncolour,
                  tabs: [
                    Tab(
                        icon: Text(
                      'Ongoing',
                      style: asset.introStyles(18),
                    )),
                    Tab(
                        icon: Text(
                      'Completed',
                      style: asset.introStyles(18),
                    )),
                  ],
                ),
              ),
            )),
        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: OnGoingOrder(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: CompletedOrder(),
            )
          ],
        ),
      ),
    );
  }
}
