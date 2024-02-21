// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


/* pub spec yml
  camera:
  image_picker: ^1.0.4
  mime:
*/
class ShopProductAddScreen extends StatefulWidget {
  const ShopProductAddScreen({super.key});

  @override
  ShopProductAddScreenState createState() => ShopProductAddScreenState();
}

class ShopProductAddScreenState extends State<ShopProductAddScreen> {
  int uniqueCode = DateTime.now().millisecondsSinceEpoch;
  File? productPhoto;

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



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Add Page"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: _takePicture,
                        child: const Text('Take Picture'),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
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
                ],
              ),

              // if (isLoading) const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
