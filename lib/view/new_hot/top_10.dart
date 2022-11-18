import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:netflix_app/view/home/details_screen.dart';
import 'package:provider/provider.dart';

import '../../controller/movie_list_controller.dart';

class Top10 extends StatelessWidget {
  const Top10({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieListController>(builder: (context, controller, child) {
      print('controller 6....');
      print(controller.isLoading2);
      return controller.isLoading2 == true
          ? const SizedBox(
              child: Center(child: Text('loading.....')),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        height: MediaQuery.of(context).size.height,
                        color: Colors.black,
                        child: ListView.builder(
                            itemCount: 10,
                            itemBuilder: ((context, index) {
                              return controller.top10model.results![index].backdropPath ==
                                      null
                                  ? const SizedBox()
                                  : InkWell(
                                      onTap: () {
                                        Get.to(
                                            DetailsScreen(
                                              movieId: controller.top10model.results![index].id!,
                                            ), //next page class
                                            duration: const Duration(
                                                milliseconds:
                                                    600), //duration of transitions, default 1 sec
                                            transition:
                                                Transition.rightToLeft //transition effect
                                            );
                                      },
                                      child: Container(
                                        height: MediaQuery.of(context).size.height / 2.5,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              (index + 1).toString(),
                                              style: const TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height:
                                                      MediaQuery.of(context).size.height *
                                                          .2,
                                                  width:
                                                      MediaQuery.of(context).size.width /
                                                          1.2,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(5.0),
                                                      //   color: Colors.black,
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                            'https://image.tmdb.org/t/p/original/${controller.top10model.results![index].backdropPath!}',
                                                          ),
                                                          fit: BoxFit.cover)),
                                                ),
                                                const SizedBox(
                                                  height: 10.0,
                                                ),
                                                Container(
                                                  width:
                                                      MediaQuery.of(context).size.width /
                                                          1.2,
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Container(
                                                          //color: Colors.yellow,
                                                          width: MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              2.5,
                                                          child: Text(
                                                            controller.top10model
                                                                .results![index].originalTitle!,
                                                            style: const TextStyle(
                                                                color: Colors.white,
                                                                fontWeight:
                                                                    FontWeight.w700),
                                                          )),
                                                      Column(
                                                        //crossAxisAlignment: CrossAxisAlignment.stretch,
                                                        children: const [
                                                          Icon(
                                                            Icons.share,
                                                            color: Colors.white,
                                                          ),
                                                          Text(
                                                            'Share',
                                                            style: TextStyle(
                                                                color: Colors.grey,
                                                                fontSize: 10.0),
                                                          )
                                                        ],
                                                      ),
                                                      Column(
                                                        //crossAxisAlignment: CrossAxisAlignment.stretch,
                                                        children: const [
                                                          Icon(
                                                            Icons.add,
                                                            color: Colors.white,
                                                          ),
                                                          Text(
                                                            'My List',
                                                            style: TextStyle(
                                                                color: Colors.grey,
                                                                fontSize: 10.0),
                                                          )
                                                        ],
                                                      ),
                                                      Column(
                                                        children: const [
                                                          Icon(
                                                            Icons.play_arrow,
                                                            color: Colors.white,
                                                          ),
                                                          Text(
                                                            'Play',
                                                            style: TextStyle(
                                                                color: Colors.grey,
                                                                fontSize: 10.0),
                                                          )
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        width: 10.0,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10.0,
                                                ),
                                                Container(
                                                  width:
                                                      MediaQuery.of(context).size.width /
                                                          1.2,
                                                  child: Text(
                                                    controller.top10model.results![index]
                                                        .overview!,
                                                    style: const TextStyle(
                                                        fontSize: 12.0,
                                                        color: Colors.grey),
                                                    maxLines: 3,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                            }))),
                    const SizedBox(
                      height: 150,
                    )
                  ],
                ),
              ),
            );
    });
  }
}
