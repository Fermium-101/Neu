import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_money/components/my_text_field.dart';
import 'package:new_money/services/auth.dart';
import 'package:new_money/services/database.dart';
import 'package:new_money/shared/loading.dart';

class CreateProfile extends StatefulWidget {
  const CreateProfile({super.key});

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  File? _image;
  final AuthService _auth = AuthService();
  final Service _databaseService = Service();
  late final String imageUrl;
   final firstcontroller = TextEditingController();
    final lastcontroller = TextEditingController();
    final tagcontroller = TextEditingController();
  var load=false;

  Future getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double figmaScreenWidth = 428.0;
    double figmaScreenHeight = 926.0;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double ws = screenWidth / figmaScreenWidth;
    double hs = screenHeight / figmaScreenHeight;
   
    print('Scaled Screen Width: $screenWidth * $ws');
    print('Scaled Screen Height: $screenHeight * $hs');
    return load?Loading() :Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 90 * hs,
                  ),
                  Stack(
                    children: [
                      CircleAvatar(
                        backgroundImage: _image != null
                            ? FileImage(_image!)
                            : AssetImage('assets/sheep.png') as ImageProvider,
                        radius: 90.0 * ((ws + hs) / 2),
                        backgroundColor: Color.fromARGB(100, 196, 196, 196),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: FloatingActionButton(
                          backgroundColor: Color.fromARGB(255, 0, 244, 57),
                          onPressed: () {
                            getImage(); 
                          },
                          mini: true,
                          child: Icon(
                            Icons.edit,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40.0 * hs),
                  Text('Create your profile',
                      style: TextStyle(
                        color: Color(0xFF2E2E2E),
                        fontWeight:
                            FontWeight.bold, // FontWeight.bold is also valid
                        fontSize: 32 * ((ws + hs) / 2),
                      )),
                  SizedBox(
                    height: 30 * hs,
                  ),
                  Container(
                    height: 51 * hs,
                    width: 330 * ws,
                    child: TextFormField(
                      controller: firstcontroller,
                      decoration: InputDecoration(
                        labelText: 'First Name',
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0 * hs),
                  Container(
                    height: 51 * hs,
                    width: 330 * ws,
                    child: TextFormField(
                      controller: lastcontroller,
                      decoration: InputDecoration(
                        labelText: 'Last Name',
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0 * hs),
                  Container(
                    height: 51 * hs,
                    width: 330 * ws,
                    child: TextFormField(
                      controller: tagcontroller,
                      decoration: InputDecoration(
                        labelText: 'Climate Tag',
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                    ),
                  ),
                  SizedBox(height: 60.0 * hs),
                  CustomButtonlink(
                    buttonText: 'Next',
                    onTapCallback: () async {
                      setState(() {
                        load=true;
                      });
                      if (_image != null) {
                        imageUrl =
                            (await _databaseService.uploadImageAndUserData(
                          _image!.path,
                          firstcontroller.text,
                          lastcontroller.text,
                          tagcontroller.text,
                        ))!;
                        if (imageUrl != '') {
                          print(
                              'Image uploaded and user data saved successfully!');

                              Navigator.pushNamed(context, '/welcome');
                        } else {
                          print('something wrong');
                          setState(() {
                            load=false;
                          });
                        }
                      }else{
                        setState(() {
                          load=false;
                          print('try again with valid image');
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
