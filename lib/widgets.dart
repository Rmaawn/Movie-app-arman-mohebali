import 'dart:io';
import 'package:flutter/material.dart';
import 'package:movie_app/data/data.dart';

class HorizontalMovieListWithTitle extends StatelessWidget {
  final String title; 
  final List<Movie> movies;
  final Function(BuildContext, Movie) onMovieTap;

  const HorizontalMovieListWithTitle({
    super.key,
    required this.title,
    required this.movies,
    required this.onMovieTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 22, 
              // color: Colors.white
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff0C386B),
                foregroundColor: Colors.white,
              ),
              child: const Text(
                'See all',
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 220,
          child: ListView.builder(
            padding: const EdgeInsets.all(8.0),
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];

              return GestureDetector(
                onTap: () {
                  onMovieTap(context, movie);
                },
                child: Container(
                  width: 100,
                  margin: const EdgeInsets.only(right: 12),
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
                                height: 150,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                width: double.infinity,
                                height: 180,
                                // color: Colors.pink,
                                child: const Icon(
                                  Icons.movie,
                                  // color: Colors.white,
                                  size: 40,
                                ),
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          movie.name,
                          style: const TextStyle(
                            fontSize: 16,
                            // fontWeight: FontWeight.bold,
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
      ],
    );
  }
}
