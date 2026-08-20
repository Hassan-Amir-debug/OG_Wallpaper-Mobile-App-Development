import 'package:flutter/material.dart';
class ViewPage extends StatefulWidget {
  final String id;
  final List<String> favorites;

  const ViewPage({
    super.key,
    required this.id,
    required this.favorites,
  });

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  bool downloaded = false;

  @override
  Widget build(BuildContext context) {
    final isFav = widget.favorites.contains(widget.id);

    return Scaffold(
      appBar: AppBar(title: const Text("Preview")),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Image.network(
                widget.id,
                fit: BoxFit.contain,
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() => downloaded = true);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Downloaded")),
                  );
                },
                child: Text(downloaded ? "Downloaded ✓" : "Download"),
              ),

              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (isFav) {
                      widget.favorites.remove(widget.id);
                    } else {
                      widget.favorites.add(widget.id);
                    }
                  });
                },
                child: Text(isFav ? "Remove Favorite" : "Add Favorite"),
              ),
            ],
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
