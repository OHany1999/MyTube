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
        title: Text('MyTube'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            height: 70,
            child: FutureBuilder<ChannelInfo>(
              future: Services.getChannelInfo(),
              builder: (context,snapshotForChannelInfo){
                if(snapshotForChannelInfo.connectionState == ConnectionState.waiting){
                  return Center();
                }
                if(snapshotForChannelInfo.hasError){
                  return Center(
                    child: Column(
                      children: [
                        Text('Something went wrong'),
                        TextButton(onPressed: (){}, child: Text('Try Again'),),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  itemBuilder:(context,index){
                    return Column(
                      children: [
                        Row(children: [
                          CircleAvatar(
                            backgroundImage: CachedNetworkImageProvider(
                                snapshotForChannelInfo.data!.items[index].snippet.thumbnails.medium.url
                            ),
                          ),
                          SizedBox(width: 10,),
                          Text('${snapshotForChannelInfo.data!.items[index].snippet.title}'),
                        ],),
                      ],
                    );
                  } ,
                  itemCount: snapshotForChannelInfo.data!.items.length,);
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<VideosModel>(
              future: Services.getVideosList(
                  playlistId: PlayListId),
              builder:(context,snapshotForVideoList){
                if(snapshotForVideoList.connectionState == ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator());
                }
                if(snapshotForVideoList.hasError){
                  return Center(
                    child: Column(
                      children: [
                        Text('Something went wrong'),
                        TextButton(onPressed: (){}, child: Text('Try Again'),),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                    itemCount:snapshotForVideoList.data!.videos.length ,
                    itemBuilder: (context,index){
                      return Container(
                        padding: EdgeInsets.all(10.0),
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>PlayerScreen(snapshotForVideoList.data!.videos[index])));
                          },
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: snapshotForVideoList.data!.videos[index].snippet.thumbnails.thumbnailsDefault.url,
                          ),
                                  SizedBox(width: 10,),
                                  Flexible(child: Text(snapshotForVideoList.data!.videos[index].snippet.title)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}


