import 'package:api_islamic/modules/fatawa/models/channel_model.dart';
import 'package:api_islamic/modules/fatawa/models/videos.dart';
import 'package:api_islamic/modules/fatawa/screens/video_screen.dart';
import 'package:api_islamic/modules/fatawa/search_delegate.dart';
import 'package:api_islamic/modules/fatawa/services/api_service.dart';
import 'package:api_islamic/modules/widgets/my_scaffold.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final List<Video> videos; // قائمة الفيديوهات التي ستبحث فيها

  HomeScreen(this.videos);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Channel? _channel;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initChannel();
  }

  _initChannel() async {
    Channel channel = await APIService.instance
        .fetchChannel(channelId: 'UCWjCSGhmSGu0VLf2mPFS0Kg');
    setState(() {
      _channel = channel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      action: IconButton(
            icon: const Icon(
              Icons.search,
              size: 25,
            ),
            onPressed: () {
              showSearch(
                context: context,
                delegate: VideoSearchDelegate(widget
                    .videos), // تمرير قائمة الفيديوهات إلى الـ SearchDelegate
              );
            },
          ),
      title: 'فتاوي',
      body: _channel != null
          ? NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollDetails) {
                if (!_isLoading &&
                    _channel?.videos!.length !=
                        int.parse(_channel!.videoCount) &&
                    scrollDetails.metrics.pixels ==
                        scrollDetails.metrics.maxScrollExtent) {
                  _loadMoreVideos();
                }
                return false;
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ListView.builder(
                  itemCount: _channel!.videos!.length,
                  itemBuilder: (BuildContext context, int index) {
                    // if (index == 0) {
                    //   return _buildProfileInfo();
                    // }
                    Video video = _channel!.videos![index];
                    return _buildVideo(video);
                  },
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).dividerColor,
                ),
              ),
            ),
    );
  }

  _buildVideo(Video video) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => VideoScreen(
            id: video.id,
            video: video,
          ),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        padding: const EdgeInsets.all(10.0),
        height: 140.0,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 183, 147, 95),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 183, 147, 95),
              offset: Offset(0, 1),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            Image(
              width: 150.0,
              image: NetworkImage(video.thumbnailUrl),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(
                video.title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _loadMoreVideos() async {
    _isLoading = true;
    List<Video> moreVideos = await APIService.instance
        .fetchVideosFromPlaylist(playlistId: _channel!.uploadPlaylistId);
    List<Video> allVideos = _channel!.videos!..addAll(moreVideos);
    setState(() {
      _channel!.videos = allVideos;
    });
    _isLoading = false;
  }

  // اسم القناة اللي جايب منها الفيديوهات
  // _buildProfileInfo() {
  //   return Container(
  //     margin: const EdgeInsets.all(20.0),
  //     padding: const EdgeInsets.all(20.0),
  //     height: 100.0,
  //     decoration: const BoxDecoration(
  //       color: Colors.white,
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black12,
  //           offset: Offset(0, 1),
  //           blurRadius: 6.0,
  //         ),
  //       ],
  //     ),
  //     child: Row(
  //       children: <Widget>[
  //         CircleAvatar(
  //           backgroundColor: Colors.white,
  //           radius: 35.0,
  //           backgroundImage: NetworkImage(_channel!.profilePictureUrl),
  //         ),
  //         const SizedBox(width: 12.0),
  //         Expanded(
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: <Widget>[
  //               Text(
  //                 _channel!.title,
  //                 style: const TextStyle(
  //                   color: Colors.black,
  //                   fontSize: 20.0,
  //                   fontWeight: FontWeight.w600,
  //                 ),
  //                 overflow: TextOverflow.ellipsis,
  //               ),
  //               Text(
  //                 '${_channel!.subscriberCount} subscribers',
  //                 style: TextStyle(
  //                   color: Colors.grey[600],
  //                   fontSize: 16.0,
  //                   fontWeight: FontWeight.w600,
  //                 ),
  //                 overflow: TextOverflow.ellipsis,
  //               ),
  //             ],
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }
}
