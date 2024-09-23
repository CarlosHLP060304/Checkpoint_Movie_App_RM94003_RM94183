import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/common/utils.dart';
import 'package:movie_app/models/movie_details.dart';
import 'package:movie_app/services/api_services.dart';

class MovieDetailsPage extends StatefulWidget {
  final int movieId;
  const MovieDetailsPage({super.key, required this.movieId});

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  ApiServices apiServices = ApiServices();

  late Future<MovieDetails> movieDetails;

  @override
  void initState() {
    fetchInitialData();
    super.initState();
  }

  fetchInitialData() {
    movieDetails = apiServices.getMovieDetails(widget.movieId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder<MovieDetails>(
            future: movieDetails,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final movie = snapshot.data!;

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image Section
                      Stack(
                        children: [
                          Container(
                            height: size.height * 0.5,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(50),
                                bottomRight: Radius.circular(50),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                              image: DecorationImage(
                                image: NetworkImage("$imageUrl${movie.posterPath}"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 40,
                            left: 20,
                            child: SafeArea(
                              child: IconButton(
                                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Movie Details Section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie.title,
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 15),
                            // Release Date and Genres
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildInfoChip(Icons.calendar_today, 'Release Date', movie.releaseDate.year.toString()),
                                _buildInfoChip(Icons.movie_filter, 'Genres', movie.genres.map((genre) => genre.name).join(', ')),
                              ],
                            ),
                            const SizedBox(height: 30),
                            // Overview
                            Text(
                              'Overview',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              movie.overview,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                              maxLines: 8,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),

                      // You can add more sections like cast, reviews, etc.
                    ],
                  ),
                );
              }

              return const Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }

  // Custom Chip for Movie Info
  Widget _buildInfoChip(IconData icon, String label, String value) {
    return Chip(
      backgroundColor: Colors.blueAccent.withOpacity(0.1),
      avatar: Icon(icon, size: 18, color: Colors.blueAccent),
      label: Text(
        '$label: $value',
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.blueAccent,
        ),
      ),
    );
  }
}
