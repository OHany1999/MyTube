import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:mytube/models/channel_info.dart';
import 'package:mytube/utils/constants.dart';

class Services{

  static const String ChannelId = 'UCIV86P2bEtB7PIwr69o4Cpw';
  static const String BaseUrl = 'youtube.googleapis.com';

  /*
  curl \
  'https://youtube.googleapis.com/youtube/v3/channels?part=snippet&part=contentDetails&id=UCIV86P2bEtB7PIwr69o4Cpw&access_token=AIzaSyBmdki8OtORESM3uta0Ig7qV-DpzoCi774&key=[YOUR_API_KEY]' \
  --header 'Authorization: Bearer [YOUR_ACCESS_TOKEN]' \
  --header 'Accept: application/json' \
  --compressed
   */

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
}