import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:netflix_app/controller/movie_list_controller.dart';
import 'package:netflix_app/view/home/details_screen.dart';
import 'package:netflix_app/view/home/widgets/background_image.dart';
import 'package:netflix_app/view/home/widgets/custom_sliver_appbar.dart';
import 'package:provider/provider.dart';

import 'widgets/appbar_text.dart';

class CustomHomeScreen extends StatefulWidget {
  final String? text;
  final String? tag;
  const CustomHomeScreen({Key? key, this.tag, this.text}) : super(key: key);

  @override
  State<CustomHomeScreen> createState() => _CustomHomeScreen();
}

class _CustomHomeScreen extends State<CustomHomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MovieListController>(context, listen: false).getMovieList();
      Provider.of<MovieListController>(context, listen: false).getTop10();
      Provider.of<MovieListController>(context, listen: false).getHorror();
      Provider.of<MovieListController>(context, listen: false).getSouthindianMovies();
      Provider.of<MovieListController>(context, listen: false).getTopRatedMovies();
      Provider.of<MovieListController>(context, listen: false).getComingSoonMOvies();

      // Add Your Code here.
    });
  }

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
    final dimension = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      body: Consumer<MovieListController>(builder: (context, controller, child) {
        print('check status inside custom');
        print(controller.checkStatus());

        return controller.checkStatus() == false
            ? SizedBox()
            : CustomScrollView(
                slivers: [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    pinned: true,
                    expandedHeight: dimension.height / 1.5,
                    toolbarHeight: 100,
                    backgroundColor: Colors.black.withOpacity(0.8),
                    title: CustomSliverToolBar(
                      tag: widget.tag,
                      text: widget.text,
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.pin,
                        background: BackgroundImage(
                          imageUrl: controller.horrorModel.results![1].posterPath!,
                        )),
                  ),
                  SliverList(
                      delegate: SliverChildListDelegate([
                    Container(
                      height: dimension.height * .24,
                      width: MediaQuery.of(context).size.width,
                      //color: Colors.blue,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, bottom: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Popular on Netflix',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Expanded(
                              child: ListView.builder(
                                  itemCount: 10,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: InkWell(
                                          onTap: () {
                                            sheet(
                                              controller
                                                  .tredingModel.results![index].title,
                                              controller.tredingModel.results![index]
                                                  .originalName,
                                              controller
                                                  .tredingModel.results![index].overview,
                                              controller.tredingModel.results![index]
                                                  .posterPath!,
                                              controller.tredingModel.results![index]
                                                  .releaseDate
                                                  .toString(),
                                              controller.tredingModel.results![index].id!,
                                            );
                                          },
                                          child:
                                              controller.tredingModel.results!.isNotEmpty
                                                  ? Container(
                                                      // height: 130,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(5.0),
                                                          color: Colors.black,
                                                          image: DecorationImage(
                                                              image: NetworkImage(
                                                                'https://image.tmdb.org/t/p/original/${controller.tredingModel.results![index].posterPath!}',
                                                              ),
                                                              fit: BoxFit.cover)),
                                                      width: 100.0,
                                                    )
                                                  : const SizedBox()),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: dimension.height * .24,
                      width: MediaQuery.of(context).size.width,
                      //color: Colors.blue,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, bottom: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Top 10 Movies',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Expanded(
                              child: ListView.builder(
                                  itemCount: 10,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: InkWell(
                                          onTap: () {
                                            sheet(
                                              controller.top10model.results![index].title,
                                              controller.top10model.results![index]
                                                  .originalName,
                                              controller
                                                  .top10model.results![index].overview,
                                              controller
                                                  .top10model.results![index].posterPath!,
                                              controller
                                                  .top10model.results![index].releaseDate
                                                  .toString(),
                                              controller.top10model.results![index].id!,
                                            );
                                          },
                                          child: controller.top10model.results!.isNotEmpty
                                              ? Container(
                                                  // height: 130,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(5.0),
                                                      //   color: Colors.black,
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                            'https://image.tmdb.org/t/p/original/${controller.top10model.results![index].posterPath!}',
                                                          ),
                                                          fit: BoxFit.cover)),
                                                  width: 100.0,
                                                )
                                              : const SizedBox()),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: dimension.height * .24,
                      width: MediaQuery.of(context).size.width,
                      //color: Colors.blue,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, bottom: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Tense Drama',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Expanded(
                              child: ListView.builder(
                                  itemCount: 10,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: InkWell(
                                          onTap: () {
                                            sheet(
                                                controller
                                                    .horrorModel.results![index].title!,
                                                controller.horrorModel.results![index]
                                                    .originalName,
                                                controller.horrorModel.results![index]
                                                    .overview!,
                                                controller.horrorModel.results![index]
                                                    .posterPath!,
                                                controller.horrorModel.results![index]
                                                    .releaseDate
                                                    .toString(),
                                                controller
                                                    .horrorModel.results![index].id!);
                                          },
                                          child:
                                              controller.horrorModel.results!.isNotEmpty
                                                  ? Container(
                                                      // height: 130,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(5.0),
                                                          //   color: Colors.black,
                                                          image: DecorationImage(
                                                              image: NetworkImage(
                                                                'https://image.tmdb.org/t/p/original/${controller.horrorModel.results![index].posterPath!}',
                                                              ),
                                                              fit: BoxFit.cover)),
                                                      width: 100.0,
                                                    )
                                                  : const SizedBox()),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: dimension.height * .24,
                      width: MediaQuery.of(context).size.width,
                      //color: Colors.blue,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, bottom: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'South Indian Movies',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Expanded(
                              child: ListView.builder(
                                  itemCount: 10,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: InkWell(
                                          onTap: () {
                                            sheet(
                                                controller.southIndianModel
                                                    .results![index].title!,
                                                controller.southIndianModel
                                                    .results![index].originalName,
                                                controller.southIndianModel
                                                    .results![index].overview!,
                                                controller.southIndianModel
                                                    .results![index].posterPath!,
                                                controller.southIndianModel
                                                    .results![index].releaseDate
                                                    .toString(),
                                                controller.southIndianModel
                                                    .results![index].id!);
                                          },
                                          child: controller
                                                  .southIndianModel.results!.isNotEmpty
                                              ? Container(
                                                  // height: 130,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(5.0),
                                                      //   color: Colors.black,
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                            'https://image.tmdb.org/t/p/original/${controller.southIndianModel.results![index].posterPath!}',
                                                          ),
                                                          fit: BoxFit.cover)),
                                                  width: 100.0,
                                                )
                                              : const SizedBox()),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ]))
                ],
              );
      }),
    );
  }

  Future<dynamic> sheet(String? title, String? originalName, String? overview,
      String? imageUrl, String? date, int? id) {
    return showMaterialModalBottomSheet(
      context: context,
      isDismissible: true,
      backgroundColor: Colors.grey[900],
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height / 2.4,
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0, top: 15.0, right: 8, bottom: 20),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
              Get.to(
                  DetailsScreen(
                    movieId: id,
                  ), //next page class
                  duration: const Duration(
                      milliseconds: 600), //duration of transitions, default 1 sec
                  transition: Transition.rightToLeft //transition effect
                  );
            },
            child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 130,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.black,
                        image: DecorationImage(
                            image: NetworkImage(
                              'https://image.tmdb.org/t/p/original/$imageUrl',
                            ),
                            fit: BoxFit.cover)),
                    width: 100.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 1.8,
                                child: Text(
                                  title == null ? originalName! : title,
                                  overflow: TextOverflow.fade,
                                  maxLines: 2,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      fontSize: 18,
                                      decoration: TextDecoration.none),
                                ),
                              ),
                              InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey[600],
                                    ),
                                    child: const Icon(
                                      Icons.close_outlined,
                                      color: Colors.white,
                                    ),
                                  ))
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                date != null ? date.substring(0, 4) : '2022',
                                style: const TextStyle(color: Colors.grey, fontSize: 13),
                              ),
                              const Text(
                                'UA 13+',
                                style: TextStyle(color: Colors.grey, fontSize: 13.0),
                              ),
                              const Text(
                                '1h 58 m',
                                style: TextStyle(color: Colors.grey, fontSize: 13.0),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.7,
                          child: Text(
                            overview!,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 80,
                width: MediaQuery.of(context).size.width,
                //color: Colors.black,
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.play_circle,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                      const Text(
                        'Play',
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      )
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(83, 158, 158, 158),
                        ),
                        child: const Icon(
                          Icons.download_sharp,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        'Download',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      )
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(83, 158, 158, 158),
                        ),
                        child: const Icon(
                          Icons.download_done,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        'My List',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      )
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(83, 158, 158, 158),
                        ),
                        child: const Icon(
                          Icons.share,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        'Share',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      )
                    ],
                  )
                ]),
              ),
              const Divider(
                color: Colors.white,
              ),
              Spacer(),
              Row(
                children: const [
                  Icon(
                    Icons.info,
                    color: Colors.white,
                  ),
                  Text('Details & More'),
                  Spacer(),
                  Icon(Icons.arrow_circle_right_outlined, color: Colors.white)
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
