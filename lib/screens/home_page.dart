import 'package:flutter/material.dart';
import 'view_page.dart';

class HomePage extends StatelessWidget {
  final String startCategory;
  final List<String> favorites;

  const HomePage({
    super.key,
    required this.startCategory,
    required this.favorites,
  });

  final data = const {
    "Car": [
      "assets/image/car/c1.png",
      "assets/image/car/c2.png",
      "assets/image/car/c3.png",
      "assets/image/car/c4.png",
      "assets/image/car/c5.png",
      "assets/image/car/c6.png",
      "assets/image/car/c7.png",
      "assets/image/car/c8.png",
    ],
    "Painting": [
      "assets/image/painting/p1.png",
      "assets/image/painting/p2.png",
      "assets/image/painting/p3.png",
      "assets/image/painting/p4.png",
      "assets/image/painting/p5.png",
      "assets/image/painting/p6.png",
      "assets/image/painting/p7.png",
      "assets/image/painting/p8.png",
    ],
    "Islamic": [
      "assets/image/islamic/i1.png",
      "assets/image/islamic/i2.png",
      "assets/image/islamic/i3.png",
      "assets/image/islamic/i4.png",
      "assets/image/islamic/i5.png",
      "assets/image/islamic/i6.png",
      "assets/image/islamic/i7.png",
      "assets/image/islamic/i8.png",
    ],
    "Mountain": [
      "assets/image/mountain/m1.png",
      "assets/image/mountain/m2.png",
      "assets/image/mountain/m3.png",
      "assets/image/mountain/m4.png",
      "assets/image/mountain/m5.png",
      "assets/image/mountain/m6.png",
      "assets/image/mountain/m7.png",
      "assets/image/mountain/m8.png",
    ],
    "Lahore": [
      "assets/image/lahore/l1.png",
      "assets/image/lahore/l2.png",
      "assets/image/lahore/l3.png",
      "assets/image/lahore/l4.png",
      "assets/image/lahore/l5.png",
      "assets/image/lahore/l6.png",
      "assets/image/lahore/l7.png",
      "assets/image/lahore/l8.png",
    ],
  };

  @override
  Widget build(BuildContext context) {
    final items = data[startCategory]!;

    return Scaffold(
      appBar: AppBar(title: Text(startCategory)),
       body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.7,
        padding: const EdgeInsets.all(10),
        children: items.map((id) {
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ViewPage(
                  id: id,
                  favorites: favorites,
                ),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                id,
                fit: BoxFit.cover,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
