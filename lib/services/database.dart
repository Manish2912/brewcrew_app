import 'package:brewcrew/models/brew.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
//collection reference

  final String uid;
  DatabaseService({this.uid});
  // here we r creating constructor so that we can pass uid
  // purpose of Uid is that we r linking firebase user with firebase store
  //whenever we create database and will pass the Uid to uniquely identify our user

  final CollectionReference brewCollection =
      Firestore.instance.collection('brews');
  // we have collection where we store values

  // we will use this functon whenever user signin so going to signin page for using
  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.document(uid).setData({
      'sugars': sugars,
      'name': name,
      'strength ': strength,
    });
  }

// now we wil work again with streams
// the work of streams will be top provide the current snapshot of the document
// like for example a new user enter so we will take snapshot of the document at that veery moment
// and we willl send through stream and we will use that according to our use.
// so take stream as a photo of document which will given to us and we can use that data.

  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    // here we going through the document and mapping the document into list
    //and then creating class objects by passin parameters value of class
    return snapshot.documents.map((doc) {
      return Brew(
          name: doc.data['name'] ?? '', // here we parse each index by doc.data
          // then return the value of parameters by doc.data['parameter]
// ?? if value is not present then pass blank string
          strength: doc.data['strength'] ?? 0,
          sugars: doc.data['sugars'] ?? '');
    }).toList(); // converting values in the list
  }

  // we have replaced <QuerySnapshot> into list<brew> becoz iterable is of type of list 
  Stream <List<Brew>> get brews {
    return brewCollection.snapshots().map(
        _brewListFromSnapshot); // converting the snapshots obtained into our own iterable object
  }
}
