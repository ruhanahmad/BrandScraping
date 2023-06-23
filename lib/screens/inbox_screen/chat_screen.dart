import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scrapingdart/controllers/chat_screen_controller.dart';
import 'package:scrapingdart/screens/inbox_screen/widgets/chat_bubble.dart';
import '../../models/message_model.dart';
import '../../utils/helpers.dart';
import '../../utils/palette.dart';
import '../../utils/static_data.dart';
import 'package:flutter/foundation.dart' as foundation;

class ChatScreen extends StatelessWidget {
  final String userName;

  final String userId;

  final String chatId;

  final String profilePic;

  const ChatScreen(
      {Key? key,
      required this.userName,
      required this.chatId,
      required this.userId,
      required this.profilePic})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<ChatScreenController>(
      init: ChatScreenController(
          userId: userId, chatId: chatId, userName: userName),
      builder: (_) => SafeArea(
        child: Scaffold(
          backgroundColor: Palette.primaryColor,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(size.width * .2),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20, right: size.width * .15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: size.width * .05),
                        child: IconButton(
                            onPressed: () => Get.back(),
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            )),
                      ),
                      Text(
                        "Chat",
                        style: GoogleFonts.dmSans(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox()
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: _.isLoading.value
              ? const Center(
                  child: CupertinoActivityIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: size.height * .055,
                          ),
                          Expanded(
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(40),
                                    topRight: Radius.circular(40)),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: size.width*.05,),
                                  Flexible(
                                    child: StreamBuilder(
                                      stream: _.chatService.messageListStream(
                                          documentId: _.chatId,
                                          descending: false),
                                      builder: (context, snapshot) {

                                        if (snapshot.hasData) {
                                          List messages = snapshot.data!.docs;
                                         // _.chatService.setUserRead(_.chatId, messages.length);

                                          Future.delayed(
                                                  const Duration(milliseconds: 100))
                                              .then((value) => {
                                                    _.listScrollController
                                                        .animateTo(
                                                      _.listScrollController
                                                          .position
                                                          .minScrollExtent,
                                                      duration: const Duration(
                                                          milliseconds: 500),
                                                      curve: Curves.ease,
                                                    )
                                                  });
                                          return ListView.builder(
                                            controller: _.listScrollController,
                                            padding: const EdgeInsets.only(
                                                left: 10.0,right: 10),
                                            itemCount: messages.length,
                                            reverse: true,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              Message message =
                                                  Message.fromJson(messages
                                                      .reversed
                                                      .toList()[index]
                                                      .data());
                                              return ChatBubble(
                                                  message: message.type ==
                                                          "QH7il3+yt5sU/hE7YRquVA=="
                                                      ? decrypt(
                                                          message.data ?? "")
                                                      : message.data ?? "",
                                                  size: size,
                                                  time: message.insertedAt!.toDate(),
                                                  isMe: message.userId ==
                                                      FirebaseAuth.instance.currentUser!.email,
                                                  fileName: decrypt(
                                                      message.fileName ?? ""),
                                                  fileSize: message.size,
                                                  type: decrypt(
                                                      message.type ?? ""));
                                            },
                                          );
                                        } else {
                                          return const Center(
                                              child:
                                                  CupertinoActivityIndicator());
                                        }
                                      },
                                    ),
                                  ),
                                  Container(
                                    constraints: BoxConstraints(
                                        maxHeight: size.width * .3),
                                    //height: size.width*.15,
                                    color: Palette.primaryColor,

                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            padding: EdgeInsets.only(
                                              left: size.width * .025,
                                              top: size.width * .02,
                                              bottom: size.width * .02,
                                            ),
                                            child: TextFormField(
                                              controller: _.messageController,
                                              maxLines: null,
                                              onTap: (){_.emojiShowing.value=false;},
                                              cursorColor: Colors.white,
                                              style: GoogleFonts.dmSans(
                                                  fontSize: 14,
                                                  color: Colors.white),
                                              decoration: InputDecoration(
                                                suffixIcon: InkWell(
                                                  onTap: (){_.sendImages(context);},
                                                  child: Icon(
                                                    Icons.image_outlined,
                                                    color: Colors.white,
                                                    size: size.width * .06,
                                                  ),
                                                ),
                                                enabledBorder:
                                                    const OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              25.0)),
                                                  borderSide: BorderSide(
                                                      color: Colors.white,
                                                      width: 1),
                                                ),
                                                focusedBorder:
                                                    const OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              25.0)),
                                                  borderSide: BorderSide(
                                                      color: Colors.white,
                                                      width: 1),
                                                ),
                                                hintText: "Type...",
                                                hintStyle: GoogleFonts.dmSans(
                                                    fontSize: 14,
                                                    color: Colors.white
                                                        .withOpacity(0.3)),
                                                // isDense: true,
                                                //fillColor: Palette.color_8FDFE3.withOpacity(0.2),
                                                filled: true,
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                            onTap: () => {_.onSendMessage()},
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 0,
                                                  left: 20,
                                                  right: 10),
                                              child: Icon(
                                                FontAwesomeIcons.paperPlane,
                                                color: Colors.white,
                                                size: size.width * .06,
                                              ),
                                            )),
                                        InkWell(
                                          onTap: () => {_.onSendFile()},
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 0, left: 10),
                                            child: Transform.rotate(
                                              angle: .75,
                                              child: Icon(
                                                Icons.attach_file,
                                                color: Colors.white,
                                                size: size.width * .07,
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () => {
                                          SystemChannels.textInput.invokeMethod('TextInput.hide'),
                                            _.emojiShowing.value=!_.emojiShowing.value},
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 0, left: 10, right: 15),
                                            child: Icon(
                                              Icons.emoji_emotions_outlined,
                                              color: Colors.white,
                                              size: size.width * .07,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                        Obx(()=>  Offstage(
                            offstage: !_.emojiShowing.value,
                            child: SizedBox(
                                height: 250,
                                child: EmojiPicker(
                                  textEditingController: _.messageController,
                                  config: Config(
                                    columns: 7,
                                    // Issue: https://github.com/flutter/flutter/issues/28894
                                    emojiSizeMax: 32 *
                                        (foundation.defaultTargetPlatform ==
                                            TargetPlatform.iOS
                                            ? 1.30
                                            : 1.0),
                                    verticalSpacing: 0,
                                    horizontalSpacing: 0,
                                    gridPadding: EdgeInsets.zero,
                                    initCategory: Category.RECENT,
                                    bgColor: const Color(0xFFF2F2F2),
                                    indicatorColor: Colors.blue,
                                    iconColor: Colors.grey,
                                    iconColorSelected: Colors.blue,
                                    backspaceColor: Colors.blue,
                                    skinToneDialogBgColor: Colors.white,
                                    skinToneIndicatorColor: Colors.grey,
                                    enableSkinTones: true,
                                    // showRecentsTab: true,
                                    recentsLimit: 28,
                                    replaceEmojiOnLimitExceed: false,
                                    noRecents: const Text(
                                      'No Recents',
                                      style: TextStyle(fontSize: 20, color: Colors.black26),
                                      textAlign: TextAlign.center,
                                    ),
                                    loadingIndicator: const SizedBox.shrink(),
                                    tabIndicatorAnimDuration: kTabScrollDuration,
                                    categoryIcons: const CategoryIcons(),
                                    buttonMode: ButtonMode.MATERIAL,
                                    checkPlatformCompatibility: true,
                                  ),
                                )),
                          )),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: size.width * .05,
                          ),
                          Stack(
                            children: [
                              Container(
                                width: size.width * .21,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: HexColor("#FFFFFF"), width: 2)),
                                child: CircleAvatar(
                                  radius: size.width * .08,
                                  backgroundColor: Palette.secondaryColor,
                                  backgroundImage: NetworkImage(
                                    profilePic,
                                  ),
                                ),
                              ),
                              Obx(() => Positioned(
                                    bottom: 10,
                                    right: 0,
                                    child: CircleAvatar(
                                      radius: size.width * .025,
                                      backgroundColor: _.isOnline.value
                                          ? Palette.color_42FC60
                                          : Colors.grey.shade400,
                                    ),
                                  ))
                            ],
                          ),
                          SizedBox(
                            width: size.width * .02,
                          ),
                          Text(
                            userName,
                            style: TextStyle(
                                fontSize: size.width * .045,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          )
                        ],
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
