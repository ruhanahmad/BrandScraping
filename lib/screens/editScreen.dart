import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../AuthFirebase/auth.dart';


class EditScreen extends StatefulWidget {

  String? email;
  String?  name;

EditScreen({this.email,this.name});

  @override
  State<EditScreen> createState() => _EditScreenState();
}
String oldPassword="";
String newPassword = "";
AuthService authService = Get.put(AuthService());
File? _imageFile;
 String? _imageUrl;
String? namess;
String? url;
String? downloadUrl;

class _EditScreenState extends State<EditScreen> {
  Color dark = Color(0xFF395B64);
  Color light = const Color(0xFFA5C9CA);
  Color extralight = Color(0xFFE7F6F2);
  Color extradark = Color(0xFF2C3333);
  Future getImage() async {
    await authService.getIDo();
    if (_imageFile != null) {
      // Upload image to Firebase Storage
      Reference ref =
          FirebaseStorage.instance.ref().child('Profileimages/${DateTime.now().toString()}');
      UploadTask uploadTask = ref.putFile(_imageFile!);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
       downloadUrl = await taskSnapshot.ref.getDownloadURL();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(authService.userId!.uid)
        .update({'profilePictureUrl': downloadUrl});
      // Save image URL to Firestore
     

      setState(() {
        _imageUrl = downloadUrl;
      });
    }
}
  bool obscureText = true;
  bool obscureTextTwo = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:extralight,
      body:  Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: MediaQuery.of(context).size.height/1.2,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage(_imageUrl ??""),
        ),
              //  Image.network(),
                  // : SizedBox(height: 0),
              //      ProfilePicture(
              //   imageUrl: FirebaseAuth.currentUser!.photoURL,
              // ),
              SizedBox(height: 10),
              // Upload button.
                ElevatedButton(
                   style: ElevatedButton.styleFrom(
        primary: dark,
        onPrimary: Colors.white,
        minimumSize: Size(150, 40),
        shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),),
      ),
                onPressed: () async {
                  final pickedFile = await ImagePicker().getImage(
                    source: ImageSource.gallery,
                    imageQuality: 50,
                  );
                  if (pickedFile != null) {
                    setState(() {
                      _imageFile = File(pickedFile.path);
                    });
                    await   getImage();
                // Navigator.pop(context);
                  }
                },
                child: Text('Add Image'),
              ),
          //      ElevatedButton(
          //   onPressed: ()async {
            
          //   await   getImage();
          //       Navigator.pop(context);
            
          //   },
          //   child: Text('upload'),
          // ),
        
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Container(
                           decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color:       light,
                            ),
                      child: TextFormField(
                      decoration: InputDecoration(
                         prefixIcon: Icon(Icons.verified_user),
                        hintText: authService.namess,
                      ),
                      onChanged: (value) {
                        oldPassword = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your old password';
                        }
                        return null;
                      },
                                  ),
                    ),
                  ),
                  SizedBox(height: 5,),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Container(
                      decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color:  light,
                          ),
                    child: TextFormField(
                       obscureText: obscureText,
                      decoration: InputDecoration(
                        hintText: 'Old Password',
                         prefixIcon: Icon(Icons.lock),
                         suffixIcon: IconButton(
                  icon: Icon(Icons.visibility),
                   onPressed: () {
                    // Toggle the password visibility
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                          
                         )),
                      onChanged: (value) {
                        oldPassword = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your old password';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                 SizedBox(height: 5,),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Container(
                      decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color:  light,
                          ),
                    child: TextFormField(
                      obscureText: obscureTextTwo,
                      decoration: InputDecoration(
                        hintText: 'New Password',
                         prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                  icon: Icon(Icons.visibility),
                  onPressed: () {
                    // Toggle the password visibility
                    setState(() {
                      obscureTextTwo = !obscureTextTwo;
                    });
                  },
                              ),
                         
                      ),
                      onChanged: (value) {
                        newPassword = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your new password';
                        }
                        if (value!.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                ElevatedButton(
                   style: ElevatedButton.styleFrom(
        primary: dark,
        onPrimary: Colors.white,
        minimumSize: Size(150, 40),
        shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),),
      ),
                  child: Text('Submit'),
                  onPressed: ()async {
                    if (oldPassword.isNotEmpty && newPassword.isNotEmpty) {
                     await     authService.changePassword(authService.emailsss,oldPassword,newPassword);
                     Get.snackbar("Change", "Password Changed");
                    } else {
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(content: Text('Please enter both passwords')),
                      // );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),);
  }
  
}



class ProfilePicture extends StatelessWidget {
  final String imageUrl;

  const ProfilePicture({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}




