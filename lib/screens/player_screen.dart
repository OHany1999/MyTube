
import 'package:flutter/material.dart';
import 'package:mytube/models/video_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlayerScreen extends StatefulWidget {
  VideoItem videoItem;
  PlayerScreen(this.videoItem);
  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  YoutubePlayerController? controller;
  bool? isReady;
  @override
  void initState() {
    // TODO: implement initState
    isReady = false;
    controller = YoutubePlayerController(
        initialVideoId: widget.videoItem.snippet.resourceId.videoId,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );

  }

  @override
  void dispose() {
    controller!.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void deactivate() {
    controller!.dispose();
    // TODO: implement deactivate
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.videoItem.snippet.title),
      ),
      body: Container(
        child: YoutubePlayer(
          controller: controller!,
          showVideoProgressIndicator: true,
          onReady: (){
            isReady = true;
          },
        ),
      ),
    );
  }
}
