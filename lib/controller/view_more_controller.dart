import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:netflix_app/helper/constants.dart';
import 'package:netflix_app/model/trending_model.dart';
import 'package:http/http.dart' as http;

class ViewMoreController extends ChangeNotifier {
  bool isLoading = true;

  TrendingModel viewMore = TrendingModel();
  static const viewMOreApi =
      'https://api.themoviedb.org/3/movie/361743/similar?api_key=1938669324aea4999c83b1bd211b184f&language=en-US&page=1';

  Future getMovieList(movieId) async {
    print('=======calling view more api============');
    isLoading = true;
    viewMore.results = [];
    var api = '$kApiUrl/movie/$movieId/similar?api_key=$kApiKey&language=en-US&page=1';

    print(api);
    final res = await http.get(Uri.parse(api));
    print('========status code=====');
    print(res.statusCode);
    print(res);
    var data = jsonDecode(res.body);
    print('=======response=========');
    viewMore = TrendingModel.fromJson(data);
    print(res.body);

    isLoading = false;
    notifyListeners();
    print('======trending result =======');
    print(viewMore.results);
  }
}
