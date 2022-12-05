import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_course/screens/models/User.dart';
import 'package:flutter_course/screens/tabBarScreens/UploadImage.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreenEdit extends StatefulWidget {
  final MyUser user;

  const ProfileScreenEdit({Key? key, required this.user}) : super(key: key);

  @override
  State<ProfileScreenEdit> createState() => _ProfileScreenEditState(user);
}

class _ProfileScreenEditState extends State<ProfileScreenEdit> {
  _ProfileScreenEditState(this.user);
  String test = "hallo";
  final formKey = GlobalKey<FormState>();
  final bioController = TextEditingController();
  File? image;
  final MyUser user;

  // @override
  // void initState() {
  //   super.initState();
  //   bioController.text = user.bioDescription;
  // }

  @override
  void dispose() {
    bioController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF091123),
        automaticallyImplyLeading: true,
        title: const Text('Change Profile'),
      ),
      body: Form(
        key: formKey,
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  FutureBuilder(
                      future: getImage(user.profileImagePath),
                      builder: ((context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('Something went wrong! $snapshot');
                        } else if (snapshot.hasData) {
                          final image = snapshot.data;
                          return Align(
                            alignment: Alignment.topLeft,
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
                                      image: AssetImage(
                                          'assets/images/blankprofile.jpg'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          );
                        }
                        return const Center(child: CircularProgressIndicator());
                      })),
                  Align(
                    alignment: Alignment(-0.65, -0.5),
                    child: Positioned(
                      top: -10,
                      right: -10,
                      child: editButton(
                        changeProfileBanner,
                        const Icon(
                          Icons.add_a_photo,
                          size: 20,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
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
                alignment: Alignment(-0.8, 0.0),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    height: 100,
                    // TODO Überschrieft hinzufügen
                    child: TextFormField(
                      textAlignVertical: TextAlignVertical.top,
                      expands: true,
                      minLines: null,
                      maxLines: null,
                      controller: bioController,
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        if (value!.length <= 250) {
                          return null;
                        } else {
                          return 'Only 250 letters allowed';
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: saveUser,
                  child: Text("Save Profile"),
                ),
              )
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
      final path = imagePath;
      final file = File(image!.path);

      final ref = FirebaseStorage.instance.ref().child(path);
      ref.putFile(file);
    } else {
      return;
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

  saveUser() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    final userid = FirebaseAuth.instance.currentUser!.uid;
    final docUser = FirebaseFirestore.instance.collection("users").doc(userid);

    docUser.update({"bioDescription": bioController});

    await uploadImage();
    setState(() {});
  }

  Future getImage(String path) async {
    final ref = FirebaseStorage.instance.ref(path);
    print(ref);
    return await ref.getDownloadURL();
  }
}
