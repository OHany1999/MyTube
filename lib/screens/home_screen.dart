import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mytube/models/channel_info.dart';
import 'package:mytube/models/video_model.dart';
import 'package:mytube/screens/player_screen.dart';
import 'package:mytube/utils/services.dart';

import '../utils/constants.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.play_circle, size: 45),
        title: Text('MyTube',style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: Column(
        children: [
          FutureBuilder<ChannelInfo>(
            future: Services.getChannelInfo(),
            builder: (context, snapshotForChannelInfo) {
              if (snapshotForChannelInfo.connectionState ==
                  ConnectionState.waiting) {
                return Center();
              }
              if (snapshotForChannelInfo.hasError) {
                return Center(
                  child: Column(
                    children: [
                      Text('Something went wrong'),
                      TextButton(
                        onPressed: () {},
                        child: Text('Try Again'),
                      ),
                    ],
                  ),
                );
              }
              return Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(5),
                ),
                margin: EdgeInsets.all(20),

                padding: EdgeInsets.all(10.0),
                height: 85,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: CachedNetworkImageProvider(
                              snapshotForChannelInfo.data!.items[index].snippet
                                  .thumbnails.medium.url),
                        ),
                        SizedBox(
                          height:8,
                        ),
                        Text(
                            '${snapshotForChannelInfo.data!.items[index].snippet.title}',style: TextStyle(fontWeight: FontWeight.w500),),
                      ],
                    );
                  },
                  itemCount: snapshotForChannelInfo.data!.items.length,
                ),
              );
            },
          ),
          FutureBuilder<VideosModel>(
            future: Services.getVideosList(playlistId: PlayListId),
            builder: (context, snapshotForVideoList) {
              if (snapshotForVideoList.connectionState ==
                  ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshotForVideoList.hasError) {
                print('err:${snapshotForVideoList.error}');
                return Center(
                  child: Column(
                    children: [
                      Text('Something went wrong'),
                      TextButton(
                        onPressed: () {},
                        child: Text('Try Again'),
                      ),
                    ],
                  ),
                );
              }
              return ListView.separated(
                  shrinkWrap: true,
                  itemCount: snapshotForVideoList.data!.videos.length,
                  separatorBuilder: (context, index) => Container(
                        height: 1,
                        width: 1,
                        color: Colors.grey,
                      ),
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(10.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PlayerScreen(
                                      snapshotForVideoList
                                          .data!.videos[index])));
                        },
                        child: Row(
                          children: [
                            CachedNetworkImage(
                              imageUrl: snapshotForVideoList.data!.videos[index]
                                  .snippet.thumbnails.thumbnailsDefault.url,
                              height: 100,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: Text(
                                snapshotForVideoList
                                    .data!.videos[index].snippet.title,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),
                              ),
                            ),

                          ],
                        ),
                      ),
                    );
                  });
            },
          ),
        ],
      ),
    );
  }
}
