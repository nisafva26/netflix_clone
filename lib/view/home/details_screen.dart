import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:netflix_app/controller/dynamic_link_services.dart';
import 'package:netflix_app/controller/movie_description_controller.dart';
import 'package:netflix_app/view/home/video_screen.dart';
import 'package:netflix_app/view/home/widgets/play_download_button.dart';
import 'package:netflix_app/view/home/widgets/view_more.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../controller/movie_list_controller.dart';

class DetailsScreen extends StatefulWidget {
  final int? movieId;
  const DetailsScreen({Key? key, this.movieId}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late YoutubePlayerController _controller;
  // late String _key;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchMovie();

    print(widget.movieId);
  }

  Future<String> fetchMovie() async {
    print('inside fetch');
    await Provider.of<MovieDescriptionCOntroller>(context, listen: false)
        .getMovieDetails(widget.movieId!);
    print('inside fetch key');
    String key = await Provider.of<MovieDescriptionCOntroller>(context, listen: false)
        .getVideoKey(widget.movieId!);
    print('======got key ========');
    print(key);

    _controller = YoutubePlayerController(
        initialVideoId: key, flags: const YoutubePlayerFlags(autoPlay: false));

    return key;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: const BackButton(color: Colors.white),
          actions: const [
            Icon(
              Icons.cast,
              color: Colors.white,
            ),
            SizedBox(width: 10),
          ],
        ),
        body: Consumer<MovieDescriptionCOntroller>(builder: (context, controller, child) {
          print('is error occured');
          print(controller.iserrorOccured);
          print('isLoading');
          print(controller.isLoading);
          return controller.isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                    color: Colors.red,
                  ),
                )
              : controller.iserrorOccured
                  ? const Center(
                      child: Text('Sorry ! this movie could not be fetched '),
                    )
                  : SingleChildScrollView(
                      child: Container(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /* Container(
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.grey,
                                child: Image.network(
                                  controller.description.backdropPath == null
                                      ? 'https://image.tmdb.org/t/p/original/${controller.description.posterPath!}'
                                      : 'https://image.tmdb.org/t/p/original/${controller.description.backdropPath!}',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              */
                              Container(
                                height: 200,
                                child: YoutubePlayer(
                                  controller: _controller,
                                  onReady: () {
                                    _controller.play();
                                  },
                                  onEnded: (YoutubeMetaData) {
                                    _controller.play();
                                  },
                                  thumbnail: Image.network(
                                    controller.description.backdropPath == null
                                        ? 'https://image.tmdb.org/t/p/original/${controller.description.posterPath!}'
                                        : 'https://image.tmdb.org/t/p/original/${controller.description.backdropPath!}',
                                    fit: BoxFit.cover,
                                  ),
                                  showVideoProgressIndicator: true,
                                  progressIndicatorColor: Colors.red,
                                  progressColors: const ProgressBarColors(
                                      playedColor: Colors.red,
                                      backgroundColor: Colors.white,
                                      handleColor: Colors.white),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.description.title != null
                                            ? controller.description.title!
                                            : controller.description.originalTitle!,
                                        style: const TextStyle(
                                            fontSize: 23, fontWeight: FontWeight.w900),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            '2022',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w900),
                                          ),
                                          const SizedBox(
                                            width: 5.0,
                                          ),
                                          Container(
                                              decoration: const BoxDecoration(
                                                color: Color.fromARGB(198, 158, 158, 158),
                                              ),
                                              child: const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8, vertical: 3),
                                                child: Text(
                                                  'U/A 13+',
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.w900),
                                                ),
                                              )),
                                          const SizedBox(
                                            width: 5.0,
                                          ),
                                          const Text(
                                            '2h 10m',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w900),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 12.0,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            _controller.pause();
                                          });
                                          Get.to(
                                              VideoScreen(
                                                videoId:
                                                    controller.videoModel.results![0].key,
                                                posterPath:
                                                    controller.description.posterPath!,
                                                backDropPath:
                                                    controller.description.backdropPath!,
                                              ), //next page class
                                              duration: const Duration(
                                                  milliseconds:
                                                      600), //duration of transitions, default 1 sec
                                              transition: Transition
                                                  .rightToLeft //transition effect
                                              );
                                        },
                                        child: const PlayDownloadButton(
                                            text: 'Play', data: Icons.play_arrow),
                                      ),
                                      const SizedBox(
                                        height: 12.0,
                                      ),
                                      Container(
                                        height: 40.0,
                                        decoration: BoxDecoration(
                                            color: Colors.grey[900],
                                            borderRadius: BorderRadius.circular(2)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 8.0),
                                          child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: const [
                                                Icon(
                                                  Icons.download,
                                                  color: Colors.white,
                                                ),
                                                Text(
                                                  'Donwload',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w700,
                                                      color: Colors.white),
                                                )
                                              ]),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 12.0,
                                      ),
                                      Text(controller.description.overview!),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      const Text(
                                        'Starring : Tom cruise , Emily Clerlk , Peter Dinkglade',
                                        style:
                                            TextStyle(fontSize: 12, color: Colors.grey),
                                      ),
                                      const Text(
                                        'Director : Pit Bradley',
                                        style:
                                            TextStyle(fontSize: 12, color: Colors.grey),
                                      ),
                                      const SizedBox(
                                        height: 15.0,
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            InkWell(
                                              onTap: () async {
                                                print(
                                                    '===initializing dynamics links .....');
                                                final link =
                                                   await DynamicLinkServices.createDynamicLink(
                                                        controller.description.id!);
                                                print('link which is generated...');
                                                print(link);
                                                Share.share(link);
                                              },
                                              child: Column(
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
                                                      color: Colors.grey, fontSize: 10.0),
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
                                                      color: Colors.grey, fontSize: 10.0),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const Text(
                                        'MORE LIKE THIS',
                                        style: TextStyle(fontWeight: FontWeight.w800),
                                      ),
                                      const SizedBox(
                                        height: 12.0,
                                      ),
                                      ViewMoreWidget(
                                        moiveId: controller.description.id!,
                                      )
                                    ]),
                              )
                            ]),
                      ),
                    );
        }));
  }
}
