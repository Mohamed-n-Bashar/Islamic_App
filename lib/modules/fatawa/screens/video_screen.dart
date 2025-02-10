import 'package:api_islamic/modules/fatawa/models/videos.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatefulWidget {
  final String id;
  final Video video;
  VideoScreen({required this.id, required this.video});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late YoutubePlayerController _controller; 

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.id,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // تأكد من تحرير المتحكم عند الانتهاء
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 183, 147, 95),
      ),
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.all(10),
        color: const Color.fromARGB(255, 250, 241, 228),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(0),
          child: ListView(
            children: [
              YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                // onReady: () {
                //   print('Player is ready.');
                // },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15 , left: 10, right: 10),
                child: Text(
                  widget.video.title,
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
