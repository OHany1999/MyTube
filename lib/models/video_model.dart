// // To parse this JSON data, do
// //
// //     final videosModel = videosModelFromJson(jsonString);
//
// import 'dart:convert';
//
// VideosModel videosModelFromJson(String str) => VideosModel.fromJson(json.decode(str));
//
// String videosModelToJson(VideosModel data) => json.encode(data.toJson());
//
// class VideosModel {
//   String kind;
//   String etag;
//   List<VideoItem> videos;
//   PageInfo pageInfo;
//
//   VideosModel({
//     required this.kind,
//     required this.etag,
//     required this.videos,
//     required this.pageInfo,
//   });
//
//   factory VideosModel.fromJson(Map<String, dynamic> json) => VideosModel(
//     kind: json["kind"],
//     etag: json["etag"],
//     videos: List<VideoItem>.from(json["items"].map((x) => VideoItem.fromJson(x))),
//     pageInfo: PageInfo.fromJson(json["pageInfo"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "kind": kind,
//     "etag": etag,
//     "items": List<dynamic>.from(videos.map((x) => x.toJson())),
//     "pageInfo": pageInfo.toJson(),
//   };
// }
//
// class VideoItem {
//   String kind;
//   String etag;
//   String id;
//   Video snippet;
//
//   VideoItem({
//     required this.kind,
//     required this.etag,
//     required this.id,
//     required this.snippet,
//   });
//
//   factory VideoItem.fromJson(Map<String, dynamic> json) => VideoItem(
//     kind: json["kind"],
//     etag: json["etag"],
//     id: json["id"],
//     snippet: Video.fromJson(json["snippet"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "kind": kind,
//     "etag": etag,
//     "id": id,
//     "snippet": snippet.toJson(),
//   };
// }
//
// class Video {
//   DateTime publishedAt;
//   String channelId;
//   String title;
//   String description;
//   Thumbnails thumbnails;
//   String channelTitle;
//   String playlistId;
//   int position;
//   ResourceId resourceId;
//   String videoOwnerChannelTitle;
//   String videoOwnerChannelId;
//
//   Video({
//     required this.publishedAt,
//     required this.channelId,
//     required this.title,
//     required this.description,
//     required this.thumbnails,
//     required this.channelTitle,
//     required this.playlistId,
//     required this.position,
//     required this.resourceId,
//     required this.videoOwnerChannelTitle,
//     required this.videoOwnerChannelId,
//   });
//
//   factory Video.fromJson(Map<String, dynamic> json) => Video(
//     publishedAt: DateTime.parse(json["publishedAt"]),
//     channelId: json["channelId"],
//     title: json["title"],
//     description: json["description"],
//     thumbnails: Thumbnails.fromJson(json["thumbnails"]),
//     channelTitle: json["channelTitle"],
//     playlistId: json["playlistId"],
//     position: json["position"],
//     resourceId: ResourceId.fromJson(json["resourceId"]),
//     videoOwnerChannelTitle: json["videoOwnerChannelTitle"],
//     videoOwnerChannelId: json["videoOwnerChannelId"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "publishedAt": publishedAt.toIso8601String(),
//     "channelId": channelId,
//     "title": title,
//     "description": description,
//     "thumbnails": thumbnails.toJson(),
//     "channelTitle": channelTitle,
//     "playlistId": playlistId,
//     "position": position,
//     "resourceId": resourceId.toJson(),
//     "videoOwnerChannelTitle": videoOwnerChannelTitle,
//     "videoOwnerChannelId": videoOwnerChannelId,
//   };
// }
//
// class ResourceId {
//   String kind;
//   String videoId;
//
//   ResourceId({
//     required this.kind,
//     required this.videoId,
//   });
//
//   factory ResourceId.fromJson(Map<String, dynamic> json) => ResourceId(
//     kind: json["kind"],
//     videoId: json["videoId"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "kind": kind,
//     "videoId": videoId,
//   };
// }
//
// class Thumbnails {
//   Default thumbnailsDefault;
//   Default medium;
//   Default high;
//   Default? standard;
//   Default? maxres;
//
//   Thumbnails({
//     required this.thumbnailsDefault,
//     required this.medium,
//     required this.high,
//     this.standard,
//     this.maxres,
//   });
//
//   factory Thumbnails.fromJson(Map<String, dynamic> json) => Thumbnails(
//     thumbnailsDefault: Default.fromJson(json["default"]),
//     medium: Default.fromJson(json["medium"]),
//     high: Default.fromJson(json["high"]),
//     standard: json["standard"] == null ? null : Default.fromJson(json["standard"]),
//     maxres: json["maxres"] == null ? null : Default.fromJson(json["maxres"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "default": thumbnailsDefault.toJson(),
//     "medium": medium.toJson(),
//     "high": high.toJson(),
//     "standard": standard?.toJson(),
//     "maxres": maxres?.toJson(),
//   };
// }
//
// class Default {
//   String url;
//   int width;
//   int height;
//
//   Default({
//     required this.url,
//     required this.width,
//     required this.height,
//   });
//
//   factory Default.fromJson(Map<String, dynamic> json) => Default(
//     url: json["url"],
//     width: json["width"],
//     height: json["height"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "url": url,
//     "width": width,
//     "height": height,
//   };
// }
//
// class PageInfo {
//   int totalResults;
//   int resultsPerPage;
//
//   PageInfo({
//     required this.totalResults,
//     required this.resultsPerPage,
//   });
//
//   factory PageInfo.fromJson(Map<String, dynamic> json) => PageInfo(
//     totalResults: json["totalResults"],
//     resultsPerPage: json["resultsPerPage"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "totalResults": totalResults,
//     "resultsPerPage": resultsPerPage,
//   };
// }


