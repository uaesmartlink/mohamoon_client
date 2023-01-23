import 'package:flutter/material.dart';
import 'package:client_mohamoon/app/routes/app_pages.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:client_mohamoon/app/utils/constants/style_constants.dart';

class MySplashScreen extends StatelessWidget {
  final bool isUserLogin;

  const MySplashScreen({required this.isUserLogin, super.key});

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 3,
      photoSize: MediaQuery.of(context).size.width / 2.5,
      navigateAfterSeconds: isUserLogin ? AppPages.HOME : AppPages.OnBoarding,
      image: Image.asset("assets/icons/splash.gif"),
      gradientBackground: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Constants.primaryColor,
          Constants.secondaryColor,
        ],
      ),
      useLoader: false,
      title: Text(''),
      loadingTextPadding: EdgeInsets.zero,
      styleTextUnderTheLoader: TextStyle(),
      loadingText: Text(''),
      backgroundColor: Color(0xFF1b4170),
    );
  }
}
