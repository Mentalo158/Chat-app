import 'package:flutter/material.dart';

class ProfileScreenEdit extends StatefulWidget {
  const ProfileScreenEdit({super.key});

  @override
  State<ProfileScreenEdit> createState() => _ProfileScreenEditState();
}

class _ProfileScreenEditState extends State<ProfileScreenEdit> {
  final formKey = GlobalKey<FormState>();

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
                  Image.asset(
                    'assets/images/imageheader.jpg',
                    width: double.infinity,
                    height: 150,
                    fit: BoxFit.cover,
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
                        const CircleAvatar(
                          radius: 45,
                          backgroundColor: Color(0xFF08172A),
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/imageprofile.jpg'),
                            radius: 40,
                          ),
                        ),
                        Positioned(
                          top: -10,
                          right: -10,
                          child: editButton(
                            changeProfileBanner,
                            Icon(
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

  changeProfileBanner() {
    print("test");
  }

  changeProfileImage() {
    print('test');
  }
}
