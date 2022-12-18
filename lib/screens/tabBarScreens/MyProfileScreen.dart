import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/screens/imageLoader/ImageLoader.dart';
import 'package:flutter_course/screens/models/User.dart';
import 'package:image_picker/image_picker.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  bool isEditing = false;
  Color buttonColor = const Color(0xFF4d4d4d);
  final bioController = TextEditingController();

  @override
  void dispose() {
    bioController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: readUser(),
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong! $snapshot');
          } else if (snapshot.hasData) {
            final user = snapshot.data;

            if (user == null) {
              return const Center(child: Text('No User'));
            } else {
              bioController.text = user.bioDescription;
              return buildUser(user, context);
            }
          }
          return const Center(child: CircularProgressIndicator());
        }),
      ),
    );
  }

  // Get data of current logged in user
  Future<MyUser?> readUser() async {
    final userid = FirebaseAuth.instance.currentUser!.uid;
    final docUser = FirebaseFirestore.instance.collection('users').doc(userid);
    final snapshot = await docUser.get();

    if (snapshot.exists) {
      return MyUser.fromJson(snapshot.data()!);
    } else {
      return null;
    }
  }

  // Build user and present data information
  Widget buildUser(MyUser user, BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          FutureBuilder(
            future: ImageLoader.getImage(user.profileImagePath),
            builder: ((context, snapshot) {
              if (snapshot.hasError) {
                return Align(
                  alignment: Alignment(-0.9, 0),
                  child: Stack(
                    children: [
                      const ClipOval(
                          child: Image(
                        width: 100,
                        height: 100,
                        image: AssetImage('assets/images/blankprofile.jpg'),
                        fit: BoxFit.cover,
                      )),
                      if (isEditing)
                        Container(
                          decoration: const ShapeDecoration(
                            color: Colors.lightBlue,
                            shape: CircleBorder(),
                          ),
                          child: IconButton(
                            onPressed: (() {
                              pickImage(context, user.profileImagePath, false);
                            }),
                            icon: Icon(Icons.add_a_photo),
                          ),
                        ),
                    ],
                  ),
                );
              } else if (snapshot.hasData) {
                final image = snapshot.data;
                return Align(
                  alignment: const Alignment(-0.9, 0),
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTap: () => _deleteFile(image),
                        child: ClipOval(
                          child: Image.network(
                            image,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      if (isEditing)
                        Container(
                          decoration: const ShapeDecoration(
                            color: Colors.lightBlue,
                            shape: CircleBorder(),
                          ),
                          child: IconButton(
                            onPressed: (() {
                              pickImage(context, user.profileImagePath, false);
                            }),
                            icon: Icon(Icons.add_a_photo),
                          ),
                        ),
                    ],
                  ),
                );
              }
              return const Center(child: CircularProgressIndicator());
            }),
          ),
          const SizedBox(
            height: 18,
          ),
          Align(
            alignment: const Alignment(-0.9, 0.0),
            child: Text(
              user.username,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 5),
          if (!isEditing)
            Align(
              alignment: const Alignment(-0.9, 0.0),
              child: Text(
                user.bioDescription,
                style: const TextStyle(color: Colors.white),
              ),
            )
          else
            TextField(
              textAlignVertical: TextAlignVertical.top,
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 20,
              maxLength: 250,
              controller: bioController,
              textInputAction: TextInputAction.done,
              style: TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                  counterStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.white),
                  )),
            ),
          const SizedBox(height: 20),
          // TODO if the user is editing return a save button else edit profile
          if (!isEditing)
            Container(
              width: double.infinity,
              height: 30,
              margin: const EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  // TODO Change color
                  backgroundColor: buttonColor,
                ),
                onPressed: () {
                  isEditing = true;
                  setState(() {});
                },
                child: const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Edit Profile",
                  ),
                ),
              ),
            )
          else
            Container(
              width: double.infinity,
              height: 30,
              margin: const EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                ),
                onPressed: () {
                  isEditing = false;
                  saveUser();
                  setState(() {});
                },
                child: const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Save Profile",
                  ),
                ),
              ),
            ),
          const SizedBox(height: 10),

          FutureBuilder(
            future: ImageLoader.getImages(user.imagePaths),
            builder: ((context, snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong! $snapshot');
              } else if (snapshot.hasData) {
                return _buildGrid(snapshot.data!);
              }
              return const Center(child: CircularProgressIndicator());
            }),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              onPressed: () {
                pickImage(context, user.imagePaths, true);
              },
              child: const Icon(Icons.add_a_photo),
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> pickImage(
      BuildContext context, String imagePath, bool isProfileImage) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 180,
          color: Colors.amber,
          child: Column(
            children: <Widget>[
              ElevatedButton(
                onPressed: () =>
                    uploadImage(imagePath, ImageSource.gallery, isProfileImage),
                child: const Text("Pick Gallery"),
              ),
              const SizedBox(height: 5),
              ElevatedButton(
                onPressed: () =>
                    uploadImage(imagePath, ImageSource.camera, isProfileImage),
                child: const Text("Pick Camera"),
              ),
              const SizedBox(height: 5),
            ],
          ),
        );
      },
    );
  }

  Widget _buildGrid(List<String> paths) {
    return RefreshIndicator(
      onRefresh: () async => setState(() => {}),
      child: GridView.extent(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        maxCrossAxisExtent: 150,
        padding: const EdgeInsets.all(4),
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: List.generate(
          paths.length,
          (i) => GestureDetector(
            child: Image.network(paths[i]),
            onLongPress: () => _deleteFile(paths[i]),
          ),
        ),
      ),
    );
  }

  saveUser() {
    final userid = FirebaseAuth.instance.currentUser!.uid;
    final docUser = FirebaseFirestore.instance.collection("users").doc(userid);

    docUser.update({"bioDescription": bioController.text});
    setState(() {});
  }

  uploadImage(url, ImageSource source, isProfileImage) async {
    final selectedImage = await ImagePicker().pickImage(source: source);
    if (selectedImage != null) {
      File file = File(selectedImage.path);
      _uploadFile(file, url, isProfileImage).then((_) => setState(() => {}));
    }
  }

  Future<String> _uploadFile(File file, String url, bool isProfileImage) async {
    final filename = file.path.split('/').last;
    final String imagepath;
    if (isProfileImage) {
      imagepath = "$url$filename";
    } else {
      imagepath = url;
    }
    final ref = FirebaseStorage.instance.ref(imagepath);
    await ref.putFile(file); // upload file to Cloud Storage bucket
    return ref.getDownloadURL().toString();
  }

  _deleteFile(String url) {
    print(url);
    final filename = Uri.decodeFull(url.split('/').last.split('?').first);
    final ref = FirebaseStorage.instance.ref(filename);
    print(ref);

    ref.delete().then(
        (_) => setState(() => {})); // delete a file from Cloud Storage bucket
  }
}
