
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';


class Addbrands extends StatefulWidget {
  

  const Addbrands({super.key});
  

  @override
  State<Addbrands> createState() => _AddbrandsState();
  
}



class _AddbrandsState extends State<Addbrands> {
  Color dark = Color(0xFF395B64);
  Color light = const Color(0xFFA5C9CA);
  Color extralight = Color(0xFFE7F6F2);
  Color extradark = Color(0xFF2C3333);
  final _formKey = GlobalKey<FormState>();
File? _imageFile;
 String? _imageUrl;
String? namess;
String? url;



Future getImage() async {
    if (_imageFile != null) {
      // Upload image to Firebase Storage
      Reference ref =
          FirebaseStorage.instance.ref().child('images/${DateTime.now().toString()}');
      UploadTask uploadTask = ref.putFile(_imageFile!);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      // Save image URL to Firestore
      FirebaseFirestore.instance.collection('brands').add({'image': downloadUrl,"name":namess,"url":url});

      setState(() {
        _imageUrl = downloadUrl;
      });
    }
}


void _showDialog() {
  showDialog(
    // barrierColor: Colors.orange,
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Add New Brand'),
      content: 
      Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Brand Name'),
              onChanged: (value) {
             namess  =   value;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter Brand Name';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
             TextFormField(
              decoration: InputDecoration(labelText: 'URL'),
              onChanged: (value) {
             url  =   value;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter URL ';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            _imageFile != null
                ? Image.file(_imageFile!, height: 100)
                : SizedBox(height: 0),
            ElevatedButton(
              onPressed: () async {
                final pickedFile = await ImagePicker().getImage(
                  source: ImageSource.gallery,
                  imageQuality: 50,
                );
                if (pickedFile != null) {
                  setState(() {
                    _imageFile = File(pickedFile.path);
                  });
                }
              },
              child: Text('Add Image'),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: ()async {
            if (_formKey.currentState!.validate()) {
          await   getImage();
              Navigator.pop(context);
            }
          },
          child: Text('Save'),
        ),
      ],
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: extralight,
     floatingActionButton: FloatingActionButton(
  onPressed: _showDialog,
  child: Icon(Icons.add),
),

body: Column(children: [


       StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('brands').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                DocumentSnapshot document = snapshot.data!.docs[index];
                String name = document['name'];
                  String url = document['url'] ;
              
          // final ref = snapshot.data!.docs.first[index].id;
                return 
               SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                       border: Border.all(
                        color: light,
                        width: 2,
                      ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Image.network(imageUrl),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                                                      Column(children: [
 Text(name,style: TextStyle(color: dark,fontSize: 30),),
                          SizedBox(height: 20),
                          Text(url ?? "",style: TextStyle(color:dark,fontSize: 25),),
                          ],),
IconButton(
        icon: Icon(Icons.delete,color:dark,),
        onPressed: () {
          final documentReference = FirebaseFirestore.instance.collection('brands').doc(document.id);
          documentReference.delete();
        },
      ),
                          ],),

                         
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),

],),
    );
  }
}