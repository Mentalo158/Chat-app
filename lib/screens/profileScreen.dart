import 'package:flutter/material.dart';

class profileScreen extends StatelessWidget {
  const profileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO change prof look
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                child: Image.asset('assets/imageheader.jpg'),
                height: 150,
                width: double.infinity,
              ),
              // FIXME Align shit doesn't stick to the bottom
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  child: Image.asset('assets/imageprofile.jpg'),
                  height: 50,
                  width: 50,
                ),
              )
            ],
          ),
          // TODO Bio box
          SizedBox(
            height: 200,
          ),
          Expanded(child: _buildGrid())
        ],
      ),
    );
  }

  Widget _buildGrid() => GridView.extent(
        maxCrossAxisExtent: 150,
        padding: const EdgeInsets.all(4),
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        // TODO make int amount dynamic
        children: _buildGridTileList(30),
      );

  List<Container> _buildGridTileList(int count) => List.generate(
        count,
        (i) => Container(child: Image.asset('assets/image$i.jpg')),
      );
}
