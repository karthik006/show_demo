import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:show_demo/models/show.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ShowApi {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static GoogleSignIn _googleSignIn = new GoogleSignIn();

  FirebaseUser firebaseUser;

  ShowApi(FirebaseUser user) {
    this.firebaseUser = user;
  }

  static Future<ShowApi> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final FirebaseUser user = await _auth.signInWithGoogle(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken
    );
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    return new ShowApi(user);
  }

  // static List<Show> allShowsFromJson(String jsonData) {
  //   List<Show> show = [];
  //   json.decode(jsonData)['Shows'].forEach((show) => show.add(_forMap(show)));
  //   return show;
  // }

  Future<List<Show>> getShows() async {
    return (await Firestore.instance.collection('Shows').getDocuments()).documents.map((snapshot) => _fromSnapshot(snapshot)).toList();
  }

  StreamSubscription watch(Show show, void onChange(Show show)) {
    return Firestore.instance.collection('Shows').document(show.documentID)
      .snapshots.listen((snapshot) => onChange(_fromSnapshot(snapshot)));
  }

  Future likeShow(Show show) async {
    await Firestore.instance.collection('Shows').document('${show.documentID}').getCollection('likes').document('${firebaseUser.uid}').setData({});
    await Firestore.instance.collection('Shows').document('${show.documentID}').updateData({'likeCounter' : show.likeCounter+1});
    //await Firestore.instance.collection('Shows').document('${show.documentID}').updateData({'${firebaseUser.uid}' : '${firebaseUser.uid}'});
  }

  Future unlikeShow(Show show) async {
    await Firestore.instance.collection('Shows').document('${show.documentID}').getCollection('likes').document('${firebaseUser.uid}').delete();
    await Firestore.instance.collection('Shows').document('${show.documentID}').updateData({'likeCounter' : show.likeCounter-1});
    //await Firestore.instance.collection('Shows').document('${show.documentID}').updateData({'${firebaseUser.uid}' : Null});
  }

  Future<bool> likedShow(Show show) async {
    final like = await Firestore.instance.collection('Shows').document('${show.documentID}').getCollection('likes').document('${firebaseUser.uid}').get();
    
    return like.exists;
  }

  Show _fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data;
    return new Show(
      documentID: snapshot.documentID,
      showID: data['id'],
      name: data['name'],
      description: data['description'],
      imageURL: data['imageURL'],
      imdbURL: data['imdbURL'],
      likeCounter: data['likeCounter'],
      genre: data['genre'],
      episodes: data['episodes'],
    );
  }

  // static Show _forMap(Map<String, dynamic> map) {
  //   return new Show(
  //     documentID: map['documentID'],
  //     showID: map['id'],
  //     name: map['name'],
  //     description: map['description'],
  //     imageURL: map['imageURL'],
  //     imdbURL: map['imdbURL'],
  //     likeCounter: map['likeCounter'],
  //     genre: map['genre'],
  //     episodes: map['episodes'],
  //   );
  // }

}