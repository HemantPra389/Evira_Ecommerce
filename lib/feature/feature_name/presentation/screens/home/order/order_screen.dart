import 'package:evira_shop/feature/feature_name/presentation/screens/home/order/completed_order.dart';
import 'package:evira_shop/feature/feature_name/presentation/screens/home/order/ongoing_order.dart';
import 'package:evira_shop/feature/feature_name/presentation/widgets/default_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:evira_shop/core/asset_constants.dart' as asset;

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
            child: SafeArea(
              child: Container(
                child: AppBar(
                  elevation: 0,
                  primary: false,
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.transparent,
                  titleSpacing: 10,
                  title: Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Image.asset(asset.logo1),
                      ),
                      Text(
                        'My Order',
                        style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'Ubuntu',
                            fontSize: 23),
                      )
                    ],
                  ),
                  actions: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
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
                    labelColor: Colors.black,
                    tabs: [
                      Tab(
                          icon: Text(
                        'Ongoing',
                      )),
                      Tab(
                          icon: Text(
                        'Completed',
                      )),
                    ],
                  ),
                ),
              ),
            ),
            preferredSize: const Size.fromHeight(100)),
        body: TabBarView(
          children: [OnGoingOrder(), CompletedOrder()],
        ),
      ),
    );
  }
}
