import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:netflix_app/view/home/details_screen.dart';
import 'package:share_plus/share_plus.dart';

class DynamicLinkServices {
  static Future<String> createDynamicLink(int id) async {
    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse("https://www.netflixclone.com?movieId=${id}"),
      uriPrefix: "https://netflixxx.page.link",
      androidParameters: const AndroidParameters(packageName: "com.example.netflix_app"),
      //iosParameters: const IOSParameters(bundleId: "com.example.app.ios"),
    );
    final dynamicLink = await FirebaseDynamicLinks.instance.buildLink(dynamicLinkParams);

    print('====dynamic link=====');
    print(dynamicLink);

    return dynamicLink.toString();
  }

  static void initDynamicLinks2(BuildContext context) async {
    print('=====getting movie id=======');
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    print('reading data');
    print(data);
    print(data!.utmParameters);
    final Uri movieLink = data.link;
    print('movie id========');
    String movieId2 = movieLink.queryParameters['movieId']!;

    print(movieId2);


    Get.to(
        DetailsScreen(
          movieId: int.parse(movieId2),
        ), //next page class
        duration:
            const Duration(milliseconds: 600), //duration of transitions, default 1 sec
        transition: Transition.rightToLeft //transition effect
        );

    //Share.share('this is the link ${movieId2}');
  }
}
