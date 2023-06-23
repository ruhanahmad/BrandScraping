import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RecordListPage extends StatelessWidget {
  Color dark = Color(0xFF395B64);
  Color light = const Color(0xFFA5C9CA);
  Color extralight = Color(0xFFE7F6F2);
  Color extradark = Color(0xFF2C3333);
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Records'),
        backgroundColor:light,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
          
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              DocumentSnapshot document = snapshot.data!.docs[index];
              String id = document.id;
              String name = document["name"];
              String description = document['email'];

              return Dismissible(
                key: Key(id),
                onDismissed: (direction) {
                  FirebaseFirestore.instance
                      .collection('users')
                     .doc(id)
                      .delete();
                },
                background: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: dark,
                    child: Icon(Icons.delete),
                    alignment: Alignment.centerRight,
                  ),
                ),
                child: Container(
                  color: extralight,
                  child: ListTile(
                  
                    title: Text(name,style: TextStyle(color: dark),),
                    subtitle: Text(description,style: TextStyle(color: light),),
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
