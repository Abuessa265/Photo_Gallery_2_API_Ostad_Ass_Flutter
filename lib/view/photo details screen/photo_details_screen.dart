import 'package:flutter/material.dart';

import 'custom widgets/custom_image.dart';
import 'custom widgets/custom_text.dart';

class PhotoDetailsScreen extends StatelessWidget {
  final String imgUrl;
  final String title;
  final String id;

  const PhotoDetailsScreen({
    Key? key,
    required this.imgUrl,
    required this.title,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Photo Details'),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            buildImage(imgUrl),
            const SizedBox(height: 20),
            buildText('Title', title),
            const SizedBox(height: 15),
            Center(child: buildText('ID', id)),
          ],
        ),
      ),
    );
  }
}
