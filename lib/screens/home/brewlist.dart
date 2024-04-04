import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_money/model/brew.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  const BrewList({super.key});

  @override
  State<BrewList> createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  final userId = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    //  final brews=Provider.of<QuerySnapshot>(context);
    // for(var dat in brews.docs){
    //   print('print below form list ');
    //   print(dat.id);
    //   print('sugars bro?: ${ dat['name']}');
    //   print('name: ${dat['strength']}');
    // }
     final brews = Provider.of<List<Brew>>(context);
    brews.forEach((brew) {
      print(brew.name);
      print(brew.sugars);
      print(userId);
    });
    return  Container();
  }
}