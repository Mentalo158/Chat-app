import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_course/screens/tabBarScreens/UploadImage.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreenEdit extends StatefulWidget {
  const ProfileScreenEdit({super.key});

  @override
  State<ProfileScreenEdit> createState() => _ProfileScreenEditState();
}

class _ProfileScreenEditState extends State<ProfileScreenEdit> {
  final formKey = GlobalKey<FormState>();
  File? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF091123),
        automaticallyImplyLeading: false,
        title: Text('Change Profile'),
      ),
      body: Form(
        key: formKey,
        child: Center(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  image != null
                      ? Image.file(
                          image!,
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.fill,
                        )
                      : const Image(
                          image: AssetImage('assets/images/blankprofile.jpg'),
                          width: double.infinity,
                          height: 150,
                          fit: BoxFit.fill,
                        ),
                  // TODO CHANGE BUTTON
                  Positioned(
                    right: 5,
                    bottom: -5,
                    child: editButton(
                      changeProfileBanner,
                      const Icon(
                        Icons.add_a_photo,
                        size: 20,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -45,
                    left: 5,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        CircleAvatar(
                          radius: 45,
                          backgroundColor: Color(0xFF08172A),
                          child: image != null
                              ? Image.file(
                                  image!,
                                  fit: BoxFit.cover,
                                )
                              : const Image(
                                  image: AssetImage(
                                      'assets/images/blankprofile.jpg'),
                                  fit: BoxFit.cover,
                                ),
                        ),
                        Positioned(
                          top: -10,
                          right: -10,
                          child: editButton(
                            changeProfileBanner,
                            const Icon(
                              Icons.add_a_photo,
                              size: 20,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  ElevatedButton editButton(editImage, Icon icon) {
    return ElevatedButton(
      onPressed: editImage,
      style: ButtonStyle(
        shape: MaterialStateProperty.all(CircleBorder()),
        padding: MaterialStateProperty.all(EdgeInsets.all(5)),
        backgroundColor: MaterialStateProperty.all(Colors.blue), // Button color
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (states) {
            if (states.contains(MaterialState.pressed))
              return Colors.lightBlue; // Splash color
          },
        ),
      ),
      child: icon,
    );
  }

  Future changeProfileBanner() => showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 180,
            color: Colors.amber,
            child: Column(
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => pickImage(ImageSource.gallery),
                  child: Text("Pick Gallery"),
                ),
                const SizedBox(height: 5),
                ElevatedButton(
                  onPressed: () => pickImage(ImageSource.camera),
                  child: Text("Pick Camera"),
                ),
                const SizedBox(height: 5),
                ElevatedButton(
                  onPressed: uploadImage,
                  child: Text("Upload Photo"),
                ),
                // const SizedBox(height: 5),
                // ElevatedButton(
                //   onPressed: () => Navigator.pop(context),
                //   child: const Text('Close BottomSheet'),
                // )
              ],
            ),
          );
        },
      );

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
}
