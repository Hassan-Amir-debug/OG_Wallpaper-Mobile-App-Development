import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'view_page.dart';

class HomePage extends StatefulWidget {
  final String startCategory;
  final List<String> favorites;

  const HomePage({
    super.key,
    required this.startCategory,
    required this.favorites,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> images = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchWallpapers();
  }

  Future<void> fetchWallpapers() async {
  try {
    final url = Uri.parse(
      'http://127.0.0.1:8000/wallpapers/${widget.startCategory}',
    );

    print("Calling API: $url");

    final response = await http.get(url);

    print("Status code: ${response.statusCode}");
    print("Response: ${response.body}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      setState(() {
        images = List<String>.from(data['images']);
        loading = false;
      });
    } else {
      print("API ERROR");
    }
  } catch (e) {
    print("ERROR: $e");

    setState(() {
      loading = false;
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.startCategory),
      ),

      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.7,
              padding: const EdgeInsets.all(10),

              children: images.map((imageUrl) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ViewPage(
                          id: imageUrl,
                          favorites: widget.favorites,
                        ),
                      ),
                    );
                  },

                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }).toList(),
            ),
    );
  }
}