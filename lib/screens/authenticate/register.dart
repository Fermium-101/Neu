import 'dart:io';

import 'package:new_money/services/auth.dart';
import 'package:new_money/services/database.dart';
import 'package:new_money/shared/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final Service _databaseService = Service();
  File? _image;

  final AuthService _auth = AuthService();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String error = '';
  bool load = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return load
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: const Text('Register '),
            ),
            body: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 20.0),
                    TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an email';
                        } else if (!value.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      obscureText: true,
                      controller:
                          passwordController, // supply the password controller
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        } else if (value.length < 6) {
                          return 'Please enter a password with at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      // style: ElevatedButton.styleFrom(color: Colors.pink[400]),
                      child: const Text(
                        'Register',
                        style: TextStyle(color: Color.fromARGB(255, 17, 7, 7)),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            load = true;
                          });
                          dynamic result =
                              await _auth.registerWithEmailAndPassword(
                                  emailController.text,
                                  passwordController.text);
                          if (result == null) {
                            setState(() {
                              error = 'please supply a vali email';
                            });
                          } else {
                            print(result);
                            setState(() {
                              load = false;
                            });
                            //Navigator.pushNamed(context, '/');
                          }
                        }
                      },
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/');
                        },
                        child: Text('Already have an account? Log in')),
                    //        Column(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: <Widget>[
                    //     _image == null
                    //         ? Text('No image selected.')
                    //         : Image.file(_image!),
                    //     ElevatedButton(
                    //       onPressed: () async {
                    //         _image = await _pickImage();
                    //         setState(() {});
                    //       },
                    //       child: Text('Pick Image'),
                    //     ),
                    //     ElevatedButton(
                    //       onPressed: () async {
                    //         if (_image != null) {
                    //           String? imageUrl =
                    //               await _databaseService.uploadImageToStorage(_image!.path);
                    //           if (imageUrl != null) {
                    //             await _databaseService.addUserImage(imageUrl);
                    //             print('Image uploaded and saved successfully!');
                    //           }
                    //         }
                    //       },
                    //       child: Text('Upload Image'),
                    //     ),
                    //     ElevatedButton(
                    //       onPressed: () async {
                    //         String? imageUrl = await _databaseService.getUserImage();
                    //         if (imageUrl != null) {
                    //           // Display the user's image
                    //           // You can use Image.network(imageUrl) or any other method
                    //           print('User image URL: $imageUrl');
                    //         } else {
                    //           print('No image found for the user.');
                    //         }
                    //       },
                    //       child: Text('Show User Image'),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
          );
  }

  Future<File?> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      return File(image.path);
    }
    return null;
  }
}
