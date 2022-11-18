const kApiUrl = 'https://api.themoviedb.org/3/';
const kApiKey = '1938669324aea4999c83b1bd211b184f';

class Apis {
  static const top10TvShowsApi =
      '$kApiUrl/discover/movie?api_key=$kApiKey&language=en-US&sort_by=popularity.desc&page=1&timezone=America%2FNew_York&include_null_first_air_dates=false&screened_theatrically=true';

  static const tenseDramasApi =
      '$kApiUrl/discover/movie?api_key=$kApiKey&language=en-US&sort_by=popularity.desc&include_adult=false&vote_count.gte=100&vote_average.gte=8&with_genres=Horror';

  static const southIndianCinemaApi =
      '$kApiUrl/discover/movie?api_key=$kApiKey&with_original_language=ml&sort_by=vote_average.desc&include_adult=false&release_date.gte=2021&vote_count.gte=15';

  static const movieDetailsApi =
      '$kApiUrl/movie/{movie_id}?api_key=<<api_key>>&language=en-US';

  static const topRatedIndianMovies =
      '$kApiUrl/movie/top_rated?api_key=$kApiKey&language=en-US&page=region=IN';

  static const comingSoonApi =
      'https://api.themoviedb.org/3/discover/movie?api_key=1938669324aea4999c83b1bd211b184f&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=true&page=1&with_watch_monetization_types=flatrate&primary_release_date.gte=2022-11-14';
}
