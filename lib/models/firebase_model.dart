class VideosIds {
  String id;
  String videoId;

  VideosIds({this.id = '', required this.videoId});

  Map<String, dynamic> toJason() {
    return {'id': id, 'videoId': videoId};
  }

  VideosIds.fromJason(Map<String, dynamic> json)
      : this(id: json['id'],
      videoId: json['videoId']
  );
}
