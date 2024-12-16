import 'package:flutter/material.dart';
import 'package:movie_app/constans.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  void toggleTheme() {
    themeMode = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class appTheme {
  ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.lightprimaryBackground,
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: AppColors.lightTextColor),
          backgroundColor: AppColors.lightSeconderyBackground,
          centerTitle: true,
          titleTextStyle: TextStyle(color: AppColors.lightTextColor,fontSize: 20)),
      textTheme: const TextTheme(
          bodyMedium: TextStyle(color: AppColors.lightTextColor),
          titleMedium: TextStyle(color: AppColors.darkTextColor)),
      iconTheme: const IconThemeData(size: 26),
            navigationBarTheme: const NavigationBarThemeData(
              labelTextStyle: WidgetStatePropertyAll(TextStyle(color: AppColors.lightTextColor)),
              indicatorColor: Color.fromARGB(255, 108, 127, 178),
          backgroundColor: AppColors.lightSeconderyBackground,
              iconTheme: WidgetStatePropertyAll(IconThemeData(color: AppColors.lightTextColor,
              ))
          ),
           inputDecorationTheme: const InputDecorationTheme(
            filled: true,
                    fillColor: AppColors.lightSeconderyBackground,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87)),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    floatingLabelStyle: TextStyle(color: AppColors.lightTextColor)

           )
      );






  ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.darkprimaryBackground,
      appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: AppColors.darkTextColor),
          backgroundColor: AppColors.darkSeconderyBackground,
          centerTitle: true,
          titleTextStyle: TextStyle(color: AppColors.darkTextColor,fontSize: 20)),
      textTheme: const TextTheme(
          bodyMedium: TextStyle(color: AppColors.darkTextColor),
          headlineMedium: TextStyle(color: AppColors.darkTextColor)
          ),
      iconTheme: const IconThemeData(size: 26),
      navigationBarTheme: const NavigationBarThemeData(
              labelTextStyle: WidgetStatePropertyAll(TextStyle(color: AppColors.darkTextColor)),
        indicatorColor: Color(0xff39506A),
          backgroundColor: AppColors.darkSeconderyBackground,
                        iconTheme: WidgetStatePropertyAll(IconThemeData(color: AppColors.darkTextColor,
          ))),
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
                    fillColor: AppColors.darkSeconderyBackground,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white12)),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    floatingLabelStyle: TextStyle(color: Colors.grey,fontSize: 16),
                    hintStyle: TextStyle(color: Colors.white38),
          )
          
        );
}
