import 'package:flutter/material.dart';

class FullScreenImage extends StatelessWidget {
  final String imageUrl;

  const FullScreenImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(
              context); // Pop the fullscreen screen to exit fullscreen mode
        },
        child: Center(
          child: Hero(
            tag: imageUrl, // Tag for Hero animation
            child: Image.network(imageUrl), // Display the image
          ),
        ),
      ),
    );
  }
}
