import 'package:flutter/material.dart';
import 'package:flutter_course/screens/tabBarScreens/ProfileScreenEdit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String _bioDescription = "Test 123";
    String _userName = "YeP";

    // TODO change prof look
    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[
            profileTop(),
            // TODO change align to positioned?
            seperator(50),
            Container(
              margin: EdgeInsets.only(left: 30),
              child: Text(
                _bioDescription,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            seperator(5),
            Container(
              margin: EdgeInsets.only(left: 30),
              child: Text(
                _bioDescription,
                style: TextStyle(color: Colors.white),
              ),
            ),

            seperator(50),
            // TODO Bio box
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
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProfileScreenEdit(),
                  ),
                ),
                child: const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Edit Profile",
                  ),
                ),
              ),
            ),
            seperator(10),
            Expanded(
              child: buildGridView(),
            )
          ],
        ),
      ),
    );
  }

  // Seperator is just size box
  Widget seperator(double distance) {
    return SizedBox(
      height: distance,
    );
  }

  Widget profileTop() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Image.asset(
          'assets/images/imageheader.jpg',
          width: double.infinity,
          height: 150,
          fit: BoxFit.cover,
        ),
        // FIXME Align shit doesn't stick to the bottom
        const Positioned(
          bottom: -45,
          left: 5,
          child: CircleAvatar(
            radius: 45,
            backgroundColor: Color(0xFF08172A),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/imageprofile.jpg'),
              radius: 40,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildGridView() => GridView.builder(
        //define how many columns one row has
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          crossAxisCount: 4,
        ),
        // disable scrolling and infinite size error
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 50,
        itemBuilder: ((context, index) => buildImageCard(index)),
      );

  Widget buildImageCard(int index) => Card(
        margin: EdgeInsets.zero,
        color: Color.fromARGB(255, 1, 34, 51),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          margin: EdgeInsets.all(8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/images/imageheader$index.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
}
