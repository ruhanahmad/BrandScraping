import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scrapingdart/screens/image_viewer_screen.dart';
import 'package:scrapingdart/screens/inbox_screen/widgets/text_time.dart';
import 'package:scrapingdart/screens/pdf_screen.dart';
import 'package:scrapingdart/screens/widgets/custom_dropdown.dart';
// import 'package:scrapingdart/screens/pdf_screen.dart';
import 'package:scrapingdart/utils/helpers.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../utils/enums.dart';
import '../../../utils/palette.dart';
import 'package:get/get.dart';

// import '../../widgets/custom_dropdown.dart';
// import '../../widgets/file_save_drop_down.dart';

class ChatBubble extends StatefulWidget {
  final String message;
  final String type;
  final String? fileName;
  final int? fileSize;
  final DateTime time;
  final bool isMe;
  final Size size;

  const ChatBubble({
    super.key,
    required this.message,
    required this.time,
    this.fileName,
    this.fileSize,
    required this.size,
    required this.isMe,
    required this.type,
  });

  @override
  _ChatBubbleState createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  Color chatBubbleColor() {
    if (widget.isMe) {
      return Theme.of(context).primaryColor;
    } else {
      return Colors.grey.shade200;
    }
  }

  Color chatBubbleReplyColor() {
    return Colors.grey.shade50;
  }

  @override
  Widget build(BuildContext context) {
    final align =
        widget.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final radius = widget.isMe
        ? const BorderRadius.only(
            topLeft: Radius.circular(15.0),
            bottomLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0))
        : const BorderRadius.only(
            topRight: Radius.circular(15.0),
            bottomRight: Radius.circular(10.0),
            topLeft: Radius.circular(10.0),
          );
    return Column(
      crossAxisAlignment: align,
      children: <Widget>[
        Container(
          //margin: const EdgeInsets.all(3.0),
          //padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color: chatBubbleColor(),
            borderRadius: radius,
          ),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width / 1.3,
            minWidth: 20.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(widget.type == "text" ? 5 : 0),
                child: widget.type == "text"
                    ? Text(
                        widget.message,
                        style: TextStyle(
                          color:
                              widget.isMe ? Colors.white : Palette.color_524B6B,
                        ),
                      )
                    : widget.type == "image"
                        ? InkWell(
                            onTap: () {
                              Get.to(() => ImageViewerPage(
                                  [widget.message], 0, SourceType.Base64));
                            },
                            child: ClipRRect(
                              borderRadius: radius,
                              child: Image.memory(
                                base64Decode(widget.message),
                                height: 200,
                                width: MediaQuery.of(context).size.width / 1.3,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : widget.type == "pdf"
                            ? InkWell(
                                onTap: () {
                                  Get.to(() => PDFScreen(
                                      widget.fileName ?? "", widget.message));
                                },
                                child: Container(
                                  width: widget.size.width * .5,
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.solidFilePdf,
                                        color: Palette.color_E5252A,
                                        size: widget.size.width * .12,
                                      ),
                                      SizedBox(
                                        width: widget.size.width * .02,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: widget.size.width * .175,
                                            child: Text(
                                              widget.fileName ?? "",
                                              maxLines: 2,
                                              style: GoogleFonts.dmSans(
                                                color: widget.isMe
                                                    ? Colors.white
                                                    : Palette.color_524B6B,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: widget.size.width * .01,
                                          ),
                                          Text(
                                            "${formatBytes(widget.fileSize ?? 0)} PDF",
                                            style: GoogleFonts.dmSans(
                                                fontSize: 10,
                                                color: Palette.color_D0DBE0),
                                          )
                                        ],
                                      ),
                                      CustomDropDown(
                                          size: widget.size,
                                          bgColor: Palette.primaryColor,
                                          menuItems: [MenuItem(
                                              iconColor: widget.isMe
                                                  ? Colors.white
                                                  : Palette.color_524B6B,
                                              textColor: widget.isMe
                                                  ? Colors.white
                                                  : Palette.color_524B6B,
                                              onPressed: () {
                                                saveBase64Pdf(widget.message,
                                                    widget.fileName ?? "");
                                              }, text: 'Save', icon: Icons.save_alt_rounded)],
                                          iconColor: widget.isMe
                                              ? Colors.white
                                              : Palette.color_524B6B),
                                      
                                    ],
                                  ),
                                ),
                              )
                            : const SizedBox(),
              ),
            ],
          ),
        ),
        Padding(
          padding: widget.isMe
              ? const EdgeInsets.only(
                  right: 10.0,
                  bottom: 10.0,
                )
              : const EdgeInsets.only(
                  left: 10.0,
                  bottom: 10.0,
                ),
          child: TextTime(
            child: Text(
              formatDateTimeToHHMM(widget.time),
              style: TextStyle(
                color: Palette.color_AAA6B9,
                fontSize: 10.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
