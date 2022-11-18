import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:netflix_app/view/home/custom_homescreen.dart';
import 'package:netflix_app/view/search.dart';

import '../details_screen.dart';

class SliverToolBar extends StatelessWidget {
  const SliverToolBar({Key? key}) : super(key: key);

  @override
  Widget _flightShuttleBuilder(
    BuildContext flightContext,
    Animation<double> animation,
    HeroFlightDirection flightDirection,
    BuildContext fromHeroContext,
    BuildContext toHeroContext,
  ) {
    return DefaultTextStyle(
      style: DefaultTextStyle.of(toHeroContext).style,
      child: toHeroContext.widget,
    );
  }

  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      //mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 40.0,
              width: 40.0,
              child: Image.asset('assets/netflix_icon2.png'),
            ),
            const Spacer(),
             IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: SearchBar(),
                );
              },
              icon: const Icon(
                Icons.search,
                size: 25,
                
              )),
            const Icon(
              Icons.cast,
              color: Colors.white,
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () {
                Get.to(
                  const CustomHomeScreen(tag: "cat1",text: 'TV Shows',), //next page class
                  duration: const Duration(
                      milliseconds: 600), 
                      //duration of transitions, default 1 sec
                      transition: Transition.upToDown //transition effect
                );
              },
              child: Hero(
                tag: "cat1",
                // flightShuttleBuilder: _flightShuttleBuilder,
                child: Material(
                  type: MaterialType.transparency,
                  child: ToolBartext('TV Shows'),
                ),
              ),
            ),
             InkWell(
              onTap: () {
                Get.to(
                  const CustomHomeScreen(tag: "cat2",text: 'Movies',), //next page class
                   duration: const Duration(
                      milliseconds: 600), 
                      //duration of transitions, default 1 sec
                      transition: Transition.upToDown  //transition effect
                );
              },
              child: Hero(
                tag: "cat2",
                // flightShuttleBuilder: _flightShuttleBuilder,
                child: Material(
                  type: MaterialType.transparency,
                  child: ToolBartext('Movies'),
                ),
              ),
            ),
             InkWell(
              onTap: () {
                Get.to(
                  const CustomHomeScreen(tag: "cat3",text: 'Categories',), //next page class
                  duration: const Duration(
                      milliseconds: 600), 
                      //duration of transitions, default 1 sec
                   transition: Transition.upToDown //transition effect
                );
              },
              child: Hero(
                tag: "cat3",
                // flightShuttleBuilder: _flightShuttleBuilder,
                child: Material(
                  type: MaterialType.transparency,
                  child: ToolBartext('Categories'),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Row ToolBartext(String text) {
    return Row(
      children: [
        Text(
          text,
          style: const TextStyle(
              fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.w800),
        ),
        Icon(Icons.keyboard_arrow_down,color: Colors.transparent,)
      ],
    );
  }
}
