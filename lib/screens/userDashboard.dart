// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:scrapingdart/AuthFirebase/auth.dart';

// import 'package:scrapingdart/main.dart';
// import 'package:scrapingdart/screens/adminPanel.dart';
// import 'package:scrapingdart/screens/homepage.dart';
// import 'package:scrapingdart/screens/loginSigns.dart';
// import 'package:scrapingdart/screens/mapGoogle.dart';
// import 'package:scrapingdart/screens/userList.dart';
// import 'package:scrapingdart/screens/userProfile.dart';

// class UserDashboard extends StatefulWidget {
//   const UserDashboard({super.key});

//   @override
//   State<UserDashboard> createState() => _UserDashboardState();
// }

// class _UserDashboardState extends State<UserDashboard> {
//   AuthService authService = Get.put(AuthService());
//   @override
//   Widget build(BuildContext context) {
//     //colors added
//     Color dark = Color(0xFF395B64);
//     Color light = Color(0xFFA5C9CA);
//     Color extralight = Color(0xFFE7F6F2);
//     Color extradark = Color(0xFF2C3333);
//     return SafeArea(
//       child: Scaffold(
//           backgroundColor: extralight,
//           body: Container(
//             height: MediaQuery.of(context).size.height,
//             width: MediaQuery.of(context).size.width,
//             child: Column(
//               children: [
//                 Container(
//                   height: 250,
//                   width: MediaQuery.of(context).size.width,
//                   color: dark,
//                   child: Column(
//                     children: [
//                       Text(
//                         "User Panel",
//                         style: TextStyle(color: Colors.white, fontSize: 20),
//                       ),
//                       SizedBox(
//                         height: 15,
//                       ),
//                       Container(
//                         height: 200,
//                         width: MediaQuery.of(context).size.width,
//                         color: extralight,
//                         child: Text(
//                           "",
//                           style: TextStyle(color: Colors.purple),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(9),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       GestureDetector(
//                         onTap: () async {
//                           await authService.getProfileData();
//                           Get.to(UserProfile());
//                         },
//                         child: Container(
//                           height: 180,
//                           width: 180,
//                           color: light,
//                           child: Column(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.all(20),
//                                 child: Icon(
//                                   Icons.verified_user,
//                                   size: 100,
//                                 ),
//                               ),
//                               Center(child: Text("Profile"))
//                             ],
//                           ),
//                         ),
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           Get.to(FirebaseGridView());
//                           //  MapViewGoogle;
//                         },
//                         child: Container(
//                           height: 180,
//                           width: 180,
//                           color: light,
//                           child: Column(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.all(20),
//                                 child: Icon(
//                                   Icons.location_city,
//                                   size: 100,
//                                 ),
//                               ),
//                               Center(child: Text("Discounts"))
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 0,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(9),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           Get.to(FirebaseGridView());
//                         },
//                         child: Container(
//                           height: 180,
//                           width: 180,
//                           color: light,
//                           child: Column(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Icon(
//                                   Icons.branding_watermark,
//                                   size: 100,
//                                 ),
//                               ),
//                               Center(child: Text("Discount Brands"))
//                             ],
//                           ),
//                         ),
//                       ),
//                       GestureDetector(
//                         onTap: () async {
//                           await FirebaseAuth.instance.signOut();
//                           Get.to(LoginSigns());
//                         },
//                         child: Container(
//                           height: 180,
//                           width: 180,
//                           color: light,
//                           child: Column(
//                             children: [
//                               Icon(
//                                 Icons.logout,
//                                 size: 100,
//                               ),
//                               Center(child: Text("Logout"))
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           )),
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrapingdart/AuthFirebase/auth.dart';
import 'package:scrapingdart/hi.dart';
import 'package:scrapingdart/main.dart';
import 'package:scrapingdart/screens/adminPanel.dart';
import 'package:scrapingdart/screens/chat_screen.dart';
import 'package:scrapingdart/screens/homePageTwo.dart';
import 'package:scrapingdart/screens/homepage.dart';
import 'package:scrapingdart/screens/inbox_screen/inbox_screen.dart';
import 'package:scrapingdart/screens/loginSigns.dart';
import 'package:scrapingdart/screens/mapGoogle.dart';
import 'package:scrapingdart/screens/userList.dart';
import 'package:scrapingdart/screens/userProfile.dart';
// import 'package:carousel_slider/carousel_slider.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({super.key});

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  AuthService authService = Get.put(AuthService());

  @override
  Widget build(BuildContext context) {
    // Colors
    Color dark = Color(0xFF395B64);
    Color light = Color(0xFFA5C9CA);
    Color extralight = Color(0xFFE7F6F2);
    Color extradark = Color(0xFF2C3333);

    return SafeArea(
      child: Scaffold(
        backgroundColor: extralight,
        body: Column(
          children: [
            Container(
     
              child: Column(
                children: [
                  Container(
                    //   height: 300,
                    //   width: MediaQuery.of(context).size.width,
                    color: light,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            "User Panel",
                            style: TextStyle(color: extradark, fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            color: extralight,
                              child: Padding(
                                padding: const EdgeInsets.all(08),
                                child: Text(
                                  "Welcome to Dis Nav!! This application is all about discounts on different brands and navigating it to listed brands. Here you can easily reach out to your best discounts destination without any hassale. Simple go to discounts and it will point out all the destinations having discounts info and the products having discount on the application.",
                                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await authService.getProfileData();
                            Get.to(UserProfile());
                          },
                          child: Container(
                            height: 180,
                            width: 180,
                            decoration: BoxDecoration(
                              color: light,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Icon(
                                    Icons.verified_user,
                                    size: 100,
                                  ),
                                ),
                                Center(child: Text("Profile")),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(FirebaseGridViewTwo());
                          },
                          child: Container(
                            height: 180,
                            width: 180,
                            decoration: BoxDecoration(
                              color: light,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Icon(
                                    Icons.location_city,
                                    size: 100,
                                  ),
                                ),
                                Center(child: Text("Discounts")),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 0),
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(FirebaseGridView());
                          },
                          child: Container(
                            height: 180,
                            width: 180,
                            decoration: BoxDecoration(
                              color: light,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Icon(
                                    Icons.branding_watermark,
                                    size: 100,
                                  ),
                                ),
                                Center(child: Text("Discount Brands")),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await FirebaseAuth.instance.signOut();
                            Get.to(LoginSigns());
                          },
                          child: Container(
                            height: 180,
                            width: 180,
                            decoration: BoxDecoration(
                              color: light,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Icon(
                                    Icons.logout,
                                    size: 100,
                                  ),
                                ),
                                Center(child: Text("Logout")),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),//kholo chat ki scree inbo_screen app main
                  ),
                 //cht open karo
                ],
              ),
            ),
               GestureDetector(
                          onTap: () async {
                            // await FirebaseAuth.instance.signOut();
                            // Get.to(ChatScreen());
                         await   authService.getIDo(); 
                               Get.to(InboxScreen());
                          },
                          child: 
               Text("data"),
                        ),
          ],
        ),
      ),
    );
  }
}

//slider widget created onwwn

// class SliderWidget extends StatelessWidget {
//   final List<String> carouselImages = [
//     'assets/image1.jpg',
//     'assets/image2.jpg',
//     'assets/image3.jpg',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return CarouselSlider(
//       items: carouselImages.map((image) {
//         return Container(
//           height: 200,
//           color: Colors.grey,
//           child: Center(
//             child: Image.asset(
//               'assets/image/1.png',
//               //  'assets/image/2.png',
//               //  'assets/image/3.png',
//               fit: BoxFit.cover,
//             ),
//           ),
//         );
//       }).toList(),
//       options: CarouselOptions(
//         height: 200,
//         viewportFraction: 1.0,
//         enlargeCenterPage: false,
//         onPageChanged: (index, reason) {},
//       ),
//     );
//   }
// }
