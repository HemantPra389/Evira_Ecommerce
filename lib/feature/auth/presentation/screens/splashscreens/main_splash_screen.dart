import 'package:flutter/material.dart';
import 'package:evira_ecommerce/core/asset_constants.dart' as asset;
import 'package:introduction_screen/introduction_screen.dart';

import '../authscreens/auth_main_screen.dart';

class MainSplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: Future.delayed(const Duration(seconds: 2)),
            builder: (context, snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Image.asset(
                                  asset.logo2,
                                  width: 200,
                                ),
                              ),
                              const CircularProgressIndicator(
                                color: Colors.black87,
                                strokeWidth: 7,
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                            ]),
                      )
                    : IntroductionScreen(
                        showNextButton: true,
                        showDoneButton: true,
                        onDone: () {
                          Navigator.popAndPushNamed(
                              context, AuthMainScreen.routename);
                        },
                        done: const Text(
                          'Done',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 22,
                              fontFamily: 'Ubuntu'),
                        ),
                        dotsDecorator: const DotsDecorator(
                            activeColor: Colors.black87,
                            activeSize:  Size(20, 35)),
                        next: const Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Colors.black54,
                          size: 30,
                        ),
                        pages: [
                          pageviewmodel(
                              'We provide high quality products for you',
                              asset.splash_login),
                          pageviewmodel(
                              'Your satisfaction is our number one priority',
                              asset.splash_check),
                          pageviewmodel(
                              "Let's fulfill your daily needs with Evira right now!",
                              asset.splash_store)
                        ],
                      )));
  }

  PageViewModel pageviewmodel(String title, String image) {
    return PageViewModel(
      titleWidget: Text(title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black,
            fontFamily: 'Ubuntu',
            fontSize: 40,
          )),
      body: '',
      image: Image.asset(
        image,
      ),
      decoration: const PageDecoration(
          imageFlex: 2,
          bodyFlex: 1,
          bodyPadding: EdgeInsets.zero,
          imagePadding:  EdgeInsets.all(10)),
    );
  }
}
