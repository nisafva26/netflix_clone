import 'package:flutter/material.dart';
import 'package:netflix_app/controller/movie_list_controller.dart';
import 'package:netflix_app/view/home/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class BackgroundImage extends StatelessWidget {
  final String? imageUrl;
  const BackgroundImage({Key? key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dimension = MediaQuery.of(context).size;
    return Consumer<MovieListController>(builder: (context, controller, child) {
      print('controller inside stack...');
      print(controller.checkStatus());
      return Stack(
        children: [
          controller.checkStatus() == true
              ? Image.network(
                  'https://image.tmdb.org/t/p/original/$imageUrl',fit: BoxFit.cover,)
              : const SizedBox(),
          Container(
            height: dimension.height,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [Colors.transparent, Colors.black],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.5, 1],
            )),
          ),
          Positioned(
            bottom: 30,
            right: 0,
            left: 0,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(
                    icon: Icons.add,
                    text: 'My List',
                  ),
                  Container(
                    // width: 100.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                        color: Colors.white, borderRadius: BorderRadius.circular(2)),
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            Icon(
                              Icons.play_arrow,
                              color: Colors.black,
                            ),
                            Text(
                              'Play',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, color: Colors.black),
                            )
                          ]),
                    ),
                  ),
                  CustomButton(
                    icon: Icons.info,
                    text: 'info',
                  )
                ],
              ),
            ),
          )
        ],
      );
    });
  }
}
