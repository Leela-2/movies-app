import 'package:flutter/material.dart';
import 'package:movies_app/api_service.dart';
import 'package:movies_app/movie_list.dart';
import 'package:movies_app/models/movie_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Movie> trendingMovies;
  late List<Movie> topRatedMovies;
  late List<Movie> nowPlayingMovies;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      trendingMovies = await ApiService.getMovies('/movie/popular');
      topRatedMovies = await ApiService.getMovies('/movie/top_rated');
      nowPlayingMovies = await ApiService.getMovies('/movie/now_playing');
      setState(() {});
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies Lister'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Trending Movies',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            MovieList(movies: trendingMovies ?? []),
            Text('Top Rated Movies',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            MovieList(movies: topRatedMovies ?? []),
            Text('Now Playing Movies',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            MovieList(movies: nowPlayingMovies ?? []),
          ],
        ),
      ),
    );
  }
}
