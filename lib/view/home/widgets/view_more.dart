import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:netflix_app/controller/view_more_controller.dart';
import 'package:netflix_app/view/home/details_screen.dart';
import 'package:provider/provider.dart';

class ViewMoreWidget extends StatefulWidget {
  final int? moiveId;
  const ViewMoreWidget({Key? key, this.moiveId}) : super(key: key);

  @override
  State<ViewMoreWidget> createState() => _ViewMoreWidgetState();
}

class _ViewMoreWidgetState extends State<ViewMoreWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ViewMoreController>(context, listen: false)
          .getMovieList(widget.moiveId);

      // Add Your Code here.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ViewMoreController>(builder: (context, controller, child) {
      return controller.isLoading
          ? SizedBox()
          : Container(
              height: MediaQuery.of(context).size.height / 1.1,
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    childAspectRatio: .7),
                itemCount: 11,
                itemBuilder: ((context, index) {
                  return InkWell(
                    onTap: () {
                      print('======taping next===');

                      sheet(
                          controller.viewMore.results![index].title,
                          controller.viewMore.results![index].originalName,
                          controller.viewMore.results![index].overview,
                          controller.viewMore.results![index].backdropPath,
                          controller.viewMore.results![index].releaseDate.toString(),
                          controller.viewMore.results![index].id);
                    },
                    child: Container(
                      color: Colors.black,
                      height: 20,
                      child: Image.network(
                        controller.viewMore.results![index].backdropPath == null
                            ? 'https://image.tmdb.org/t/p/original/${controller.viewMore.results![index].backdropPath}'
                            : 'https://image.tmdb.org/t/p/original/${controller.viewMore.results![index].posterPath}',
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }),
              ),
            );
    });
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
              Get.off(
                  DetailsScreen(
                    movieId: id,
                  ), //next page class
                  duration: const Duration(
                      milliseconds: 600), //duration of transitions, default 1 sec
                  transition: Transition.rightToLeft ,
                  preventDuplicates: false//transition effect
                  );
                  
           /*Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) {
                return DetailsScreen(
                  movieId: id,
                );
              })));*/
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
