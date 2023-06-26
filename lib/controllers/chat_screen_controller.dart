import 'dart:async';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/Material.dart';
import 'package:get/get.dart';
import 'package:scrapingdart/services/firebase_service.dart';
import 'package:scrapingdart/services/firestore_service.dart';
import 'package:scrapingdart/utils/helpers.dart';
import 'package:file_picker/file_picker.dart';
import '../models/message_model.dart';
import 'package:intl/intl.dart';
import 'package:advance_image_picker/advance_image_picker.dart';
import 'package:advance_image_picker/configs/image_picker_configs.dart';
import 'package:advance_image_picker/models/image_object.dart';
import 'package:advance_image_picker/widgets/picker/image_picker.dart';
import '../utils/static_data.dart';
import '../services/chat_service.dart';

class ChatScreenController extends GetxController {
  String chatId;
  final String userId;
  final String userName;

  ChatScreenController(
      {required this.chatId, required this.userId, required this.userName});

  var isOnline = true.obs;
  var isSending = false;
  String? roomId;
  FocusNode focusNode = FocusNode();
  ScrollController listScrollController = ScrollController();
  TextEditingController messageController = TextEditingController();
  bool isFirst = false;
  var isLoading = false.obs;
  late Timer timer;
  var emojiShowing = false.obs;
  ChatService chatService = ChatService();
  FireStoreService fireStoreService = FireStoreService();
  FirebaseService firebaseService = FirebaseService();

  List selectedImgFilePathList = [];

  @override
  void onInit() {
    super.onInit();
    listScrollController.addListener(() {
      focusNode.unfocus();
    });
    timer = Timer.periodic(const Duration(seconds: 2), (timer) {

      firebaseService.getUserLastSeen(userId).then((value) {
        isOnline.value = isWithin10Seconds(value);
      });
    });
  }

  @override
  void onClose() {
    timer.cancel();

    super.onClose();
  }

  onSendMessage() async {
    if (messageController.text.isEmpty || isSending) {
      return;
    }

    sendMessage(type: "text", message: messageController.text);

    messageController.clear();
  }

  void onSendFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null) {
      var path = result.files.first.path.toString();
      var fileName = result.files.first.name;
      var size = result.files.first.size;
      sendMessage(
          message: convertIntoBase64(path),
          type: "pdf",
          fileName: fileName,
          size: size);
    }
  }

  Future sendMessage(
      {required type, required message, String? fileName, size}) async {
    isSending= true;

    try {
      if (chatId == "new") {
        chatId = await chatService.sendFirstMessage(
          message: Message(
              fileName: encrypt(fileName ?? ""),
              data: type == "text" ? encrypt(message) : message,
              size: size,
              insertedAt: Timestamp.now(),
              userId: FirebaseAuth.instance.currentUser!.email,
              type: encrypt(type)),
          recipientId: userId,
          recipientName: userName,
        );
        update();
      } else {
        chatService.sendMessage(
            Message(
                data: type == "text" ? encrypt(message) : message,
                fileName: encrypt(fileName ?? ""),
                size: size,
                insertedAt: Timestamp.now(),
                userId: FirebaseAuth.instance.currentUser!.email,
                type: encrypt(type)),
            chatId,userName,userId);
      }
    }
    catch(e)
    {
      print(e);
    }
    isSending = false;
    return;
  }

  Future sendImages(context) async {
    // var res = await requestPermissions();
    //  if(!res)
    //  {
    //    Get.snackbar("Permissions", "Permissions are needed");
    //    return;
    //  }
    var configs = ImagePickerConfigs();
    configs.appBarTextColor = Colors.black;
    configs.stickerFeatureEnabled = false; // ON/OFF features
    configs.translateFunc = (name, value) => Intl.message(value, name: name);
    List<ImageObject>? objects = await Navigator.of(context)
        .push(PageRouteBuilder(pageBuilder: (context, animation, __) {
      return ImagePicker(maxCount: 5);
    }));

    if (objects != null) {
      selectedImgFilePathList.clear();
      selectedImgFilePathList
          .addAll(objects.map((e) => e.modifiedPath).toList());

      for (var path in selectedImgFilePathList) {
        sendMessage(type: "image", message: convertIntoBase64(path));
      }
    }
  }
}
