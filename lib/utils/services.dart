import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:mytube/models/channel_info.dart';
import 'package:mytube/utils/constants.dart';

import '../models/video_model.dart';

class Services{

  static Future<ChannelInfo>getChannelInfo()async{
    Map<String,String> parameters={
      'part':'snippet,contentDetails',
      'id':ChannelId,
      'key':APIKEY,
    };

    Map<String,String>headers={
      HttpHeaders.contentTypeHeader:'application/json'
    };

    Uri uri = Uri.https(
        BaseUrl,
        '/youtube/v3/channels',
        parameters
    );
    Response response = await http.get(uri,headers: headers);
    var json=jsonDecode(response.body);
    ChannelInfo channelInfo = ChannelInfo.fromJson(json);
    return channelInfo;
  }


  static Future<VideosModel>getVideosList({required String playlistId})async{
    Map<String,String> parameters={
      'part':'snippet',
      'playlistId':playlistId,
      'access_token':APIKEY,
      'key':APIKEY,
    };

    Map<String,String>headers={
      HttpHeaders.contentTypeHeader:'application/json'
    };

    Uri uri = Uri.https(
        BaseUrl,
        '/youtube/v3/playlistItems',
        parameters
    );
    Response response = await http.get(uri,headers: headers);
    var json=jsonDecode(response.body);
    VideosModel videosModel = VideosModel.fromJson(json);
    print(videosModel.videos.length);
    return videosModel;
  }
}