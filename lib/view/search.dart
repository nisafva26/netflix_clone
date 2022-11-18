import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix_app/controller/movie_list_controller.dart';
import 'package:netflix_app/helper/constants.dart';
import 'package:netflix_app/view/home/details_screen.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class SearchBar extends SearchDelegate {
  //List<Product>? allProduct;

  SearchBar();
  Future getResults() async {
    final api =
        '${kApiUrl}search/movie?api_key=$kApiKey&language=en-US&page=1&include_adult=false&query=$query';
    final res = await http.get(Uri.parse(api));
    var data = jsonDecode(res.body);
    print('====search result========');
    print(data);

    return data;
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return super.appBarTheme(context).copyWith(
          scaffoldBackgroundColor: Colors.black,
          hintColor: Colors.grey,
          textTheme: TextTheme(
            headline6: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.normal,
              fontFamily: GoogleFonts.montserrat().fontFamily,
            ),
          ),
          appBarTheme: const AppBarTheme(
            color: Colors.black,
          ),
        );
    // return ThemeData(
    //   primaryColor: black,
    // );
  }

  @override
  List<Widget> buildActions(BuildContext context) => [
        IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          },
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
        ),
      ];

  @override
  Widget buildLeading(BuildContext context) => BackButton(
        onPressed: () {
          close(context, null);
        },
      );

  @override
  Widget buildResults(BuildContext context) {
    if (query.isNotEmpty) {
      return FutureBuilder(
        future: getResults(),
        builder: (ctx, AsyncSnapshot snapshot) {
          print(snapshot);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data['total_results'] == 0) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Oops.. We havent got that',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      fontFamily: GoogleFonts.montserrat().fontFamily,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Try searching for other movies',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        fontFamily: GoogleFonts.montserrat().fontFamily,
                        color: Colors.grey),
                  )
                ],
              ),
            );
          }
          print(snapshot.data['count']);
          print(snapshot.data['results']);
          List results = snapshot.data['results'];

          print('====result=====');
          print(results);

          List rawtitle = results;

          print('===raw title=====');
          print(rawtitle);

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: .8),
                itemCount: results.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Get.to(
                          DetailsScreen(
                            movieId: rawtitle[index]['id'],
                          ), //next page class
                          duration: const Duration(
                              milliseconds: 600), //duration of transitions, default 1 sec
                          transition: Transition.rightToLeft //transition effect
                          );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.black,
                      ),
                      child: Image.network(
                        rawtitle[index]['backdrop_path'] == null
                            ? 'https://image.tmdb.org/t/p/original/${rawtitle[index]['backdrop_path']}'
                            : 'https://image.tmdb.org/t/p/original/${rawtitle[index]['poster_path']}',
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }),
          );
        },
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Top Searches',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            fontFamily: GoogleFonts.montserrat().fontFamily,
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Consumer<MovieListController>(builder: (context, controller, child) {
          return Container(
            child: Expanded(
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.to(
                            DetailsScreen(
                              movieId: controller.top10model.results![index].id,
                            ), //next page class
                            duration: const Duration(
                                milliseconds:
                                    600), //duration of transitions, default 1 sec
                            transition: Transition.rightToLeft //transition effect
                            );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Container(
                          height: 60.0,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.grey[900],
                          child: Row(children: [
                            Container(
                              width: 100.0,
                              height: 60.0,
                              child: Image.network(
                                'https://image.tmdb.org/t/p/original/${controller.top10model.results![index].backdropPath}',
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  controller.top10model.results![index].title!,
                                  style: TextStyle(
                                    fontFamily: GoogleFonts.montserrat().fontFamily,
                                  ),
                                )),
                            const Spacer(),
                            const Icon(
                              Icons.play_circle,
                              color: Colors.white,
                              size: 30.0,
                            ),
                            const SizedBox(
                              width: 5.0,
                            )
                          ]),
                        ),
                      ),
                    );
                  }),
            ),
          );
        })
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty) {
      return FutureBuilder(
        future: getResults(),
        builder: (ctx, AsyncSnapshot snapshot) {
          print(snapshot);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data['total_results'] == 0) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Oops.. We havent got that',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      fontFamily: GoogleFonts.montserrat().fontFamily,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Try searching for other movies',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        fontFamily: GoogleFonts.montserrat().fontFamily,
                        color: Colors.grey),
                  )
                ],
              ),
            );
          }
          print(snapshot.data['count']);
          print(snapshot.data['results']);
          List results = snapshot.data['results'];

          print('====result=====');
          print(results);

          List rawtitle = results;
          print('===raw title=====');
          print(rawtitle);

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: .8),
                itemCount: results.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Get.to(
                          DetailsScreen(
                            movieId: rawtitle[index]['id'],
                          ), //next page class
                          duration: const Duration(
                              milliseconds: 600), //duration of transitions, default 1 sec
                          transition: Transition.rightToLeft //transition effect
                          );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.black,
                      ),
                      child: Image.network(
                        rawtitle[index]['backdrop_path'] == null
                            ? 'https://image.tmdb.org/t/p/original/${rawtitle[index]['backdrop_path']}'
                            : 'https://image.tmdb.org/t/p/original/${rawtitle[index]['poster_path']}',
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }),
          );
        },
      );
    }

    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 1.1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Top Searches',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                fontFamily: GoogleFonts.montserrat().fontFamily,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Consumer<MovieListController>(builder: (context, controller, child) {
              return Expanded(
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Get.to(
                              DetailsScreen(
                                movieId: controller.top10model.results![index].id,
                              ), //next page class
                              duration: const Duration(
                                  milliseconds:
                                      600), //duration of transitions, default 1 sec
                              transition: Transition.rightToLeft //transition effect
                              );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: Container(
                            height: 70.0,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.grey[900],
                            child: Row(children: [
                              Container(
                                width: 100.0,
                                height: 70.0,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          'https://image.tmdb.org/t/p/original/${controller.top10model.results![index].backdropPath}',
                                        ),
                                        fit: BoxFit.cover),
                                    borderRadius: BorderRadius.circular(5.0)),
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Text(
                                    controller.top10model.results![index].title!,
                                    style: TextStyle(
                                      fontFamily: GoogleFonts.montserrat().fontFamily,
                                    ),
                                  )),
                              const Spacer(),
                              const Icon(
                                Icons.play_circle,
                                color: Colors.white,
                                size: 30.0,
                              ),
                              const SizedBox(
                                width: 5.0,
                              )
                            ]),
                          ),
                        ),
                      );
                    }),
              );
            }),
            // const SizedBox(height: 30.0,)
          ],
        ),
      ),
    );
  }
}
