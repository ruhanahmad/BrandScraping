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
import '../../models/message_model.dart';

import '../../utils/palette.dart';
import '../../utils/static_data.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'chat_screen.dart';

class InboxScreen extends StatelessWidget {
  InboxScreen({Key? key}) : super(key: key);
  final ChatService _chatService = ChatService();

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
                  padding: const EdgeInsets.only(
                      left: 20, top: 20, right: 20, bottom: 20),
                  child: Text(
                    "Inbox",
                    style: GoogleFonts.dmSans(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
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
                    stream: _chatService.adminsList(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List adminsList = snapshot.data!.docs;
                        if (adminsList.isNotEmpty) {
                          return ListView.builder(
                              itemCount: adminsList.length,
                              itemBuilder: (context, index) {

                                return ChatItem(
                                    chatId: "asdf",
                                    name: "${adminsList[index]['name']}",
                                    onTap: () => Get.to(() => ChatScreen(
                                        userName: adminsList[index]['name'],
                                        chatId: "${adminsList[index].id}${FirebaseAuth.instance.currentUser!.email }",
                                        userId: adminsList[index]["email"],
                                        profilePic: adminsList[index]
                                            ['image'])),
                                    size: size,
                                    profilePicUrl: adminsList[index]['image'],
                                    messageCount: 0,
                                    message: "",
                                    type: "",
                                    time: "");
                                // thek hay ? yahan tak smjh aai ?
                                // hm ny 2 admins ko get kr k show krva dia agr vaha 3 hngy to 3 show hngy
// ye dop k liye nai bnai mene logic yaha jitne bhi honge atayjayn gay
// ha jtny add kry gy sahe i got your point <3 Bas zyada pyar nai karna
// haha acha thra krna ? chalein thora sa kar lein hehe ab next jo hay inki ids set karni hain
                                DocumentSnapshot chatListSnapshot =
                                    adminsList[index];
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
