// ignore_for_file: must_be_immutable

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/Material.dart';
import 'package:scrapingdart/utils/styles.dart';

class CustomDropDown extends StatefulWidget {
  Size size;
  Color iconColor;
  Color bgColor;

  final List<MenuItem> menuItems;

  CustomDropDown({
    Key? key,
    required this.size,
    required this.bgColor,
    required this.menuItems,
    required this.iconColor,
  }) : super(key: key);

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: Icon(
          Icons.more_vert_rounded,
          color: widget.iconColor,
        ),
        customItemsHeights: [
          ...List<double>.filled(widget.menuItems.length, 48),
        ],
        items: [
          ...widget.menuItems.map(
            (item) => DropdownMenuItem<MenuItem>(
              value: item,
              child: Row(
                children: [
                  Icon(item.icon, color: item.iconColor, size: 22),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    item.text,
                    style: textStyle(color: item.textColor, fontSize: 14,fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
        onChanged: (value) {
          value!.onPressed();
        },
        itemHeight: 48,
        itemPadding: const EdgeInsets.only(left: 16, right: 16),
        dropdownWidth: 160,
        dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: widget.bgColor,
        ),
        dropdownElevation: 8,
        offset: const Offset(0, 8),
      ),
    );
  }
}

class MenuItem {
  final String text;
  final IconData icon;
  final Color iconColor, textColor;
  final VoidCallback onPressed;

  const MenuItem({
    required this.text,
    required this.iconColor,
    required this.textColor,
    required this.onPressed,
    required this.icon,
  });
}
