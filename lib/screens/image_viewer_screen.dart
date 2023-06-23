// ignore_for_file: prefer_const_constructors, no_logic_in_create_state, must_be_immutable, depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:get/get.dart';
import 'package:scrapingdart/utils/enums.dart';

import '../utils/palette.dart';
import '../utils/shapes.dart';

class ImageViewerPage extends StatefulWidget {
  List<String> images = [];
  int initialPage;
  SourceType sourceType;

  ImageViewerPage(this.images, this.initialPage, this.sourceType, {super.key});

  @override
  State<ImageViewerPage> createState() =>
      _ImageViewerPage(images, initialPage, sourceType);
}

class _ImageViewerPage extends State<ImageViewerPage>
    with SingleTickerProviderStateMixin {
  List<String> images = [];
  int initialPage;
  SourceType sourceType;

  _ImageViewerPage(this.images, this.initialPage, this.sourceType);

  late PageController pageController = PageController(initialPage: initialPage);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            PhotoViewGallery.builder(
              pageController: pageController,
              scrollPhysics: const BouncingScrollPhysics(),
              builder: (BuildContext context, int index) {
                return PhotoViewGalleryPageOptions(
                    maxScale: PhotoViewComputedScale.contained * 10,
                    imageProvider: sourceType == SourceType.Network
                        ? Image
                        .network(images[index].toString())
                        .image
                        : sourceType == SourceType.File ? Image
                        .file(File(images[index].toString()))
                        .image : Image.memory(base64Decode(images[index])).image,
                    initialScale: PhotoViewComputedScale.contained * 1.01,
                    minScale: PhotoViewComputedScale.contained * 1.01);
              },
              itemCount: images.length,
              loadingBuilder: (context, event) =>
                  Center(
                    child: CupertinoActivityIndicator(),
                  ),
            ),
            Positioned(
              left: size.width * .05,
              top: size.width * .05,
              child: SizedBox(
                width: size.width * .1,
                child: MaterialButton(
                    padding: EdgeInsets.symmetric(horizontal: size.width * .03),
                    shape: Shapes.materialButtonShape(radius: 5),
                    elevation: 0,
                    color: Palette.primaryColor.withOpacity(0.8),
                    onPressed: () => Get.back(),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
