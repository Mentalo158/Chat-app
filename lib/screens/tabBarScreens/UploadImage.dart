import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
// add permission handler
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File? image;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final file = File(image.path);

      setState(
        () {
          this.image = file;
        },
      );
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  // TODO change make the profile path individuell for banner and profile
  Future uploadImage() async {
    if (image != null) {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final docUser =
          FirebaseFirestore.instance.collection('users').doc(userId);
      final snapshot = await docUser.get();

      final user = snapshot.data();
      final imagePath = user!['profileImagePath'];
      final path = 'users/$imagePath.jpg';
      final file = File(image!.path);

      final ref = FirebaseStorage.instance.ref().child(path);
      ref.putFile(file);
    } else {
      const snackBar = SnackBar(
        content: Text('Please select a Image'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Upload Image',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            image != null
                ? Image.file(
                    image!,
                    width: 160,
                    height: 160,
                    fit: BoxFit.cover,
                  )
                : const FlutterLogo(size: 160),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: () => pickImage(ImageSource.gallery),
              child: Text("Pick Gallery"),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => pickImage(ImageSource.camera),
              child: Text("Pick Camera"),
            ),
            ElevatedButton(
              onPressed: uploadImage,
              child: Text("Upload Photo"),
            ),
            Spacer()
          ],
        ),
      ),
    );
  }
}


// rules_version = '2';
// service firebase.storage {
//   match /b/{bucket}/o {
//     match /{allPaths=**} {
//       allow read, write: if false;
//     }
//   }
// }
