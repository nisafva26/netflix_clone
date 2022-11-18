import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:netflix_app/helper/constants.dart';
import 'package:netflix_app/model/movie_description_model.dart';
import 'package:http/http.dart' as http;
import 'package:netflix_app/model/video_model.dart';

class MovieDescriptionCOntroller extends ChangeNotifier {
  MoveiDescriptionModel description = MoveiDescriptionModel();
  bool isLoading = true;
  VideoModel videoModel = VideoModel();

  bool iserrorOccured = false;

  Future getMovieDetails(int movieId) async {
    print('====fetching details=====');
    isLoading = true;
    iserrorOccured = false;
    final movieDetailsApi = '$kApiUrl/movie/$movieId?api_key=$kApiKey&language=en-US';

    final res = await http.get(Uri.parse(movieDetailsApi));
    print('status code');
    print(res.statusCode);
    if (res.statusCode == 404) {
      print('=======error occured====');
      isLoading = false;

      iserrorOccured = true;

      notifyListeners();
    } else {
      print('=====movie exixst======');
      var data = jsonDecode(res.body);

      print('=========movie details========');
      print(data);

      description = MoveiDescriptionModel.fromJson(data);

      notifyListeners();
    }
  }

  Future<String> getVideoKey(int movieId) async {
    print('fetching video key in fucntion');
    isLoading = true;
    final videoApi =
        'https://api.themoviedb.org/3/movie/$movieId/videos?api_key=1938669324aea4999c83b1bd211b184f';

    final res = await http.get(Uri.parse(videoApi));
    print('status code');
    var data = jsonDecode(res.body);
    print(data);

    videoModel = VideoModel.fromJson(data);

    if (videoModel.results!.isEmpty) {
      print('key doent exist , its empty');
      iserrorOccured = true;
    }
    isLoading = false;
    notifyListeners();
    print('key in fn');
    // print(videoModel.results![0].key!);

    return videoModel.results![0].key!;
  }
}
