import 'dart:io';

import 'package:new_money/services/auth.dart';
import 'package:new_money/services/database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   final AuthService _auth = AuthService();
//   final Service _databaseService = Service();
//   File? _image;
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   String error = '';
//   String check =
//       'https://media.macphun.com/img/uploads/customer/how-to/608/15542038745ca344e267fb80.28757312.jpg?q=85&w=1340';

//   @override
//   Widget build(BuildContext context) {
//     var imageUrl = '';
//     print(check);
//     final user = Provider.of<User?>(context);
//     return StreamProvider<List<Brew>?>.value(
//       value: DatabaseService(uid: '').brews,
//       initialData: null,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Hello from the main screen'),
//         ),
//         body: SingleChildScrollView(
//           child: Center(
//             child: Container(
//               child: Column(
//                 children: [
//                   BrewList(),
//                   Text('data'),
                  // ElevatedButton.icon(
                  //   onPressed: () async {
                  //     await _auth.signOut();
                  //   },
                  //   icon: Icon(Icons.person),
                  //   label: Text('Logout Fahim'),
                  // ),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       // _image == null
//                       //     ? Text('No image selected.')
//                       //     : Image.file(_image!),
//                       ElevatedButton(
//                         onPressed: () async {
//                           _image = await _pickImage();
//                           setState(() {});
//                         },
//                         child: Text('Pick Image'),
//                       ),
//                       ElevatedButton(
//                         onPressed: () async {
//                           if (_image != null) {
//                             String? imageUrl =
//                                 await _databaseService.uploadImageToStorage(_image!.path);
//                             if (imageUrl != null) {
//                               await _databaseService.addUserImage(imageUrl);
//                               print('Image uploaded and saved successfully!');
//                             }
//                           }
//                         },
//                         child: Text('Upload Image'),
//                       ),
//                       ElevatedButton(
//                         onPressed: () async {
//                           String? imageUrl =
//                               await _databaseService.getUserImage();
//                           if (imageUrl != null) {
//                             print('User image URL: $imageUrl');
//                             print(check);
//                             setState(() {
//                               check = imageUrl;
//                             });
//                           } else {
//                             print('No image found for the user.');
//                           }
//                         },
//                         child: Text('Show User Image'),
//                       ),
//                       Image.network(
//                         check ?? 'https://example.com/default_image.png', // use a default image if check is null
//                         // height: 250,
//                         // width: 250,
//                         fit: BoxFit.cover,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Future<File?> _pickImage() async {
//     final ImagePicker _picker = ImagePicker();
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       return File(image.path);
//     }
//     return null;
//   }
// }
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  final Service _databaseService = Service();
  File? _image;
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final climateTagController = TextEditingController();
  String error = '';
  String imageUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello from the main screen'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                                  ElevatedButton.icon(
                    onPressed: () async {
                      await _auth.signOut();
                      Navigator.pushNamed(context, '/');
                    },
                    icon: Icon(Icons.person),
                    label: Text('Logout Fahim'),
                  ),
                TextFormField(
                  controller: firstNameController,
                  decoration: InputDecoration(labelText: 'First Name'),
                ),
                TextFormField(
                  controller: lastNameController,
                  decoration: InputDecoration(labelText: 'Last Name'),
                ),
                TextFormField(
                  controller: climateTagController,
                  decoration: InputDecoration(labelText: 'Climate Tag'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    _image = await _pickImage();
                    setState(() {});
                  },
                  child: Text('Pick Image'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_image != null) {
                      imageUrl = (await _databaseService.uploadImageAndUserData(
                        _image!.path,
                        firstNameController.text,
                        lastNameController.text,
                        climateTagController.text,
                      ))!;
                      if (imageUrl != null) {
                        print('Image uploaded and user data saved successfully!');
                      }
                    }
                  },
                  child: Text('Upload Image and Data'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    Map<String, dynamic>? userData =
                        await _databaseService.getUserData();
                    if (userData != null) {
                      setState(() {
                        imageUrl = userData['image'];
                        firstNameController.text = userData['firstName'];
                        lastNameController.text = userData['lastName'];
                        climateTagController.text = userData['climateTag'];
                      });
                    }
                  },
                  child: Text('Retrieve User Data'),
                ),
                Image.network(
                  imageUrl.isNotEmpty
                      ? imageUrl
                      : 'https://media.macphun.com/img/uploads/customer/how-to/608/15542038745ca344e267fb80.28757312.jpg?q=85&w=1340',
                  fit: BoxFit.cover,
                  height: 250,
                  width: 250,
                ),
              ],
            ),
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
