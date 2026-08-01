import 'package:flutter/material.dart';
import 'home_page.dart';
import 'about_page.dart';
import 'fav_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int index = 0;

  final List<String> favorites = [];

  final categories = [
    "Car",
    "Painting",
    "Islamic",
    "Mountain",
    "Lahore",
  ];

  @override
  Widget build(BuildContext context) {
    final pages = [
      buildHome(),
      FavPage(favorites: favorites),
      const AboutPage(),
    ];

    return Scaffold(
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (i) => setState(() => index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorite"),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: "About"),
        ],
      ),
    );
  }

  Widget buildHome() {
    return Column(
      children: [
        const SizedBox(height: 50),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                "OG Wallpapers",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 38,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w900
                ),
              ),
              SizedBox(height: 8),
              Text(
                "by Hassan",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, i) {
              return categoryBox(context, categories[i]);
            },
          ),
        ),
      ],
    );
  }

  Widget categoryBox(BuildContext context, String name) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => HomePage(
              startCategory: name,
              favorites: favorites,
            ),
          ),
        ).then((_) => setState(() {}));
      },
      child: Container(
        height: 75,
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey.shade300,
        ),
        child: Text(
          name,
          style: const TextStyle(fontSize: 29, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