// To parse this JSON data, do
//
//     final videosModel = videosModelFromJson(jsonString);

import 'dart:convert';

VideosModel videosModelFromJson(String str) => VideosModel.fromJson(json.decode(str));

String videosModelToJson(VideosModel data) => json.encode(data.toJson());

class VideosModel {
  String kind;
  String etag;
  List<Item> items;
  PageInfo pageInfo;

  VideosModel({
    required this.kind,
    required this.etag,
    required this.items,
    required this.pageInfo,
  });

  factory VideosModel.fromJson(Map<String, dynamic> json) => VideosModel(
    kind: json["kind"],
    etag: json["etag"],
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    pageInfo: PageInfo.fromJson(json["pageInfo"]),
  );

  Map<String, dynamic> toJson() => {
    "kind": kind,
    "etag": etag,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "pageInfo": pageInfo.toJson(),
  };
}

class Item {
  String kind;
  String etag;
  String id;
  Snippet snippet;

  Item({
    required this.kind,
    required this.etag,
    required this.id,
    required this.snippet,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    kind: json["kind"],
    etag: json["etag"],
    id: json["id"],
    snippet: Snippet.fromJson(json["snippet"]),
  );

  Map<String, dynamic> toJson() => {
    "kind": kind,
    "etag": etag,
    "id": id,
    "snippet": snippet.toJson(),
  };
}

class Snippet {
  DateTime publishedAt;
  String channelId;
  String title;
  String description;
  Thumbnails thumbnails;
  String channelTitle;
  List<String> tags;
  String categoryId;
  String liveBroadcastContent;
  Localized localized;
  String? defaultAudioLanguage;

  Snippet({
    required this.publishedAt,
    required this.channelId,
    required this.title,
    required this.description,
    required this.thumbnails,
    required this.channelTitle,
    required this.tags,
    required this.categoryId,
    required this.liveBroadcastContent,
    required this.localized,
    this.defaultAudioLanguage,
  });

  factory Snippet.fromJson(Map<String, dynamic> json) => Snippet(
    publishedAt: DateTime.parse(json["publishedAt"]),
    channelId: json["channelId"],
    title: json["title"],
    description: json["description"],
    thumbnails: Thumbnails.fromJson(json["thumbnails"]),
    channelTitle: json["channelTitle"],
    tags: List<String>.from(json["tags"].map((x) => x)),
    categoryId: json["categoryId"],
    liveBroadcastContent: json["liveBroadcastContent"],
    localized: Localized.fromJson(json["localized"]),
    defaultAudioLanguage: json["defaultAudioLanguage"],
  );

  Map<String, dynamic> toJson() => {
    "publishedAt": publishedAt.toIso8601String(),
    "channelId": channelId,
    "title": title,
    "description": description,
    "thumbnails": thumbnails.toJson(),
    "channelTitle": channelTitle,
    "tags": List<dynamic>.from(tags.map((x) => x)),
    "categoryId": categoryId,
    "liveBroadcastContent": liveBroadcastContent,
    "localized": localized.toJson(),
    "defaultAudioLanguage": defaultAudioLanguage,
  };
}

class Localized {
  String title;
  String description;

  Localized({
    required this.title,
    required this.description,
  });

  factory Localized.fromJson(Map<String, dynamic> json) => Localized(
    title: json["title"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
  };
}

class Thumbnails {
  Default thumbnailsDefault;
  Default medium;
  Default high;
  Default standard;
  Default maxres;

  Thumbnails({
    required this.thumbnailsDefault,
    required this.medium,
    required this.high,
    required this.standard,
    required this.maxres,
  });

  factory Thumbnails.fromJson(Map<String, dynamic> json) => Thumbnails(
    thumbnailsDefault: Default.fromJson(json["default"]),
    medium: Default.fromJson(json["medium"]),
    high: Default.fromJson(json["high"]),
    standard: Default.fromJson(json["standard"]),
    maxres: Default.fromJson(json["maxres"]),
  );

  Map<String, dynamic> toJson() => {
    "default": thumbnailsDefault.toJson(),
    "medium": medium.toJson(),
    "high": high.toJson(),
    "standard": standard.toJson(),
    "maxres": maxres.toJson(),
  };
}

class Default {
  String url;
  int width;
  int height;

  Default({
    required this.url,
    required this.width,
    required this.height,
  });

  factory Default.fromJson(Map<String, dynamic> json) => Default(
    url: json["url"],
    width: json["width"],
    height: json["height"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "width": width,
    "height": height,
  };
}

class PageInfo {
  int totalResults;
  int resultsPerPage;

  PageInfo({
    required this.totalResults,
    required this.resultsPerPage,
  });

  factory PageInfo.fromJson(Map<String, dynamic> json) => PageInfo(
    totalResults: json["totalResults"],
    resultsPerPage: json["resultsPerPage"],
  );

  Map<String, dynamic> toJson() => {
    "totalResults": totalResults,
    "resultsPerPage": resultsPerPage,
  };
}
