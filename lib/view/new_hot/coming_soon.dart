import 'package:flutter/material.dart';
import 'package:netflix_app/controller/movie_list_controller.dart';
import 'package:netflix_app/view/home/widgets/custom_button.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class ComingSoon extends StatelessWidget {
  const ComingSoon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieListController>(builder: (context, controller, child) {
      print('controller 6....');
      print(controller.isLoading6);
      return controller.isLoading6 == true
          ? const SizedBox(
              child: Center(child: Text('loading.....')),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        height: MediaQuery.of(context).size.height,
                        color: Colors.black,
                        child: ListView.builder(
                            itemCount: controller.comingSoonMovies.results!.length,
                            itemBuilder: ((context, index) {
                              DateTime date = controller
                                  .comingSoonMovies.results![index].releaseDate!;
                              DateTime parseDate = DateFormat("yyyy-MM-dd").parse(
                                  controller.comingSoonMovies.results![index].releaseDate
                                      .toString());

                              print(DateFormat.yMMMMd().format(date));
                              var newdate = DateFormat.yMMMMd().format(date);

                              var parts = newdate.split(' ');
                              var prefix = parts[0].trim();
                              var prefix2 = parts[1].trim();

                              var finalMonth = prefix.substring(0, 3);

                              var finalday = prefix2.substring(0, 2);
                              return controller.comingSoonMovies.results![index]
                                          .backdropPath ==
                                      null
                                  ? const SizedBox()
                                  : Container(
                                      height: MediaQuery.of(context).size.height / 2.5,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                finalMonth,
                                                style:
                                                    const TextStyle(color: Colors.grey),
                                              ),
                                              Text(
                                                finalday,
                                                style: const TextStyle(
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.w900),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height:
                                                    MediaQuery.of(context).size.height *
                                                        .2,
                                                width: MediaQuery.of(context).size.width /
                                                    1.3,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(5.0),
                                                    //   color: Colors.black,
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                          'https://image.tmdb.org/t/p/original/${controller.comingSoonMovies.results![index].backdropPath!}',
                                                        ),
                                                        fit: BoxFit.cover)),
                                              ),
                                              const SizedBox(
                                                height: 10.0,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context).size.width /
                                                    1.3,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                        //color: Colors.yellow,
                                                        width: MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2.5,
                                                        child: Text(
                                                          controller.comingSoonMovies
                                                              .results![index].title!,
                                                          style: const TextStyle(
                                                              color: Colors.white,
                                                              fontWeight:
                                                                  FontWeight.w700),
                                                        )),
                                                    const SizedBox(
                                                      width: 10.0,
                                                    ),
                                                    Column(
                                                      //crossAxisAlignment: CrossAxisAlignment.stretch,
                                                      children: const [
                                                        Icon(
                                                          Icons.notifications,
                                                          color: Colors.white,
                                                        ),
                                                        Text(
                                                          'Remind me',
                                                          style: TextStyle(
                                                              color: Colors.grey,
                                                              fontSize: 10.0),
                                                        )
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      width: 20.0,
                                                    ),
                                                    Column(
                                                      children: const [
                                                        Icon(
                                                          Icons.info,
                                                          color: Colors.white,
                                                        ),
                                                        Text(
                                                          'info',
                                                          style: TextStyle(
                                                              color: Colors.grey,
                                                              fontSize: 10.0),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10.0,
                                              ),
                                              Text(
                                                'Coming on ${newdate.toString()}',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w800),
                                              ),
                                              const SizedBox(
                                                height: 10.0,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context).size.width /
                                                    1.3,
                                                child: Text(
                                                  controller.comingSoonMovies
                                                      .results![index].overview!,
                                                  style: const TextStyle(
                                                      fontSize: 12.0, color: Colors.grey),
                                                  maxLines: 3,
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
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
