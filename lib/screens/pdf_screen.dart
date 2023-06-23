import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../utils/palette.dart';

class PDFScreen extends StatelessWidget {
  String fileName, urlFile;
  PDFScreen( this.fileName, this.urlFile, {super.key});


  late double width;

  late double height;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.black,
        title: Text(
          fileName,style: GoogleFonts.dmSans(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Palette.primaryColor,
      ),
      body: Container(
        color: Colors.white,
        width: width,
        height: height,
        child: SfPdfViewer.memory(
          base64Decode( urlFile),
        ),
      ),
    );
  }
}