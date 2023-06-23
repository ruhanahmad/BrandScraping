import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:scrapingdart/AuthFirebase/auth.dart';
import 'package:scrapingdart/breakout.dart';
import 'package:scrapingdart/screens/alkaram.dart';
import 'package:scrapingdart/screens/breakOutMap.dart';
import 'package:scrapingdart/screens/filter.dart';
import 'package:scrapingdart/screens/gulahmad.dart';
import 'package:scrapingdart/screens/khaadi.dart';
import 'package:scrapingdart/screens/limelight.dart';

import 'package:scrapingdart/screens/mapGoogle.dart';
import 'package:scrapingdart/screens/mariab.dart';
import 'package:scrapingdart/screens/outfitters.dart';
import 'package:scrapingdart/screens/sanasafinaz.dart';
import 'package:scrapingdart/screens/sapphire.dart';
import 'package:url_launcher/url_launcher.dart';


class FirebaseGridView extends StatefulWidget {
  @override
  _FirebaseGridViewState createState() => _FirebaseGridViewState();
}

class _FirebaseGridViewState extends State<FirebaseGridView> {
    Color dark = Color(0xFF395B64);
  Color light = const Color(0xFFA5C9CA);
  Color extralight = Color(0xFFE7F6F2);
  Color extradark = Color(0xFF2C3333);
  late Stream<QuerySnapshot> _stream;

  @override
  void initState() {
    super.initState();
    _stream = FirebaseFirestore.instance.collection('brands').snapshots();
  }

  List assetImagess = [
    "assets/images/limelight.jpg",
    "assets/images/sanasafinaz.jpg",
    "assets/images/khaadi.jpg",
    "assets/images/breakout.jpg",
    "assets/images/saya.jpg",
    "assets/images/bonanza.jpg",
    "assets/images/j.jpg",
    "assets/images/outfitters.jpg",
    "assets/images/mariab.jpg",
    "assets/images/sapphire.jpg",
    "assets/images/limelight.jpg",
    "assets/images/alkaram.jpg",
    "assets/images/nishat.jpg"
   ];

  @override
  Widget build(BuildContext context) {
    AuthService authService = Get.put(AuthService());
    return Scaffold(
      backgroundColor: extralight,
      appBar: AppBar(
        backgroundColor: light,
         automaticallyImplyLeading: false,
        title: Text('Brands'),
  //       actions: [
  //         ElevatedButton(
  //     onPressed: () {
  //       authService.signOut();
  //       Navigator.pop(context);
  //     },
  //     child: const Text('Logout'),
  //   ),
  //             ElevatedButton(
  //     onPressed: () {
  //       // authService.signOut();
  //       Get.to (MapViewGoogle ());
  //       // Navigator.pop(context);
  //     },
  //     child: const Text('MapView'),
  //   ),
   
  //       ElevatedButton(
  //     onPressed: ()async {
  //       // authService.signOut();
  //    Get.to ( Filters   ());
  // //  await  scrapeData();
  //       // Navigator.pop(context);
  //     },
  //     child: const Text('Checking'),
  //   ),
  //       ],
      ),
      body: 
      
      StreamBuilder<QuerySnapshot>(
        stream: _stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
            
          }
           if (snapshot.hasError){
                  print(snapshot.hasError);
             } 

          return GridView.builder(
            itemCount: snapshot.data!.docs.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              var data = snapshot.data!.docs[index].data() as Map<String, dynamic>;
 int randomNumber = Random().nextInt(41) + 10;
              return GestureDetector(
                onTap: () {
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
 color: light,
 borderRadius: BorderRadius.circular(30)

                    ),
                   
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Align(
                        //   alignment: Alignment.topLeft,
                        //   child: Container(
                        //     height: 35,
                        //     width: 35,
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(40),
                        //       color: Colors.red,
                        //     ),
                          
                        //     child: Center(child: Text("50%",style: TextStyle(color: Colors.white),))),
                        // ),
                        Container(height: 100,width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                            image: 
                            DecorationImage(
                              image: 
                              
                            NetworkImage(data["image"],),fit: BoxFit.contain,
                            )    
                              
                        ),
                        
                        ),
                
                        Text(
                          data['name'],
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                           style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(dark),
  ),
                          
                          onPressed: () {

                            //  Get.to(BreakOutMap(name:data["name"]));
                           Get.to(CardProductWrapperList(name:data["name"]));
                          },
                          child: Text('Discounts'),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
