import 'package:api_islamic/modules/fatawa/models/videos.dart';
import 'package:api_islamic/modules/fatawa/screens/video_screen.dart';
import 'package:flutter/material.dart';

class VideoSearchDelegate extends SearchDelegate {
  final List<Video> videos; 

  VideoSearchDelegate(this.videos); 

  @override
  String? get searchFieldLabel => ''; 

  @override
  TextStyle? get searchFieldStyle => const TextStyle(
        fontSize: 16, 
        color: Colors.black,
        fontWeight: FontWeight.normal
      );


  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = ''; 
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = videos.where((video) => video.title.contains(query)).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final video = results[index];
        return ListTile(
          title: Text(video.title),
          textColor: Color.fromARGB(255, 183, 147, 95),
          onTap: () {
            Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => VideoScreen(id: video.id, video: video,),),);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = videos.where((video) => video.title.toLowerCase().contains(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final video = suggestions[index];
        return ListTile(
          title: Text(video.title),
          textColor: Color.fromARGB(255, 183, 147, 95),
          onTap: () {
            query = video.title; 
            showResults(context); 
          },
        );
      },
    );
  }
}
