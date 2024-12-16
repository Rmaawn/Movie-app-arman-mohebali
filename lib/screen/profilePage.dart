import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_app/Theme/appTheme.dart';
import 'package:movie_app/data/data.dart';
import 'package:provider/provider.dart';

class profilePage extends StatelessWidget {
  const profilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
        // backgroundColor:const Color(0xff131722),
        appBar: AppBar(
          // centerTitle: true,
          // backgroundColor: const Color(0xff1B1F2A),
          title: const Text(
            "Profile",
            // style: TextStyle(fontSize: 24),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Remove Data',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        final Box<Movie> movieBox = Hive.box<Movie>('movies');
                        movieBox.clear();
                        ScaffoldMessenger.of(context).showSnackBar(
                             SnackBar(
                              backgroundColor: Colors.green[900],
                              content: const Text("Data Reset Succsesfuly")));
                      },
                      child: const Text('Reset')),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Dark Mode',
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                        // style: TextStyle(color: Colors.white),
                        ),
                    Switch(
                      value: themeProvider.themeMode == ThemeMode.dark,
                      onChanged: (bool isDark) {
                        themeProvider.toggleTheme();
                      },
                    ),
                  ]),
            )
          ],
        ));
  }
}
