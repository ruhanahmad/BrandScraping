import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scrapingdart/screens/adminPanel.dart';
import 'package:scrapingdart/screens/adminScreen.dart';
import 'package:scrapingdart/screens/homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scrapingdart/screens/userProfile.dart';

import '../screens/userDashboard.dart';
class AuthService extends GetxController {
    User? userId;
  getIDo() async {
    userId = await FirebaseAuth.instance.currentUser;
    
    update();
    print(userId);
  }
  // to agar ye id app men doosri jaga chahiye ho to kese lein gay ?

 
   
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> uploadProfilePicture( imageFile) async {
    await getIDo();
    // Create a reference to the image in Firebase Storage.
    final imageReference = storage.ref().child('profile_pictures/${userId!.uid}');
// final file = await imageFile!.toFile();
    // Upload the image to Firebase Storage.
    await imageReference.putFile(imageFile);

    // Get the download URL for the image.
    final imageUrl = await imageReference.getDownloadURL();

    // Update the user's profile picture URL in Firestore.
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId!.uid)
        .update({'profilePictureUrl': imageUrl});

  }

  changeName(String names)async {

     await FirebaseFirestore.instance
        .collection('users')
        .doc(userId!.uid)
        .update({'name': names});
  }

  

  Future changePassword(email,oldPassword,NewPassword)async{
  await  getIDo();
 oldPassword != namess ?await  changeName(oldPassword):"";
    var cred = EmailAuthProvider.credential(email: email, password: oldPassword);

    await userId!.reauthenticateWithCredential(cred).then((value) =>
    
     userId!.updatePassword(NewPassword))
    .catchError((error){
      Get.snackbar("Error","${error}");
 print(error);
    });
     
  }
  dynamic valuess;
  var namess;
  var emailsss;
  Future getProfileData() async {
    await getIDo();
    // EasyLoading.show();
    // welcome = Welcome();
    // accountss  = Account();
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userId!.uid)
        .get()
        .then((DocumentSnapshot value) {
      valuess = value.data();
      print(valuess);
      emailsss = valuess['email'];
      namess = valuess["name"];


      // accountsList.add(Account.fromJson(value));
      print(valuess);
      update();
    });
    // EasyLoading.dismiss();
  }
  var whistle;
    Future checksIFaaa() async {
     await getIDo();
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userId!.uid)
        .get()
        .then((DocumentSnapshot value) {
       whistle = value.data();
       Get.to( UserProfile());

      //  var id = whistle.first.id;
      // if (whistle == null) {
      //   Get.to(CountryField());
      // } else {
      //   Get.to(HomePage());
      // }
    });
  }
  String? emailv;
  final FirebaseAuth _auth = FirebaseAuth.instance;
   Future   adminSignin(String email,String password)async{
        try {
      UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("admin signed in");
      // ye funtion to chal r nai raha 
      //karo zra log out kar k dubara 
      await getIDo();
      // ?
   Get.to(()=>UserDashboard ());
   //
   

    
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }

   }
   


    Future  checksIFLogin(String email,String password) async {
    // have   =  "admin";
          


    await FirebaseFirestore.instance
        .collection("users")
        .where('email', isEqualTo:email)
        .get()
        .then((QuerySnapshot querySnapshot) async{
      if (querySnapshot.size > 0) {
    //  emailSignupLogin(email,password);
 await  adminSignin( email, password);
     
      } else {
        Get.snackbar("Not Successfull", "Sign up first");
        // Data does not exist
      }
    });
  }



    Future  checksIFSignUp(String email,String password) async {
    // have   =  "admin";
    update();
    
    await FirebaseFirestore.instance
        .collection("admin")
        .where('email', isEqualTo:email)
        .get()
        .then((QuerySnapshot querySnapshot) async{
      if (querySnapshot.size > 0) {
    //  emailSignupLogin(email,password);
//  await  adminSignin( email, password);
//  await getIDo();
        // Get.to(()=>AdminScreen());
   
    try {
      UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("admin signed in");
      // ye funtion to chal r nai raha 
      //karo zra log out kar k dubara 
        Get.to(()=>AdminScreen());
      await getIDo();
      // ?
  //  Get.to(()=>UserDashboard ());
   //
   // han g twana saab hehe
   // iska aapko pta chalna tha ? is error ka
   // ha rt ko yahe dykh rhi thi vo nh ly rha the currentuserid
   //to mjy l gya ta ya chl nh rha Good 

    
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }



      } else {
        Get.snackbar("Not Successfull", "You are not admin");
        // Data does not exist
      }
    });
  }
  
  
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  // Sign Up with email and password
  Future<String?> signUp(String email, String password,String name) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
        
      );
      print(email);
      

    // Save user data in Firestore
    await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
      'email': email,
      "name":name,
      
    });
     
      Get.snackbar("Success", "User Signup  successfully");
 Get.to(()=>UserDashboard ());
      return null;
      
      
      
      
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
              Get.snackbar("Weak", "Pasword provided is Weak");
        print(email);
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
          Get.snackbar("Used", "The account already exists for that email.");
        print(email);
        return 'The account already exists for that email.';
      }
      return e.message;
    } catch (e) {
          Get.snackbar("Error","Error Solving this Authentication");
      print(e);

      return e.toString();
    }
  }
TextEditingController emailvv =  TextEditingController();
  // Login with email and password
  Future<String?> login(String email, String password) async {
    //  emailv    =    email;
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
       Get.snackbar("Success", "User Login Successfully");
       Get.to(()=>FirebaseGridView ());
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
         Get.snackbar("Not Found", "User not found");
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
         Get.snackbar("Incorrect", "Password is Incorrect");
        return 'Wrong password provided for that user.';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  // Forget password
  Future<String?> forgetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
       Get.snackbar("Success", "Email Sent successfully");
      return null;

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
         Get.snackbar("UnSuccess", "No user found for email");
        return 'No user found for that email.';
      }
      return e.message;
    } catch (e) {
       Get.snackbar("Error", "${e}");
      return e.toString();
    }
  }
}
