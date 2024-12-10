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

class _AddPageState extends State<AddPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _imagePath;

  final ImagePicker _picker = ImagePicker(); // ImagePicker instance

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff131722),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xff1B1F2A),
        title: const Text("Add Movie"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
              controller: _nameController,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Color(0xff1B1F2A),
                border: OutlineInputBorder(),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelText: "Name",
                hintText: "e.g. Avengers",
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
              controller: _descriptionController,
              maxLines: 5,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Color(0xff1B1F2A),
                border: OutlineInputBorder(),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelText: "Description",
              ),
              
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _selectImage,
              child: const Text("Select Image"),
            ),
            if (_imagePath != null) ...[
              const SizedBox(height: 16.0),
              Text("Selected Image: $_imagePath"),
            ],
            const Spacer(),
            ElevatedButton(
              onPressed: _saveMovie,
              child: const Text("Save Movie"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path; // Save the path of the selected image
      });
    }
  }

  Future<void> _saveMovie() async {
    if (_nameController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _imagePath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all fields and select an image."),
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
