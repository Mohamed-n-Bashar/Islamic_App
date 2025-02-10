import 'package:api_islamic/modules/fatawa/models/channel_model.dart';
import 'package:api_islamic/modules/fatawa/models/videos.dart';
import 'package:api_islamic/modules/fatawa/screens/home_screen.dart';
import 'package:api_islamic/modules/fatawa/services/api_service.dart';
import 'package:flutter/material.dart';

class FatawaScreen extends StatelessWidget {
  const FatawaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Video>>(
        future: fetchVideos(), // استدعاء الدالة لجلب الفيديوهات
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No videos found.'));
          } else {
            // تمرير قائمة الفيديوهات إلى YourHomePage
            return HomeScreen(snapshot.data!);
          }
        },
      );
      }

  Future<List<Video>> fetchVideos() async {
    // تأكد من استدعاء الـ APIService لتحميل الفيديوهات
    APIService apiService = APIService.instance;

    // مثال على كيفية استدعاء fetchChannel وتحميل الفيديوهات
    Channel channel = await apiService.fetchChannel(channelId: 'UC6Dy0rQ6zDnQuHQ1EeErGUA');
    return channel.videos ?? [];
  }
}
