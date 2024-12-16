import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_app/data/data.dart';
import 'package:movie_app/main.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

bool weHaveImage = false;

class _AddPageState extends State<AddPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _imagePath;

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: 45,
          width: double.infinity,
          child: FloatingActionButton(
            backgroundColor: const Color(0xff1564C0),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(48),
            ),
            onPressed: () {
              _saveMovie();
            },
            child: const Text('Save'),
          ),
        ),
      ),
      // backgroundColor: const Color(0xff131722),
      appBar: AppBar(
        // centerTitle: true,
        // backgroundColor: const Color(0xff1B1F2A),
        title: const Text("Add Movie"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                style: TextStyle(color: Colors.grey[300]),
                onTapOutside: (event) {
                  FocusScope.of(context).unfocus();
                },
                controller: _nameController,
                decoration: const InputDecoration(
                  // filled: true,
                  // fillColor: Color(0xff1B1F2A),
                  // enabledBorder: OutlineInputBorder(
                  //     borderSide: BorderSide(color: Colors.white12)),
                  // floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: "Name",
                  hintText: "e.g. Avengers",
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                  style: TextStyle(color: Colors.grey[400]),

                onTapOutside: (event) {
                  FocusScope.of(context).unfocus();
                },
                controller: _descriptionController,
                maxLines: 5,
                decoration: const InputDecoration(
                  // filled: true,
                  // fillColor: Color(0xff1B1F2A),
                  // enabledBorder: OutlineInputBorder(
                  //     borderSide: BorderSide(color: Colors.white12)),
                  // floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: "Description",
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                onTap: () {
                  _selectImage();
                },
                readOnly: true,
                onTapOutside: (event) {
                  FocusScope.of(context).unfocus();
                },
                decoration: const InputDecoration(
                  // filled: true,
                  // fillColor: Color(0xff1B1F2A),
                  // enabledBorder: OutlineInputBorder(
                  //     borderSide: BorderSide(color: Colors.white12)),
                  // floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: "Movie Poster",
                  hintText: "Click to Upload File",
                ),
              ),
              const SizedBox(height: 12,),
              weHaveImage
                  ? Image.file(
                      File(_imagePath ?? ''),
                      width: 170,
                      height: 200,
                      fit: BoxFit.cover,
                    )
                  : const Text('no image selected',style: TextStyle(fontSize: 18),)
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
        weHaveImage = true;
      });
    }
  }

  Future<void> _saveMovie() async {
    if (_nameController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _imagePath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("PLS fill all fields and select an image."),
        ),
      );
      return;
    }

    final movie = Movie(
      name: _nameController.text,
      description: _descriptionController.text,
      imagePath: _imagePath!,
    );

    final box = Hive.box<Movie>('movies');
    await box.add(movie);

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const BasePage()));
  }
}
