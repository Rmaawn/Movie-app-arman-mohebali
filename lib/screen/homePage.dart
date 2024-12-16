import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_app/data/data.dart';
import 'package:movie_app/screen/movieDetailPage.dart';
import 'package:movie_app/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Box<Movie> movieBox = Hive.box<Movie>('movies');

    return Scaffold(
      // backgroundColor: const Color(0xff131722),
      appBar: AppBar(
        centerTitle: true,
        // backgroundColor: const Color(0xff1B1F2A),
        title: const Text('Movies'),
        actions: const [
          Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 16, 0),
              child: Icon(
                Icons.search_rounded,
                // color: Colors.white,
              ))
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: movieBox.listenable(),
        builder: (context, Box<Movie> box, _) {
          if (box.isEmpty) {
            return const Center(
              child: Text('No movies added yet!'),
            );
          }

          final movies = box.values.toList();

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 12, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Discover',
                      style: TextStyle(fontSize: 22,)),
                  SizedBox(
                    height: 350,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8.0),
                      scrollDirection: Axis.horizontal,
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        final movie = movies[index];
            
                        return GestureDetector(
                          onTap: () {
                            _showMovieDetails(context, movie);
                          },
                          child: Container(
                            width: 200,
                            margin: const EdgeInsets.only(
                                right: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: movie.imagePath.isNotEmpty
                                      ? Image.file(
                                          File(movie.imagePath),
                                          width: double.infinity,
                                          height: 280,
                                          fit: BoxFit.cover,
                                        )
                                      : Container(
                                          width: double.infinity,
                                          height: 180,
                                          color: Colors.grey,
                                          child: const Icon(Icons.movie,
                                              color: Colors.white, size: 40),
                                        ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(
                                    movie.name,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      // color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                HorizontalMovieListWithTitle(
                  title: 'Action',
                  movies: movies,
                  onMovieTap: (context, movie) {
                    _showMovieDetails(context, movie); 
                  },
                ),
                HorizontalMovieListWithTitle(
                  title: 'Drama',
                  movies: movies,
                  onMovieTap: (context, movie) {
                    _showMovieDetails(context, movie); 
                  },
                ),
                HorizontalMovieListWithTitle(
                  title: 'Sci-fi',
                  movies: movies,
                  onMovieTap: (context, movie) {
                    _showMovieDetails(context, movie); 
                  },
                ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showMovieDetails(BuildContext context, Movie movie) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MovieDetailsPage(movie: movie),
      ),
    );
  }
}
