import 'package:evira_shop/feature/feature_name/presentation/screens/auth/auth_screens/auth_main_screen.dart';
import 'package:flutter/material.dart';
import 'package:evira_shop/core/asset_constants.dart' as asset;
import 'package:introduction_screen/introduction_screen.dart';

class MainSplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: Future.delayed(Duration(seconds: 2)),
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
                              CircularProgressIndicator(
                                color: Colors.black87,
                                strokeWidth: 7,
                              ),
                              SizedBox(
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
                        done: Text(
                          'Done',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 22,
                              fontFamily: 'Ubuntu'),
                        ),
                        dotsDecorator: DotsDecorator(
                            activeColor: Colors.black87,
                            activeSize: Size(20, 35)),
                        next: Icon(
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
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Ubuntu',
            fontSize: 40,
          )),
      body: '',
      image: Image.asset(
        image,
      ),
      decoration: PageDecoration(
          imageFlex: 2,
          bodyFlex: 1,
          bodyPadding: EdgeInsets.zero,
          imagePadding: EdgeInsets.all(10)),
    );
  }
}
