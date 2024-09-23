import 'dart:convert';

import 'package:movie_app/common/utils.dart';
import 'package:movie_app/models/actor_details.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/models/movie_details.dart';
import 'package:movie_app/models/actors_details.dart';

const baseUrl = 'https://api.themoviedb.org/3/';
const key = '?api_key=$apiKey';

class ApiServices {


  Future<MovieDetails> getMovieDetails(int movieId) async {
    final endPoint = 'movie/$movieId';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return MovieDetails.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load  movie details');
  }

   Future<ActorsResult> getActors() async {
    const endPoint = 'person/popular';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var body =  jsonDecode(response.body);
      var actors = ActorsResult.fromJson(body);
      return ActorsResult.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load now playing movies');
  }

      Future<ActorResults> getActorDetails(int personId) async {
        final endPoint = 'person/$personId';
        final url = '$baseUrl$endPoint$key';

        final response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          return ActorResults.fromJson(jsonDecode(response.body));
        }
        throw Exception('failed to load  movie details');
      }

  

  Future<Result> getTopRatedMovies() async {
    var endPoint = 'movie/top_rated';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return Result.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load now playing movies');
  }

  Future<Result> getNowPlayingMovies() async {
    var endPoint = 'movie/now_playing';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return Result.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load now playing movies');
  }

  Future<Result> getUpcomingMovies() async {
    var endPoint = 'movie/upcoming';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return Result.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load upcoming movies');
  }

  Future<Result> getPopularMovies() async {
    const endPoint = 'movie/popular';
    const url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url), headers: {});
    if (response.statusCode == 200) {
      return Result.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load now playing movies');
  }
}
