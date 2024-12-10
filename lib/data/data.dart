import 'package:hive/hive.dart';

part 'data.g.dart';

@HiveType(typeId: 0) 
class Movie extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String description;

  @HiveField(2)
  String imagePath;

  @HiveField(3)
  String genre; 
  Movie({
    required this.name,
    required this.description,
    required this.imagePath,
    this.genre = 'Unknown',
  });
}
