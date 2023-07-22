import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mytube/models/channel_info.dart';
import 'package:mytube/utils/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = 'home-screen';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyTube'),
        centerTitle: true,
      ),
      body: FutureBuilder<ChannelInfo>(
        future: Services.getChannelInfo(),
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }
          if(snapshot.hasError){
            return Center(
              child: Column(
                children: [
                  Text('Something went wrong'),
                  TextButton(onPressed: (){}, child: Text('Try Again'),),
                ],
              ),
            );
          }
          return Container(
            color: Colors.white,
            child: ListView.builder(
              itemBuilder:(context,index){
                return Row(children: [
                  CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(
                      snapshot.data!.items[index].snippet.thumbnails.medium.url
                    ),
                  ),
                  Text('${snapshot.data!.items[index].snippet.title}'),
                ],);
              } ,
              itemCount: snapshot.data!.items.length,),
          );
        },
      ),
    );
  }
}
