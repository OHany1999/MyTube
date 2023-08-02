import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mytube/models/firebase_model.dart';



CollectionReference<VideosIds> getMyCollection() {
  return
    FirebaseFirestore.instance.collection('videoIds').withConverter<VideosIds>(
      fromFirestore: (snapshot, options) =>
          VideosIds.fromJason(snapshot.data()!),
      toFirestore: (videoId, options) => videoId.toJason(),
    );
}


Future<void> addToFireStore(VideosIds videosIds) {
  var collection = getMyCollection();
  var docRef = collection.doc();
  videosIds.id = docRef.id;
  return docRef.set(videosIds);
}

Stream<QuerySnapshot<VideosIds>> getDataFromFireStore() {
  var data = getMyCollection().get().asStream();
  return data;
}