import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/screens/models/User.dart';
import 'package:image_picker/image_picker.dart';
// TODO add permission handler? maybe

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FutureBuilder(
            future: readUser(),
            builder: ((context, snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong! $snapshot');
              } else if (snapshot.hasData) {
                final user = snapshot.data;

                return user == null
                    ? const Center(child: Text('No User'))
                    : Expanded(child: buildUser(user, context));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
          ),
        ],
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
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          FutureBuilder(
            future: getImage(user.profileImagePath),
            builder: ((context, snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong! $snapshot');
              } else if (snapshot.hasData) {
                final image = snapshot.data;
                return Align(
                  alignment: const Alignment(-0.9, 0),
                  child: image != null
                      ? ClipOval(
                          child: Image.network(
                            image,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const ClipOval(
                          child: Image(
                            image: AssetImage('assets/images/blankprofile.jpg'),
                            fit: BoxFit.cover,
                          ),
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
            alignment: Alignment(-0.9, 0.0),
            child: Text(
              user.username,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Align(
            alignment: Alignment(-0.9, 0.0),
            child: Text(
              user.bioDescription,
              // style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 50),
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
                  backgroundColor: Colors.blue[900],
                ),
                onPressed: () {
                  isEditing = true;
                  setState(() {});
                },
                // () => Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => ProfileScreenEdit(user: user),
                //   ),
                // ),
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
                  backgroundColor: Colors.blue[900],
                ),
                onPressed: () {
                  isEditing = false;
                  setState(() {});
                },
                // () => Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => ProfileScreenEdit(user: user),
                //   ),
                // ),
                child: const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Save Profile",
                  ),
                ),
              ),
            ),
          const SizedBox(height: 10),
          Expanded(
            child: FutureBuilder(
              future: getImages(user.imagePaths),
              builder: ((context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong! $snapshot');
                } else if (snapshot.hasData) {
                  return Scaffold(
                      body: _buildGrid(snapshot.data!),
                      floatingActionButton: Visibility(
                        visible: isEditing,
                        child: FloatingActionButton(
                            onPressed: () {
                              pickImage(context, user);
                            },
                            child: Icon(Icons.add_a_photo)),
                      ));
                }
                return const Center(child: CircularProgressIndicator());
              }),
            ),
          )
        ],
      ),
    );
  }

  Future<dynamic> pickImage(BuildContext context, MyUser user) {
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
                    uploadImage(user.imagePaths, ImageSource.gallery),
                child: const Text("Pick Gallery"),
              ),
              const SizedBox(height: 5),
              ElevatedButton(
                onPressed: () =>
                    uploadImage(user.imagePaths, ImageSource.camera),
                child: const Text("Pick Camera"),
              ),
              const SizedBox(height: 5),
            ],
          ),
        );
      },
    );
  }

  uploadImage(url, ImageSource source) async {
    final selectedImage = await ImagePicker().pickImage(source: source);
    if (selectedImage != null) {
      File file = File(selectedImage.path);
      _uploadFile(file, url).then((_) => setState(() => {}));
    }
  }

  Future<List<String>> getImages(String paths) async {
    final ref = await FirebaseStorage.instance.ref(paths).listAll();
    List<String> urls = await Future.wait(ref.items.map((ref) async {
      return await ref.getDownloadURL();
    }));
    return urls;
  }

  Widget _buildGrid(List<String> paths) {
    return RefreshIndicator(
        onRefresh: () async => setState(() => {}),
        child: GridView.extent(
            physics: const NeverScrollableScrollPhysics(),
            maxCrossAxisExtent: 150,
            padding: const EdgeInsets.all(4),
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            children: List.generate(
                paths.length,
                (i) => GestureDetector(
                    child: Image.network(paths[i]),
                    onLongPress: () => _deleteFile(paths[i])))));
  }

  Future<String> _uploadFile(File file, String url) async {
    final filename = file.path.split('/').last;
    final imagepath = "$url$filename";
    final ref = FirebaseStorage.instance.ref(imagepath);
    print(ref);
    await ref.putFile(file); // upload file to Cloud Storage bucket
    return ref.getDownloadURL().toString();
  }

  _deleteFile(String url) {
    final filename = Uri.decodeFull(url.split('/').last.split('?').first);
    final ref = FirebaseStorage.instance.ref(filename);

    ref.delete().then(
        (_) => setState(() => {})); // delete a file from Cloud Storage bucket
  }

  Future getImage(String path) async {
    final ref = FirebaseStorage.instance.ref(path);
    print(ref);
    return await ref.getDownloadURL();
  }
}
