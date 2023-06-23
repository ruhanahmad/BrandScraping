// ignore_for_file: constant_identifier_names, depend_on_referenced_packages

import 'dart:convert';
import 'dart:ui';
import 'dart:async';
import 'dart:io';
import 'package:encrypt/encrypt.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:scrapingdart/utils/static_data.dart';
import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

String formatDate(DateTime date) {
  List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  return "${months[date.month - 1]} ${date.day}";
}
String formatDateTime(DateTime date) {
  int hour = date.hour;
  String period = "AM";
  if (hour >= 12) {
    period = "PM";
    if (hour > 12) {
      hour -= 12;
    }
  }
  return "${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}-${date.year} ${hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')} $period";
}

String formatDateTimeToHHMM(DateTime date) {
  int hour = date.hour;
  String period = "AM";
  if (hour >= 12) {
    period = "PM";
    if (hour > 12) {
      hour -= 12;
    }
  }
  return "${hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')} $period";
}
String formatDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "$twoDigitMinutes:$twoDigitSeconds";
}



// Future<bool> requestPermissions() async {
//   var status = await Permission.camera.status;
//
//   if (status.isDenied || status.isRestricted || status.isPermanentlyDenied) {
//     // Request camera permission
//     status = await Permission.camera.request();
//     if (status.isDenied || status.isRestricted || status.isPermanentlyDenied) {
//       // User denied the permission, open app settings
//       AppSettings.openAppSettings();
//       return false;
//     }
//   }
//    status = await Permission.manageExternalStorage.status;
//   if (status.isDenied || status.isRestricted || status.isPermanentlyDenied) {
//     // Request camera permission
//     status = await Permission.manageExternalStorage.request();
//     if (status.isDenied || status.isRestricted || status.isPermanentlyDenied) {
//       // User denied the permission, open app settings
//       AppSettings.openAppSettings();
//       return false;
//     }
//   }
//
//   if(Platform.isIOS)
//     {
//       status = await Permission.storage.status;
//       if (status.isDenied || status.isRestricted || status.isPermanentlyDenied) {
//         status = await Permission.storage.request();
//         if (status.isDenied || status.isRestricted || status.isPermanentlyDenied) {
//           // User denied the permission, open app settings
//           AppSettings.openAppSettings();
//           return false;
//         }
//       }
//     }
//
//   // Check if the API level is not 13 on Android
//   if (Platform.isAndroid) {
//     var androidInfo = await DeviceInfoPlugin().androidInfo;
//     if (androidInfo.version.sdkInt == 33) {
//       return true;
//     }
//   }
//
//   // Request storage permission for Android and iOS
//   status = await Permission.storage.status;
//   if (status.isDenied || status.isRestricted || status.isPermanentlyDenied) {
//     status = await Permission.storage.request();
//     if (status.isDenied || status.isRestricted || status.isPermanentlyDenied) {
//       // User denied the permission, open app settings
//       AppSettings.openAppSettings();
//       return false;
//     }
//   }
//
//   // Check if all requested permissions have been granted
//   status = await Permission.camera.status;
//   if (!status.isGranted) {
//     return false;
//   }
//
//   status = await Permission.storage.status;
//   if (!status.isGranted) {
//     return false;
//   }
//
//   return true;
// }




String convertIntoBase64(String path) {
  if (path=="")
    {
      return path;
    }
  var file = File(path);
  List<int> fileBytes = file.readAsBytesSync();
  var fileBase64 = base64Encode(fileBytes);
  return fileBase64;
}

String formatBytes(int bytes) {
  const int KB = 1024;
  const int MB = 1024 * 1024;

  if (bytes >= MB) {
    return '${(bytes / MB).toStringAsFixed(2)} MB';
  } else if (bytes >= KB) {
    return '${(bytes / KB).toStringAsFixed(2)} KB';
  } else {
    return '$bytes bytes';
  }
}
Future<String> networkImageToBase64(String imageUrl) async {
  http.Response response = await http.get(Uri.parse(imageUrl));
  final bytes = response.bodyBytes;
  return (base64Encode(bytes));
}

String encrypt(String text) {

  if(text == "") {
    return text;
  }
  final key = Key.fromUtf8(StaticData.key);
  final iv = IV.fromLength(16);
  final encrypter = Encrypter(AES(key));
  final encrypted = encrypter.encrypt(text, iv: iv);
  return base64.encode(encrypted.bytes);
}

String decrypt(String cipherText ) {

  if(cipherText == "") {
    return cipherText;
  }

  final key = Key.fromUtf8(StaticData.key);
  final iv = IV.fromLength(16);
  final encrypter = Encrypter(AES(key));
  final encrypted = Encrypted.fromBase64(cipherText);
  final decrypted = encrypter.decrypt(encrypted, iv: iv);
  return decrypted;
}
bool isWithin10Seconds(DateTime givenDateTime) {
  DateTime currentDateTime = DateTime.now();
  Duration difference = currentDateTime.difference(givenDateTime);
  return difference.inSeconds.abs() < 10;
}
// Future<File> saveBase64Pdf(String base64PdfString, String fileName) async {
//
//   // Decode the base64-encoded PDF string into a list of bytes
//   List<int> bytes = base64Decode(base64PdfString);
//
//   // Get the directory for the Downloads folder on an Android device
//   Directory? downloadsDirectory = await getExternalStorageDirectory();
//   String downloadsPath = downloadsDirectory!.path;
//
//   // Create a new file with the specified file name in the Downloads folder
//   File file = File('$downloadsPath/$fileName');
//
//   // Write the PDF bytes to the file
//   await file.writeAsBytes(bytes);
//   Fluttertoast.showToast(msg: "Saved to Downloads");
//
//   return file;
// }

Future<bool> requestPermissions() async {
  final List<Permission> permissions = [
    Permission.camera,
    Permission.storage,
    Permission.photos
  ];

  await permissions.request();
  return true;
}

Future<File?> saveBase64Pdf(String base64PdfString, String fileName) async {
  bool flag = await requestPermissions();
  if (!flag) {
    Get.snackbar("Permissions", "Kindly allow permissions and try again");
    return null;
  }

  // Decode the base64-encoded PDF string into a list of bytes
  List<int> bytes = base64Decode(base64PdfString);

  // Get the directory for the platform-specific documents directory
  Directory? documentsDirectory = Platform.isAndroid
      ? await getExternalStorageDirectory()
      : await getApplicationDocumentsDirectory();

  if (documentsDirectory == null) {
    return null;
  }

  String documentsPath = documentsDirectory.path;
  if(Platform.isAndroid)
    {
      documentsPath = documentsDirectory.parent.parent.parent.parent.path;
    }

  // Create a new directory if it doesn't exist
  // Directory timeMasonDirectory = await
  // Directory('$documentsPath/downloads').create();
 // print(timeMasonDirectory.path);

  // Create a new file with the specified file name in the "time_mason" directory
  File file = File('$documentsPath/downloads/$fileName');

  // Write the PDF bytes to the file
  await file.writeAsBytes(bytes);
  Fluttertoast.showToast(msg: "saved");

  return file;
}

DateTime epochToDateTime(int epoch) {
  // Create a new DateTime object from the given epoch time
  return DateTime.fromMicrosecondsSinceEpoch(epoch * 1000);
}