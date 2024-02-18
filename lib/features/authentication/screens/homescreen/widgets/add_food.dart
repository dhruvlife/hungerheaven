
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Addfood extends StatefulWidget {
  const Addfood({Key? key}) : super(key: key);

  @override
  _AddfoodState createState() => _AddfoodState();
}

class _AddfoodState extends State<Addfood> {
  File? productPhoto;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> _takePicture() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );

    _handleImageSelection(image);
  }

  Future<void> _selectPicture() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 800,
      maxHeight: 800,
    );
    _handleImageSelection(image);
  }

  void _handleImageSelection(XFile? image) {
    if (image != null) {
      setState(() {
        productPhoto = File(image.path);
      });
    }
  }

  Future<void> uploadPicture() async {
    try {
      if (productPhoto != null) {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        Reference storageReference =
            _storage.ref().child('photos').child(fileName);

        await storageReference.putFile(productPhoto!);

        String downloadURL = await storageReference.getDownloadURL();

        print("Download URL: $downloadURL");

        // Here, you can use the downloadURL as needed, for example, save it to Firestore or use it in your app.

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Image uploaded successfully."),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Please select an image."),
          ),
        );
      }
    } catch (e) {
      print('Firebase Storage Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error uploading image."),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Respect for you"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Donate food . . .',
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.camera),
                      labelText: "Food Name",
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.category),
                      labelText: "Food Category",
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    'Upload food image...',
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      OutlinedButton(
                        onPressed: _takePicture,
                        child: const Text('Take Picture'),
                      ),
                      const SizedBox(width: 16),
                      OutlinedButton(
                        onPressed: _selectPicture,
                        child: const Text('Select Picture'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (productPhoto != null)
                    Image.file(
                      productPhoto!,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: uploadPicture,
                      child: const Text('Submit'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// location code :

