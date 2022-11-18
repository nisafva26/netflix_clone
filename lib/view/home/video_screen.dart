import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatefulWidget {
  final String? videoId;
  final String? backDropPath;
  final String? posterPath;
  const VideoScreen({Key? key, this.videoId,this.backDropPath,this.posterPath}) : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late YoutubePlayerController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = YoutubePlayerController(
        initialVideoId: widget.videoId!,
        flags: const YoutubePlayerFlags(autoPlay: false));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _controller.toggleFullScreenMode();
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(children: [
          Container(
            color: Colors.black,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: YoutubePlayerBuilder(
                player: YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: Colors.red,
                  progressColors: const ProgressBarColors(
                      playedColor: Colors.red,
                      backgroundColor: Colors.white,
                      handleColor: Colors.white),
                  bottomActions: [
                    const SizedBox(width: 14.0),
                    CurrentPosition(
                      controller: _controller,
                    ),
                    const SizedBox(width: 8.0),
                    ProgressBar(
                      controller: _controller,
                      colors: const ProgressBarColors(
                          playedColor: Colors.red,
                          backgroundColor: Colors.white,
                          handleColor: Colors.white),
                      isExpanded: true,
                    ),
                    RemainingDuration(
                      controller: _controller,
                    ),
                    PlaybackSpeedButton(
                      controller: _controller,
                    ),
                  ],
                  thumbnail: Image.network(
                                    widget.backDropPath == null
                                        ? 'https://image.tmdb.org/t/p/original/${widget.posterPath}'
                                        : 'https://image.tmdb.org/t/p/original/${widget.backDropPath}',
                                    fit: BoxFit.cover,
                                  ),
                  onReady: () {
                    _controller.toggleFullScreenMode();
                    _controller.play();
                  },
                ),
                builder: (context, player) {
                  return Column(
                    children: [
                      // some widgets
                      player,
                      //some other widgets
                    ],
                  );
                }),
          ),
          Positioned(
              top: 10,
              left: 0,
              child: BackButton(
                color: Colors.white,
                onPressed: () {
                  _controller.toggleFullScreenMode();
                  Navigator.pop(context);
                },
              ))
        ]),
      ),
    );
  }
}
