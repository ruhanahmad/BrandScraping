// // ignore_for_file: must_be_immutable
//
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/Material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:time_mason_app/utils/palette.dart';
//
// import '../user_profile_screen/widgets/profile_more_doropdown_button.dart';
//
// class FileSaveDropDown extends StatefulWidget {
//   Size size;
//   VoidCallback onPressed;
//   Color color;
//
//   FileSaveDropDown(
//       {Key? key,
//         required this.size,
//         required this.color,
//         required this.onPressed})
//       : super(key: key);
//
//   @override
//   State<FileSaveDropDown> createState() =>
//       _FileSaveDropDownState();
// }
//
// class _FileSaveDropDownState extends State<FileSaveDropDown> {
//   @override
//   Widget build(BuildContext context) {
//     return DropdownButtonHideUnderline(
//       child: DropdownButton2(
//         customButton: Icon(
//           Icons.more_vert_rounded,
//           color: widget.color,
//         ),
//         customItemsHeights: [
//           ...List<double>.filled(MenuItems.firstItems.length, 48),
//         ],
//         items: [
//           ...MenuItems.firstItems.map(
//                 (item) => DropdownMenuItem<MenuItem>(
//               value: item,
//               child: MenuItems.buildItem(item),
//             ),
//           ),
//         ],
//         onChanged: (value) {
//           var val = value as MenuItem;
//           switch (val) {
//             case MenuItems.edit:
//               widget.onPressed();
//               break;
//           }
//         },
//         itemHeight: 48,
//         itemPadding: const EdgeInsets.only(left: 16, right: 16),
//         dropdownWidth: 160,
//         dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
//         dropdownDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(4),
//           color: Palette.primaryColor,
//         ),
//         dropdownElevation: 8,
//         offset: const Offset(0, 8),
//       ),
//     );
//   }
// }
//
//
// class MenuItems {
//   static const List<MenuItem> firstItems = [edit];
//
//   static const edit = MenuItem(
//     text: 'Save to downloads',
//     icon: Icons.save_alt_rounded,
//   );
//
//   static Widget buildItem(MenuItem item) {
//     return Row(
//       children: [
//         Icon(item.icon, color: Colors.white, size: 22),
//         const SizedBox(
//           width: 10,
//         ),
//         Text(
//           item.text,
//           style:  GoogleFonts.dmSans (
//             color: Colors.white,
//             fontSize: 10
//
//
//           ),
//         ),
//       ],
//     );
//   }
// }
