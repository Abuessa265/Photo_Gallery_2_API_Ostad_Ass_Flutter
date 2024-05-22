import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
//import 'package:get_data_from_api/view/photo%20details%20screen/photo_details_screen.dart';
import 'package:http/http.dart' as http;

import '../../model/photos_list_model.dart';
import '../photo details screen/photo_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PhotosList> photosList = [];

  Future<List<PhotosList>> getDataFromApi() async {
    String getPhotosUrl = 'https://jsonplaceholder.typicode.com/photos';

    var response = await http.get(Uri.parse(getPhotosUrl));
    var jsonData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      print('200 ok');
      for (Map<String, dynamic> index in jsonData) {
        photosList.add(PhotosList.fromJson(index));
      }
      return photosList;
    } else {
      print('Failed');
      return photosList;
    }
  }

  @override
  initState() {
    super.initState();
    getDataFromApi().then((value) {
      setState(() {
        photosList = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Photo Gallery App'),
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: getDataFromApi(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text('Error ${snapshot.error}');
          } else if (snapshot.hasData) {
            return ListView.separated(
              shrinkWrap: true,
              itemCount: 100,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                    return PhotoDetailsScreen(
                      imgUrl: photosList[index].url.toString(),
                      title: photosList[index].title.toString(),
                      id: photosList[index].id.toString(),
                    );
                  })),
                  leading: CachedNetworkImage(
                    imageUrl: photosList[index].thumbnailUrl.toString(),
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  title: Text(photosList[index].title.toString()),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
            );
          } else {
            return const Text('No data found');
          }
        },
      ),
    );
  }
}
