import 'package:flutter/material.dart';
import 'package:flutter_course/screens/imageLoader/ImageLoader.dart';
import '../../models/User.dart';

// The class UserProfile shows other profiles not the own one
class UserProfile extends StatefulWidget {
  const UserProfile({Key? key, this.user}) : super(key: key);
  final MyUser? user;
  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(widget.user!.username),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          FutureBuilder(
            future: ImageLoader.getImage(widget.user!.profileImagePath),
            builder: ((context, snapshot) {
              if (snapshot.hasError) {
                return const Align(
                  alignment: Alignment(-0.9, 0),
                  child: ClipOval(
                      child: Image(
                    width: 100,
                    height: 100,
                    image: AssetImage('assets/images/blankprofile.jpg'),
                    fit: BoxFit.cover,
                  )),
                );
              } else if (snapshot.hasData) {
                final image = snapshot.data;
                return Align(
                  alignment: const Alignment(-0.9, 0),
                  child: ClipOval(
                    child: Image.network(
                      image,
                      width: 100,
                      height: 100,
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
            alignment: const Alignment(-0.9, 0.0),
            child: Text(
              widget.user!.username,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Align(
            alignment: const Alignment(-0.9, 0.0),
            child: Text(
              widget.user!.bioDescription,
              // style: TextStyle(color: Colors.white),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          FutureBuilder(
            future: ImageLoader.getImages(widget.user!.imagePaths),
            builder: ((context, snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong! $snapshot');
              } else if (snapshot.hasData) {
                return _buildGrid(snapshot.data!);
              }
              return const Center(child: CircularProgressIndicator());
            }),
          ),
        ],
      ),
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
          (i) => Image.network(paths[i]),
        ),
      ),
    );
  }
}
