import 'package:flutter/material.dart';
import 'view_page.dart';

class FavPage extends StatefulWidget {
  final List<String> favorites;

  const FavPage({super.key, required this.favorites});

  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Favorites")),
      body: widget.favorites.isEmpty
          ? const Center(child: Text("No favorites"))
          : GridView.builder(
        itemCount: widget.favorites.length,
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        padding: const EdgeInsets.all(10),
        itemBuilder: (_, i) {
          final id = widget.favorites[i];

          return GestureDetector(
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ViewPage(
                    id: id,
                    favorites: widget.favorites,
                  ),
                ),
              );
              setState(() {});
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                id,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}