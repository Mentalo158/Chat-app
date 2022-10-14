import 'package:flutter/material.dart';

class profileScreen extends StatelessWidget {
  const profileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String _bioDescription = "Test 123";

    // Seperator is just size box
    Widget Seperator(double distance) {
      return SizedBox(
        height: distance,
      );
    }

    // TODO change prof look
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            children: [
              Container(
                child: Image.asset('assets/images/imageheader.jpg'),
                height: 150,
                width: double.infinity,
              ),
              // FIXME Align shit doesn't stick to the bottom
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  child: Image.asset('assets/images/imageprofile.jpg'),
                  height: 50,
                  width: 50,
                ),
              )
            ],
          ),
          Seperator(20),
          // TODO change align to positioned?
          Container(
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(_bioDescription),
            ),
          ),
          // TODO Bio box
          Seperator(80),
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
        children: _buildGridTileList(0),
      );

  List<Container> _buildGridTileList(int count) => List.generate(
        count,
        (i) => Container(child: Image.asset('assets/image$i.jpg')),
      );
}
