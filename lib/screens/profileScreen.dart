import 'package:flutter/material.dart';

class profileScreen extends StatelessWidget {
  const profileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO change prof looks shit
    return Scaffold( body: Column(children: [Expanded(child: _buildGrid())],),
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
        (i) => Container(child: Image.asset('images/image$i.jpg')),
      );
}
