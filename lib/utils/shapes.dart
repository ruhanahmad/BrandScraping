import 'package:flutter/Material.dart';

class Shapes {

 static ShapeBorder materialButtonShape({double? radius}) {
    return  RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius??10)));
  }
}
