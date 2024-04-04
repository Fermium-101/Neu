import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_money/model/brew.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseService {
  final String uid;
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection("brews");
  final CollectionReference UserInfo =
      FirebaseFirestore.instance.collection("UserInfo");

  DatabaseService({required this.uid});

  Future updateUserData(String sugars, String name, int strength) async {
    try {
      await brewCollection.doc(uid).set({
        'sugars': sugars,
        'name': name,
        'strength': strength,
      });
    } catch (e) {
      print('Error updating user data: $e');
    }
  }

  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      //print(doc.data);
      return Brew(
          name: doc['name'] ?? '',
          strength: doc['strength'] ?? 0,
          sugars: doc['sugars'] ?? '0');
    }).toList();
  }

  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }
}

class Service {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> addUserData(String imageUrl, String firstName, String lastName,
      String climateTag) async {
    try {
      String uid = _auth.currentUser!.uid;
      await _firestore.collection('users').doc(uid).set({
        'image': imageUrl,
        'firstName': firstName,
        'lastName': lastName,
        'climateTag': climateTag,
        'id': '5',
      });
    } catch (e) {
      print("Error adding user data: $e");
    }
  }

  Future<Map<String, dynamic>?> getUserData() async {
    try {
      String uid = _auth.currentUser!.uid;
      DocumentSnapshot snapshot =
          await _firestore.collection('users').doc(uid).get();
      return {
        'image': snapshot['image'],
        'firstName': snapshot['firstName'],
        'lastName': snapshot['lastName'],
        'climateTag': snapshot['climateTag'],
        'id': snapshot['id'],
      };
    } catch (e) {
      print("Error getting user data: $e");
      return null;
    }
  }

  Future<String?> uploadImageAndUserData(String imagePath, String firstName,
      String lastName, String climateTag) async {
    try {
      String? imageUrl = await uploadImageToStorage(imagePath);

      if (imageUrl != null) {
        await addUserData(imageUrl, firstName, lastName, climateTag);
      }

      return imageUrl;
    } catch (e) {
      print("Error uploading image and user data: $e");
      return null;
    }
  }

  Future<String?> uploadImageToStorage(String imagePath) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        String uid = user.uid;
        File imageFile = File(imagePath); // Convert imagePath to File
        Reference ref = _storage.ref().child('user_images').child('$uid.jpg');
        UploadTask uploadTask = ref.putFile(imageFile);
        TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
        return await taskSnapshot.ref.getDownloadURL();
      } else {
        print("User not authenticated");
        return null;
      }
    } catch (e) {
      print("Error uploading image to storage: $e");
      return null;
    }
  }

  Future<void> addSevenDaysData(List<String> data) async {
    try {
      String uid = _auth.currentUser!.uid;
      await _firestore.collection('Sevendaysdata').doc(uid).set({
        'data': data,
      });
    } catch (e) {
      print(
          "Error adding seven kjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjkdays data: $e");
    }
  }

  // Get 7 days data from Firestore
  Future<List<Map<String, dynamic>>?> getSevenDaysData() async {
    try {
      String uid = _auth.currentUser!.uid;
      DocumentSnapshot snapshot =
          await _firestore.collection('Sevendaysdata').doc(uid).get();
      if (snapshot.exists) {
        // If the document exists, return the data
        return [
          {
            'data': List<String>.from(snapshot['data']),
          }
        ];
      } else {
        // If the document doesn't exist, return an empty list
        return [];
      }
    } catch (e) {
      print("Error getting seven days data: $e");
      return null;
    }
  }
}
