import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:scrapingdart/AuthFirebase/auth.dart';
import 'package:scrapingdart/screens/editScreen.dart';

class UserProfile extends StatelessWidget {
  Color dark = Color(0xFF395B64);
  Color light = const Color(0xFFA5C9CA);
  Color extralight = Color(0xFFE7F6F2);
  Color extradark = Color(0xFF2C3333);
  @override
  Widget build(BuildContext context) {
    AuthService authService = Get.put(AuthService());
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
        backgroundColor: extralight,
        appBar: AppBar(
          title: Text('Profile'),
          backgroundColor: light,
        ),
        body:
            // StreamBuilder<QuerySnapshot>(
            //   stream: FirebaseFirestore.instance
            //       .collection('users')

            //       .snapshots(),
            //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            //     if (snapshot.hasError) {
            //       return Text('Error: ${snapshot.error}');
            //     }

            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return CircularProgressIndicator();
            //     }

            //     return
            //      ListView.builder(
            //       itemCount: snapshot.data!.docs.length,
            //       itemBuilder: (BuildContext context, int index) {
            //         DocumentSnapshot document = snapshot.data!.docs[index];
            //         String id = document.id;
            //         String name = document["name"];
            //         String description = document['email'];

            // return

            Container(
          color: light,
          child: ListTile(
            title: Text(
              "Email :" + authService.emailsss,
              style: TextStyle(color: extradark),
            ),
            subtitle: Text(
              "Name:" + authService.namess,
              style: TextStyle(color: extradark),
            ),
            trailing: IconButton(
                onPressed: () async {
                  Get.to(EditScreen());
                },
                icon: Icon(
                  Icons.edit,
                  color: dark,
                )),
          ),
        )
        //       },
        //     );
        //   },
        // ),
        );
  }
}
