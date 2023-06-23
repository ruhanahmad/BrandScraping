import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/Material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scrapingdart/utils/helpers.dart';


import '../../../utils/firebase.dart';
import '../../../utils/palette.dart';
import '../../../utils/static_data.dart';

class ChatItem extends StatelessWidget {
  final VoidCallback onTap;
  final Size size;
  final String profilePicUrl;
  final String name;
  final String time;
  final String type;
  final String chatId;
  final String message;
  final int messageCount;

  const ChatItem(
      {Key? key,
      required this.onTap,
      required this.message,
      required this.size,
      required this.type,
        required this.chatId,
      required this.profilePicUrl,
      required this.name,
      required this.time,
      required this.messageCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        radius: size.width * .075,
        backgroundImage: Image.network(
          profilePicUrl,
        ).image,
      ),
      title: Text(
        name,
        style: GoogleFonts.dmSans(
            color: Palette.color_150B3D, fontWeight: FontWeight.w700),
      ),
      subtitle: type == StaticData.TEXT
          ? Text(decrypt(message))
          : Row(
              children: [
                Icon(
                  type == StaticData.PDF
                      ? FontAwesomeIcons.solidFilePdf
                      : FontAwesomeIcons.image,
                  color:                  type == StaticData.PDF

                      ? Palette.color_E5252A
                      : Palette.primaryColor,
                  size: size.width * .05,
                ),
              ],
            ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            time,
            style: GoogleFonts.dmSans(color: Palette.color_AAA6B9),
          ),
          SizedBox(
            height: size.width * .02,
          ),
          buildCounter(context),
        ],
      ),
    );
  }

  buildCounter(BuildContext context) {
    return StreamBuilder(
      stream: messageBodyStream(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          DocumentSnapshot snap = snapshot.data;
          Map usersReads ={}
          ;
          try {
            usersReads = snap.get('reads') ?? {};
          }
          catch(e)
        {
          usersReads={};
        }

          int readCount = usersReads[StaticData.loggedInUserId.toString()] ?? 0;
          int counter = messageCount - readCount;
          if (counter == 0) {
            return const SizedBox();
          } else {
            return CircleAvatar(
              backgroundColor: Palette.color_40A7AE,
              radius: size.width * .0275,
              child:
             Text(
              "$counter",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
              ),
              textAlign: TextAlign.center,
            ));
          }
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Stream<DocumentSnapshot> messageBodyStream() {
    return chatRef.doc(chatId).snapshots();
  }
}
