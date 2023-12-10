//Petalcorin, Anne Rachel S. - IT3R6
//JSON Placeholder

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyAlbum());
}

class MyAlbum extends StatelessWidget {
  const MyAlbum({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Album View',
      debugShowCheckedModeBanner: false,
      home: const MyPhotos(),
    );
  }
}

class MyPhotos extends StatefulWidget {
  const MyPhotos({Key? key});

  @override
  State<MyPhotos> createState() => _MyPhotosState();
}

class _MyPhotosState extends State<MyPhotos> {
  List<dynamic> posts = [];

  @override
  void initState() {
    super.initState();
    getPosts();
  }

  getPosts() async {
    var url = Uri.parse("http://jsonplaceholder.typicode.com/photos");
    var response = await http.get(url);

    setState(() {
      posts = json.decode(response.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Album"),
        backgroundColor: Colors.blue,
      ),
      body: posts.isNotEmpty
          ? GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Image.network(
                    posts[index]["thumbnailUrl"],
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    posts[index]["title"],
                  ),
                ),
              ],
            ),
          );
        },
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
