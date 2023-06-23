import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

const apiKey = 'Q1gnPcHnfRpkasPcqheYjHGo';



class BackgroundRemoverPage extends StatefulWidget {
  @override
  _BackgroundRemoverPageState createState() => _BackgroundRemoverPageState();
}

class _BackgroundRemoverPageState extends State<BackgroundRemoverPage> {
  File? _selectedImage;
  String? _processedImageUrl;

  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
        _processedImageUrl = null;
      });
    }
  }

  Future<void> _removeBackground() async {
    if (_selectedImage == null) {
      return;
    }

    final apiUrl = 'https://api.remove.bg/v1.0/removebg';
    final response = await http.post(
      Uri.https(apiUrl),
      headers: {'X-Api-Key': apiKey},
      body: {'image_file': _selectedImage!.readAsBytesSync()},
    );

    if (response.statusCode == 200) {
      final decodedResponse = json.decode(response.body);
      final processedImageUrl = decodedResponse['data']['result']['image_url'];

      setState(() {
        _processedImageUrl = processedImageUrl;
      });
    } else {
      print('API request failed with status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Background Remover'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_selectedImage != null)
              Image.file(
                _selectedImage!,
                height: 200,
              )
            else
              Icon(
                Icons.image,
                size: 100,
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _selectImage,
              child: Text('Select Image'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _removeBackground,
              child: Text('Remove Background'),
            ),
            SizedBox(height: 20),
            if (_processedImageUrl != null)
              Image.network(
                _processedImageUrl!,
                height: 200,
              ),
          ],
        ),
      ),
    );
  }
}



// import 'dart:typed_data';
// import 'dart:ui' as ui;

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:remove_background/remove_background.dart';

// // void main() {
// //   runApp(const MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   const MyApp({Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Remove Background Example',
// //       theme: ThemeData(
// //         primarySwatch: Colors.blue,
// //       ),
// //       home: const MyHomePage(title: 'Remove Background Example'),
// //     );
// //   }
// // }

// class MyHomePages extends StatefulWidget {
//   const MyHomePages({Key? key, required this.title}) : super(key: key);
//   final String title;
//   @override
//   State<MyHomePages> createState() => _MyHomePagesState();
// }

// class _MyHomePagesState extends State<MyHomePages> {
//   bool isLoaded = false;
//   ui.Image? image;
//   ByteData? pngBytes;

//   @override
//   initState() {
//     getUiImage();
//     super.initState();
//   }

//   getUiImage() async {
//     ByteData data = await rootBundle.load('assets/lo.png');
//     image = await decodeImageFromList(data.buffer.asUint8List());
//     await getPNG();
//     setState(() {
//       isLoaded = true;
//     });
//   }

//   getPNG() async {
//     pngBytes = await image?.toByteData(format: ui.ImageByteFormat.png);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             isLoaded
//                 ? Image.memory(Uint8List.view(pngBytes!.buffer))
//                 : const Icon(Icons.image),
//             const Text(
//               'Example remove background image',
//             ),
//             isLoaded
//                 ? TextButton(
//                     onPressed: () async {
//                       pngBytes =
//                           await cutImage(context: context, image: image!);
//                       setState(() {});
//                     },
//                     child: const Text("Cutout Image"))
//                 : const SizedBox()
//           ],
//         ),
//       ),
//     );
//   }
// }