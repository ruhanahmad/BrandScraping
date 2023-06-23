import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scrapingdart/controllers/inbox_screen_controller.dart';
import 'package:scrapingdart/models/user_profile_response_model.dart';

import 'package:scrapingdart/screens/inbox_screen/widgets/chat_item.dart';
import 'package:scrapingdart/services/auth_services.dart';
import 'package:scrapingdart/services/chat_service.dart';
import 'package:scrapingdart/utils/helpers.dart';
import '../../models/message_model.dart';

import '../../utils/palette.dart';
import '../../utils/static_data.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'chat_screen.dart';

class AdminInboxScreen extends StatelessWidget {
  AdminInboxScreen({Key? key}) : super(key: key);
  final ChatService _chatService = ChatService();
//time mason wala code kholo zara dekh mujhe kam per laga k so jati
// dykh rhi hu
//mason vala?
//apk vala ? g jis se ye sab churaya hay woh kholo
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<InboxScreenController>(
      init: InboxScreenController(),
      builder: (_) => SafeArea(
        child: Scaffold(
          backgroundColor: Palette.primaryColor,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(size.width * .35),
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
                        "Inbox",
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
                SizedBox(
                  width: size.width * .9,
                  child: TextFormField(
                    controller: _.searchEditingController,
                    style:
                        GoogleFonts.dmSans(fontSize: 16, color: Colors.white),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        size: size.width * .07,
                        color: Colors.white.withOpacity(0.3),
                      ),
                      hintText: "Search message",
                      errorStyle: const TextStyle(fontSize: 10, height: 0.3),
                      hintStyle: GoogleFonts.dmSans(
                          fontSize: 16, color: Colors.white.withOpacity(0.3)),
                      isDense: true,
                      fillColor: Palette.color_8FDFE3.withOpacity(0.2),
                      filled: true,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (keyWord) {
                      _.update();
                    },
                  ),
                )
              ],
            ),
          ),
          body: _.isLoading.value
              ? const Center(
                  child: CupertinoActivityIndicator(),
                )
              : Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40)),
                  ),
                  padding: EdgeInsets.only(
                    top: size.width * .07,
                  ),
                  child: StreamBuilder(
                    stream: _chatService.userChatsStream(),
                    //chalo admin ki traf jao login karo
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List usersChatList = snapshot.data!.docs;
                        if (usersChatList.isNotEmpty) {
                          return ListView.builder(
                              itemCount: usersChatList.length,
                              itemBuilder: (context, index) {
                                var data = usersChatList[index].data();
                                List users = data['users'];
                                String user = users.firstWhere((e) => e!=FirebaseAuth.instance.currentUser!.email);
                                print(user);
                           
                                print(usersChatList[index].id);
                                return ChatItem(
                                    chatId: usersChatList[index].id,
                                    name: user,
                                    onTap: () => Get.to(() => ChatScreen(
                                        userName: user,
                                        chatId:
                                            usersChatList[index].id,
                                        userId: user,
                                        profilePic: "https://picsum.photos/id/$index/100/100")),
                                    size: size,
                                    profilePicUrl: "https://picsum.photos/id/$index/100/100",
                                    messageCount: 0,
                                    message: "",
                                    type: "",
                                    time: "");
                               
                                DocumentSnapshot chatListSnapshot =
                                    usersChatList[index];
                                return StreamBuilder(
                                  stream: _chatService.messageListStream(
                                      documentId: chatListSnapshot.id,
                                      descending: true),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      List messages = snapshot.data!.docs;
                                      Message message = Message.fromJson(
                                        messages.first.data(),
                                      );
                                      List users =
                                          chatListSnapshot.get('users');
                                      // remove the current user's id from the Users
                                      // list so we can get the second user's id
                                      users.remove(StaticData.loggedInUserId);
                                      return FutureBuilder<UserProfileResponse>(
                                        future: AuthServices.getUserProfileById(
                                            userId: users.first),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                                  ConnectionState.done &&
                                              snapshot.data!.userdata != null) {
                                            var userData =
                                                snapshot.data!.userdata;
                                            if (userData!.name!
                                                .toLowerCase()
                                                .contains(_
                                                    .searchEditingController
                                                    .text
                                                    .toLowerCase())) {
                                              return ChatItem(
                                                chatId: chatListSnapshot.id,
                                                name: userData!.name ?? "",
                                                onTap: () => Get.to(() =>
                                                    ChatScreen(
                                                        userName:
                                                            userData.name ?? "",
                                                        chatId:
                                                            chatListSnapshot.id,
                                                        userId: users.first,
                                                        profilePic: userData
                                                                .profilePic ??
                                                            "")),
                                                size: size,
                                                profilePicUrl:
                                                    "${userData.profilePic}",
                                                messageCount: messages.length,
                                                message: message.data ?? "",
                                                type: message.type ?? "",
                                                time: timeago.format(
                                                    message.insertedAt!
                                                        .toDate(),
                                                    locale: 'en_short'),
                                              );
                                            } else {
                                              return const SizedBox.shrink();
                                            }
                                          } else {
                                            return ListTile(
                                              title: const Text("Loading... "),
                                              subtitle:
                                                  const Text("Loading..."),
                                              leading: CircleAvatar(
                                                  radius: size.width * .075,
                                                  child:
                                                      const CupertinoActivityIndicator(
                                                    color: Colors.black,
                                                  )),
                                            );
                                          }
                                        },
                                      );
                                    } else {
                                      return const SizedBox();
                                    }
                                  },
                                );
                              });
                        } else {
                          return const Center(child: Text('No Chats'));
                        }
                      } else {
                        return const Center(
                            child: CupertinoActivityIndicator());
                      }
                    },
                  ),
                ),
        ),
      ),
    );
  }
}
