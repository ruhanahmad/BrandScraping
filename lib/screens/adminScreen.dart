import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrapingdart/main.dart';
import 'package:scrapingdart/screens/adminPanel.dart';
import 'package:scrapingdart/screens/chat_screen.dart';
import 'package:scrapingdart/screens/editScreen.dart';
import 'package:scrapingdart/screens/inbox_screen/admin_inbox_screen.dart';
import 'package:scrapingdart/screens/loginSigns.dart';
import 'package:scrapingdart/screens/userList.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  Color dark = Color(0xFF395B64);
  Color light = Color(0xFFA5C9CA);
  Color extralight = Color(0xFFE7F6F2);
  Color extradark = Color(0xFF2C3333);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: extralight,
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Container(
                  //height: 250,
                  width: MediaQuery.of(context).size.width,
                  color: dark,
                  child: Column(
                    children: [
                      Text(
                        "Admin Panel",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        color: extralight,
                        child: Text(
                          "",
                          style: TextStyle(color: extradark),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 80,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(RecordListPage());
                      },
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          color: light,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(25),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.verified_user, size: 40),
                                SizedBox(height: 10),
                                Text("Users"),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(Addbrands());
                      },
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          color: light,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(25),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.badge, size: 50),
                                SizedBox(height: 10),
                                Text("Brands"),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 20,
                ),
                //  Container(height: 200,width: 400,color: Colors.yellow,child: Text("Logout"),),
                GestureDetector(
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    Get.to(LoginSigns());
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        color: light,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(25),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Icon(
                              Icons.logout,
                              size: 45,
                            ),
                            SizedBox(height: 10),
                            Center(child: Text("Logout"))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // Text("${authService.userId!.uid}"),
                 GestureDetector(
                          onTap: () async {
                            // await FirebaseAuth.instance.signOut();
                            // Get.to(ChatScreen());
                            Get.to(()=>AdminInboxScreen());
                          },
                          child: 
               Text("data"),
                        ),
              ],//admin login kaha ho raha hayyyyy 
              //vohi to bta rhi hu
              //ya admin login he kia h
            ),
          )),
    );
  }
}
