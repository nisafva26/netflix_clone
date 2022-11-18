import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:netflix_app/model/trending_model.dart';

import 'package:http/http.dart' as http;

import '../helper/constants.dart';

class MovieListController extends ChangeNotifier {
  TrendingModel tredingModel = TrendingModel();
  TrendingModel top10model = TrendingModel();
  TrendingModel horrorModel = TrendingModel();
  TrendingModel southIndianModel = TrendingModel();
  TrendingModel topratedIndianMovies = TrendingModel();
  TrendingModel comingSoonMovies = TrendingModel();

  bool isLoading1 = true;
  bool isLoading2 = true;
  bool isLoading3 = true;
  bool isLoading4 = true;
  bool isLoading5 = true;
  bool isLoading6 = true;

  bool isLoadingcheck = false;

  

  bool checkStatus() {
    isLoadingcheck = false;
    if (isLoading1 == false &&
        isLoading2 == false &&
        isLoading3 == false &&
        isLoading4 == false &&
        isLoading5 == false &&
        isLoading6 == false) {
      print('===all loading completed ====');
      isLoadingcheck = true;
    } else {
      print('====still in loading =====');
    }

    //notifyListeners();
    return isLoadingcheck;
  }

  Future getMovieList() async {
    print('=======call 1============');
    isLoading1 = true;
    tredingModel.results = [];
    const api = '${kApiUrl}trending/all/day?api_key=$kApiKey';
    final res = await http.get(Uri.parse(api));
    var data = jsonDecode(res.body);
    print('=======response=========');
    tredingModel = TrendingModel.fromJson(data);
    print(res.body);

    

    isLoading1 = false;
    notifyListeners();
    print('======trending result =======');
    print(tredingModel.results);
  }

  Future getTop10() async {
    print('=======call 2============');
    isLoading2 = true;
    top10model.results = [];
    final res = await http.get(Uri.parse(Apis.top10TvShowsApi));
    var data = jsonDecode(res.body);
    print('=======top 10 response=========');
    top10model = TrendingModel.fromJson(data);

   
    print(res.body);
    isLoading2 = false;
    notifyListeners();
    print('======Top 10 Movies =======');
    print(top10model.results);
  }

  Future getHorror() async {
    print('=======call 3============');
    isLoading3 = true;
    horrorModel.results = [];
    final res = await http.get(Uri.parse(Apis.tenseDramasApi));
    var data = jsonDecode(res.body);
    print('=======response=========');
    horrorModel = TrendingModel.fromJson(data);

   
    print(res.body);
    isLoading3 = false;
    notifyListeners();
    print('======horror movies Movies =======');
    print(horrorModel.results);
  }

  Future getSouthindianMovies() async {
    print('=======call 4============');
    isLoading4 = true;
    southIndianModel.results = [];
    final res = await http.get(Uri.parse(Apis.southIndianCinemaApi));
    var data = jsonDecode(res.body);
    print('=======response=========');
    southIndianModel = TrendingModel.fromJson(data);

   
    print(res.body);
    isLoading4 = false;
    notifyListeners();
    print('======south indian movies Movies =======');
    print(southIndianModel.results);
  }

   Future getTopRatedMovies() async {
    print('=======call 5============');
    isLoading5 = true;
    topratedIndianMovies.results = [];
    final res = await http.get(Uri.parse(Apis.topRatedIndianMovies));
    var data = jsonDecode(res.body);
    print('=======response=========');
    topratedIndianMovies = TrendingModel.fromJson(data);

   
    print(res.body);
    isLoading5 = false;
    notifyListeners();
    print('======top rated indian movies Movies =======');
    print(topratedIndianMovies.results);
  }

  Future getComingSoonMOvies() async {
    print('=======call 6============');
    isLoading6 = true;
    comingSoonMovies.results = [];
    final res = await http.get(Uri.parse(Apis.comingSoonApi));
    var data = jsonDecode(res.body);
    print('=======coming soon response=========');
    comingSoonMovies = TrendingModel.fromJson(data);

   
    print(res.body);
    isLoading6 = false;
    notifyListeners();
    print('======coming soonMovies =======');
    print(comingSoonMovies.results);
  }
}
