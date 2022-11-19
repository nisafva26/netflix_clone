/*import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:netflix_app/view/home/widgets/bottom_navbar.dart';


class ScreenSplash extends StatefulWidget {
  const ScreenSplash({Key? key}) : super(key: key);

  @override
  _ScreenSplashState createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    navigatorHome();
  }

  navigatorHome() async {
    await Future.delayed(
      const Duration(seconds: 5),
    );
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const NetflixBottomNav(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Lottie.asset("assets/splashLogo/data.json"),
          ),
        ],
      ),
    );
  }
}
*/