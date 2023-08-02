import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/youtube/v3.dart' as YT;
import 'package:mytube/utils/firebase_util.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';

import '../models/firebase_model.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    YT.YouTubeApi.youtubeUploadScope,
    YT.YouTubeApi.youtubeReadonlyScope,
  ],
);

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  YoutubePlayerController? controller;
  GoogleSignInAccount? _currentUser;
  late Future<YT.Video> videoInsertRequest; // to track the request
  List<Widget> widgetList = []; // list of youtube players
  List<String> id = [
  ]; //
  bool isComplete= false;
  // access the videos form the user
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
      print("sdsd:$_currentUser");
    });
    _googleSignIn.signInSilently();
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print('error is %% : ${error}');
    }
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();


  Future<void> _handleVideoInsert()async{

    var httpClient = (await _googleSignIn.authenticatedClient())!;
    var youTubeApi = YT.YouTubeApi(httpClient);


    YT.Video video1 =  YT.Video.fromJson({
      'snippet':{
        'title':'Uploaded MyVideo new',
        'description':'snippet',
        'categoryId':'22',
        "tags": [
          'snippet'
        ],
      },
      'status':{
        'privacyStatus':'public',
        'madeForKids':false,
        "selfDeclaredMadeForKids": false
      },
    }
    );


    var status = await Permission.storage.status;
    if(status.isGranted){
      await Permission.storage.request();
    }

    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if(result ==null)return;
    Stream<List<int>> stream= new File(result.files.single.path.toString()).openRead();
    int length = await File(result.files.single.path.toString()).length();
    YT.Media media = YT.Media(stream,length);


    videoInsertRequest = youTubeApi.videos.insert(
      video1,
      ['snippet','status'],uploadMedia: media,
    );
    videoInsertRequest.then((value){
      VideosIds videosIds = VideosIds(videoId: value.id.toString());
      addToFireStore(videosIds);
      print('added to firebase');
    });
    videoInsertRequest.whenComplete((){
      print('complete');
      isComplete = true;
      setState(() {

      });
    });
    videoInsertRequest.onError((error, stackTrace) {
      return new YT.Video();
    });
  }


  Widget _buildBody() {
    GoogleSignInAccount? user = _currentUser;
    if (user != null)
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          ...widgetList,
          ElevatedButton(
            onPressed: () {
              _handleVideoInsert();
            },
            child: Text('Upload'),
          ),
          SizedBox(height: 30,),
          if(isComplete)
            Text('video uploaded success',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
          SizedBox(height: 5,),
          if(isComplete)
          Icon(Icons.check_box,color: Colors.green,size: 30),
        ],
      );
    else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('you are currently not signin'),
          ElevatedButton(
            onPressed: _handleSignIn,
            child: Text('SIGN IN'),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
            onPressed: _handleSignOut,
            child: Text('SIGN OUT'),
          ),
        ],
      ),
      body: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: _buildBody(),
      ),
    );
  }
}
