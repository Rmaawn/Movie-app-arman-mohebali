
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:movie_app/data/data.dart';

class MovieDetailsPage extends StatelessWidget {
  final Movie movie;

  const MovieDetailsPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor:const Color(0xff131722),
      appBar: AppBar(
        // centerTitle:true,
        // backgroundColor:const Color(0xff1B1F2A),
        title: const Text('Discription'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (movie.imagePath.isNotEmpty)
              ShaderMask(
                  shaderCallback: (rect) {
                    return const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xff1B1F2A), Colors.transparent],
                    ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                  },
                  blendMode: BlendMode.dstIn,
                child: Image.file(
                  File(movie.imagePath),
                  width: double.infinity,
                  height: 550,
                  fit: BoxFit.cover,
                ),
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20,0,20,0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.name,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              const SizedBox(height: 8.0),
              Text(
                movie.description,
                style: const TextStyle(fontSize: 16.0),
              ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
