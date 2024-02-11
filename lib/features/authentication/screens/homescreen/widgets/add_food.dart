// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';

// import 'dart:io';
// import 'package:image_picker/image_picker.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;
// import 'package:http_parser/http_parser.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:mime/mime.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:vision/utils/constants/sizes.dart';

// /* pub spec yml
//   camera:
//   image_picker: ^1.0.4
//   mime:
// */
// class Addfood extends StatefulWidget {
//   const Addfood({super.key});

//   @override
//   AddfoodState createState() => AddfoodState();
// }

// class AddfoodState extends State<Addfood> {
//   int uniqueCode = DateTime.now().millisecondsSinceEpoch;
//   File? productPhoto;
//   final FirebaseStorage _storage = FirebaseStorage.instance;

//   Future<void> _takePicture() async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? image = await picker.pickImage(
//       source: ImageSource.camera,
//       imageQuality: 50,
//     );

//     _handleImageSelection(image);
//   }

//   Future<void> _selectPicture() async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? image = await picker.pickImage(
//       source: ImageSource.gallery,
//       imageQuality: 50,
//       maxWidth: 800,
//       maxHeight: 800,
//     );
//     _handleImageSelection(image);
//   }

//   void _handleImageSelection(XFile? image) {
//     if (image != null) {
//       setState(() {
//         productPhoto = File(image.path);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Respect for you"),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text(
//                     'Donate food . . .',
//                   ),
//                   const SizedBox(
//                     height: TSizes.defaultSpace,
//                   ),
//                   TextFormField(
//                     decoration: const InputDecoration(
//                       prefixIcon: Icon(Iconsax.bag_tick),
//                       labelText: "Food Name",
//                     ),
//                   ),
//                   const SizedBox(
//                     height: TSizes.spaceBtwInputFields,
//                   ),
//                   TextFormField(
//                     decoration: const InputDecoration(
//                       prefixIcon: Icon(Iconsax.category),
//                       labelText: "food Category",
//                     ),
//                   ),
//                   const SizedBox(
//                     height: TSizes.spaceBtwSections,
//                   ),
//                   const Text(
//                     'Upload food img...',
//                   ),
//                   const SizedBox(
//                     height: TSizes.spaceBtwSections,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       OutlinedButton(
//                         onPressed: _takePicture,
//                         child: const Text(' 🎥 Take Picture'),
//                       ),
//                       const SizedBox(width: 16),
//                       OutlinedButton(
//                         onPressed: _selectPicture,
//                         child: const Text(' 📱 Select Picture'),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//                   if (productPhoto != null)
//                     Image.file(
//                       productPhoto!,
//                       height: 100,
//                       width: 100,
//                       fit: BoxFit.cover,
//                     ),
//                   const SizedBox(height: 40),
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         uploadPicture();
//                       },
//                       child: const Text('submit'),
//                     ),
//                   ),
//                 ],
//               ),

//               // if (isLoading) const CircularProgressIndicator(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<String?> uploadPicture() async {
//     try {
// // Create a reference to the storage path with the custom name
//     Reference storageReference = _storage.ref().child('photos').child(productPhoto!.path);
//       await storageReference.putFile(productPhoto!);
//       // Get the download URL of the uploaded file
//       String downloadURL = await storageReference.getDownloadURL();      
//       print("Download Url : $downloadURL");
//       return downloadURL;
//     } on FirebaseException catch (e) {
//       print('Firebase Storage Error: $e');
//       return null;
//     }
//   }
// }


// Code by gtp

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
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
