import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_marker/marker_icon.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' as loc;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:scrapingdart/AuthFirebase/auth.dart';
import 'package:scrapingdart/breakout.dart';
import 'package:uuid/uuid.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:location_geocoder/location_geocoder.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
class BreakOutMap extends StatefulWidget {

  final String? name;
    BreakOutMap({Key? key, required this.name}) : super(key: key);

  @override
  State<BreakOutMap> createState() => _BreakOutMapState();
}



class _BreakOutMapState extends State<BreakOutMap> {

   GoogleMapController? mapController;
  loc.LocationData? currentLocation;
     Set<Polygon> _polygons = Set<Polygon>();
    Set<Polyline> _polyline = Set<Polyline>();
      List<LatLng> polygonsLatLng = <LatLng>[];
        int _polygonCounter = 1;
    int _polylineCounter = 1;
   void getLocation() async {
    var location = loc.Location();
    try {
      currentLocation = await location.getLocation();
    } on Exception catch (e) {
      print('Error: $e');
    }
  }
        void setPolygon()async {
final  polygonIdVal = "polygon_$_polygonCounter";
_polygonCounter ++;

 Polygon(
  polygonId: PolygonId(polygonIdVal),
  points: polygonsLatLng,
  strokeWidth: 2,
  fillColor: Colors.blue
 
 );
    }

    
    void setPolyline(List<PointLatLng> points)async {
final String  polylineIdVal = "polygon_$_polylineCounter";
_polylineCounter ++;

_polyline.add( Polyline(
  polylineId: PolylineId(polylineIdVal),
 
 width: 2,
 color: Colors.blue,
 points: points.map((e) => LatLng(e.latitude, e.longitude)).toList(),
 
 ));

    }

    
     AuthService authService = Get.put(AuthService());
  StreamSubscription<QuerySnapshot>? _subscription;
     String session = "1212";
     var uuid = Uuid();
   
 TextEditingController textEditingController = TextEditingController();
 List<dynamic> _placesList = [];



 List<Marker> _markerNishatLinen = [];
 late  List<Marker> NishatLinenMarkers = [
     Marker(markerId: MarkerId("56")
   ,
   position:LatLng(33.72095825061273, 73.05682699758125),
 infoWindow: InfoWindow(
    title: "Nishat Linen",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
     Marker(markerId: MarkerId("57")
   ,
   position:LatLng(33.698149809685816, 73.00584683268212),
   infoWindow: InfoWindow(
    title: "Nishat Linen",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
     Marker(markerId: MarkerId("58")
   ,
   position:LatLng(33.69529969586, 73.02876593099579),
   infoWindow: InfoWindow(
    title: "Nishat Linen",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
     Marker(markerId: MarkerId("59")
   ,
   position:LatLng(33.521375719256454, 73.08599821437737),
    infoWindow: InfoWindow(
    title: "Nishat Linen",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
     Marker(markerId: MarkerId("60")
   ,
   position:LatLng(33.712715859467714, 73.04922802117486),
   infoWindow: InfoWindow(
    title: "Nishat Linen",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
     Marker(markerId: MarkerId("61")
   ,
   position:LatLng(33.631688360599156, 72.96244213985817),
   infoWindow: InfoWindow(
    title: "Nishat Linen",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
     Marker(markerId: MarkerId("62")
   ,
   position:LatLng(33.52902733558037, 73.14643271683084),
   infoWindow: InfoWindow(
    title: "Nishat Linen",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
     Marker(markerId: MarkerId("63")
   ,
   position:LatLng(33.57956897780408, 73.15164358403331),
    infoWindow: InfoWindow(
    title: "Nishat Linen",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
     Marker(markerId: MarkerId("64")
   ,
   position:LatLng(33.55429799894469, 73.12176833208886),
   infoWindow: InfoWindow(
    title: "Nishat Linen",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
     Marker(markerId: MarkerId("65")
   ,
   position:LatLng(33.57728071915494, 73.13647590662603),
   infoWindow: InfoWindow(
    title: "Nishat Linen",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
  ];






//==========================================================================================================//

 List<Marker> _markerAlkaramStudio = [];
 late  List<Marker> AlkaramStudioMarkers = [
     Marker(markerId: MarkerId("10")
   ,
   position:LatLng(33.70500477441406, 73.0041714508303),
  infoWindow: InfoWindow(
    title: "Alkaram",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
  Marker(markerId: MarkerId("11")
   ,
   position:LatLng(33.52673773780162, 73.16016562608995),
  infoWindow: InfoWindow(
    title: "Alkaram",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
   Marker(markerId: MarkerId("12")
   ,
   position:LatLng(33.705861510138746, 73.04607578932301),
  infoWindow: InfoWindow(
    title: "Alkaram",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
   Marker(markerId: MarkerId("13")
   ,
   position:LatLng(33.584145313092556, 73.14232738847784),
  infoWindow: InfoWindow(
    title: "Alkaram",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
   Marker(markerId: MarkerId("14")
   ,
   position:LatLng(33.60509091129415, 73.05126044907195),
  infoWindow: InfoWindow(
    title: "Alkaram",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
  ];





 
//======================================================================================//



 List<Marker> _markerSapphire = [];
 late  List<Marker> SapphireMarkers = [
      Marker(markerId: MarkerId("23")
   ,
   position:LatLng(33.51528883961855, 73.15192588053449),
   infoWindow: InfoWindow(
    title: "Sapphire",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
    Marker(markerId: MarkerId("24")
   ,
   position:LatLng(33.70357660546378, 73.054798634878),
 infoWindow: InfoWindow(
    title: "Sapphire",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
    Marker(markerId: MarkerId("25")
   ,
   position:LatLng(33.56126121004355, 73.13829452032964),
 infoWindow: InfoWindow(
    title: "Sapphire",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
    Marker(markerId: MarkerId("26")
   ,
   position:LatLng(33.534964797779836, 73.16430155643482),
 infoWindow: InfoWindow(
    title: "Sapphire",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
    Marker(markerId: MarkerId("27")
   ,
   position:LatLng(33.52309744318231, 73.157920959096),
 infoWindow: InfoWindow(
    title: "Sapphire",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
  ];






//=================================================================================================//


List<Marker> _markerMariaB = [];
 late  List<Marker> MariaBMarkers = [
    Marker(markerId: MarkerId("41")
   ,
   position:LatLng(33.69680632702146, 73.01392010211958),
   infoWindow: InfoWindow(
    title: "MariaB",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
    Marker(markerId: MarkerId("42")
   ,
   position:LatLng(33.6859716724306, 73.04719585635065),
    infoWindow: InfoWindow(
    title: "MariaB",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
    Marker(markerId: MarkerId("43")
   ,
   position:LatLng(33.72047497519845, 73.05460415733175),
   infoWindow: InfoWindow(
    title: "MariaB",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
    Marker(markerId: MarkerId("44")
   ,
   position:LatLng(33.707599530671665, 73.05083100247165),
    infoWindow: InfoWindow(
    title: "MariaB",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
    Marker(markerId: MarkerId("45")
   ,
   position:LatLng(33.593810760304954, 73.05546687658894),
  infoWindow: InfoWindow(
    title: "MariaB",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
  
  ];






//==========================================================================================================//


List<Marker> _markerOutfitters = [];
 late  List<Marker> OutfittersMarkers = [
     Marker(markerId: MarkerId("71")
   ,
   position:LatLng(33.689734805862386, 73.03108497795836),
  infoWindow: InfoWindow(
    title: "OutFitters",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
   
    Marker(markerId: MarkerId("72")
   ,
   position:LatLng(33.72061883267114, 73.05011279696849),
  infoWindow: InfoWindow(
    title: "OutFitters",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
   
    Marker(markerId: MarkerId("73")
   ,
   position:LatLng(33.72061883267114, 73.05467620608883),
  infoWindow: InfoWindow(
    title: "OutFitters",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
    Marker(markerId: MarkerId("74")
   ,
   position:LatLng(33.69530390249251, 73.01387230121422),
infoWindow: InfoWindow(
    title: "OutFitters",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
   
    Marker(markerId: MarkerId("75")
   ,
   position:LatLng(33.57286747208786, 73.14712646422798),
  infoWindow: InfoWindow(
    title: "OutFitters",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
   
    Marker(markerId: MarkerId("76")
   ,
   position:LatLng(33.68371697248938, 72.9893293190847),
  infoWindow: InfoWindow(
    title: "OutFitters",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
   
    Marker(markerId: MarkerId("77")
   ,
   position:LatLng(33.722903283914086, 73.05114276516292),
   infoWindow: InfoWindow(
    title: "OutFitters"
   )
   ),
   
    Marker(markerId: MarkerId("78")
   ,
   position:LatLng(33.64684525504162, 73.05985005110888),
  infoWindow: InfoWindow(
    title: "OutFitters",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
   
    Marker(markerId: MarkerId("79")
   ,
   position:LatLng(33.52224590308265, 73.14928819542004),
  infoWindow: InfoWindow(
    title: "OutFitters",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
   
    Marker(markerId: MarkerId("80")
   ,
   position:LatLng(33.70795343692952, 73.04901871898291),
  infoWindow: InfoWindow(
    title: "OutFitters",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
     Marker(markerId: MarkerId("81")
   ,
   position:LatLng(33.721710479204155, 73.05501952874818),
  infoWindow: InfoWindow(
    title: "OutFitters",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
     
   ),
   ),
  
  ];








//============================================================================================================//

List<Marker> _markerJ = [];
 late  List<Marker> JMarkers = [
  Marker(markerId: MarkerId("15")
   ,
   position:LatLng(33.734511818067126, 73.0705599162584),
  infoWindow: InfoWindow(
    title: "J.",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
     Marker(markerId: MarkerId("16")
   ,
   position:LatLng(33.52996634379518, 73.15242779539236),
    infoWindow: InfoWindow(
    title: "J.",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
     Marker(markerId: MarkerId("17")
   ,
   position:LatLng(33.712715859467714, 73.05156895302666),
    infoWindow: InfoWindow(
    title: "J.",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
     Marker(markerId: MarkerId("18")
   ,
   position:LatLng(33.69129429798703, 73.01549777823759),
    infoWindow: InfoWindow(
    title: "J.",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
     Marker(markerId: MarkerId("19")
   ,
   position:LatLng(33.5727040198571, 73.1342795929224),
   infoWindow: InfoWindow(
    title: "J.",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
     Marker(markerId: MarkerId("20")
   ,
   position:LatLng(33.58874973396603, 73.04576728467305),
   infoWindow: InfoWindow(
    title: "J.",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
     Marker(markerId: MarkerId("21")
   ,
   position:LatLng(33.72926274568537, 73.05132721395321),
    infoWindow: InfoWindow(
    title: "J.",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
     Marker(markerId: MarkerId("22")
   ,
   position:LatLng(33.64355785144285, 73.0752963441804),
   infoWindow: InfoWindow(
    title: "J.",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
  
  ];






//================================================================================================================//
List<Marker> _markerGulAhmad = [];
 late  List<Marker> GulAhmadMarkers = [
 Marker(markerId: MarkerId("51")
   ,
   position:LatLng(33.55243672083769, 73.13000807855344),
  infoWindow: InfoWindow(
    title: "GulAhmad",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
    Marker(markerId: MarkerId("51")
   ,
   position:LatLng(33.72518387934276, 73.0624993335724),
   infoWindow: InfoWindow(
    title: "GulAhmad",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
    Marker(markerId: MarkerId("52")
   ,
   position:LatLng(33.698149809685816, 73.00861726453392),
   infoWindow: InfoWindow(
    title: "GulAhmad",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
    Marker(markerId: MarkerId("53")
   ,
   position:LatLng(33.5727040198571, 73.14261033847785),
infoWindow: InfoWindow(
    title: "GulAhmad",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
    Marker(markerId: MarkerId("54")
   ,
   position:LatLng(33.52595513811761, 73.08638846437735),
  infoWindow: InfoWindow(
    title: "GulAhmad",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
    Marker(markerId: MarkerId("55")
   ,
   position:LatLng(33.63669798725261, 73.07075209862492),
   infoWindow: InfoWindow(
    title: "GulAhmad",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
  ];




//=========================================================================================================//

List<Marker> _markerLimeLight = [];
 late  List<Marker> LimeLightMarkers = [
   Marker(markerId: MarkerId("28")
   ,
   position:LatLng(33.71784072778411, 73.05956695950867),
   infoWindow: InfoWindow(
    title: "LimeLight",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
    Marker(markerId: MarkerId("29")
   ,
   position:LatLng(33.69129429798703, 73.00703578268212),
     infoWindow: InfoWindow(
    title: "LimeLight",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
    Marker(markerId: MarkerId("30")
   ,
   position:LatLng(33.70586151013877, 73.03802044376755),
  infoWindow: InfoWindow(
    title: "LimeLight",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
    Marker(markerId: MarkerId("31")
   ,
   position:LatLng(33.58643338972781, 73.14251933847787),
     infoWindow: InfoWindow(
    title: "LimeLight",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
  ];


//==========================================================================================================//






List<Marker> _markerBonanza = [];
 late  List<Marker> BonanzaMarkers = [
    Marker(markerId: MarkerId("82")
   ,
   position:LatLng(33.694161317348474, 73.0147733830198),
    infoWindow: InfoWindow(
    title: "Bonanza",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
     Marker(markerId: MarkerId("83")
   ,
   position:LatLng(33.521544489984876, 73.15581132731457),
infoWindow: InfoWindow(
    title: "Bonanza",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
     Marker(markerId: MarkerId("84")
   ,
   position:LatLng(33.707425382536215, 73.04827995121407),
  infoWindow: InfoWindow(
    title: "Bonanza",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
   

     Marker(markerId: MarkerId("85")
   ,
   position:LatLng(33.720282684461836, 73.05501952874818),
infoWindow: InfoWindow(
    title: "Bonanza",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
     Marker(markerId: MarkerId("86")
   ,
   position:LatLng(33.52193031227467, 73.09342340852945),
  infoWindow: InfoWindow(
    title: "Bonanza",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
     Marker(markerId: MarkerId("87")
   ,
   position:LatLng(33.52193031227467, 73.09342340852945),
 infoWindow: InfoWindow(
    title: "Bonanza",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
     Marker(markerId: MarkerId("88")
   ,
   position:LatLng(33.70704975147965, 73.0869256152547),
  infoWindow: InfoWindow(
    title: "Bonanza",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
     Marker(markerId: MarkerId("89")
   ,
   position:LatLng(33.63898466937216, 73.0752963441804),
   infoWindow: InfoWindow(
    title: "Bonanza",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
      Marker(markerId: MarkerId("90")
   ,
   position:LatLng(33.72994347274675, 73.07879966181389),
   infoWindow: InfoWindow(
    title: "Bonanza",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
  ];




List<Marker> _markerSaya = [];
 late  List<Marker> SayaMarkers = [
    Marker(markerId: MarkerId("66")
   ,
   position:LatLng(33.69520000852347, 73.01385097936746),
   infoWindow: InfoWindow(
    title: "Saya",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
     Marker(markerId: MarkerId("67")
   ,
   position:LatLng(33.70781023817602, 73.04987460245385),
   infoWindow: InfoWindow(
    title: "Saya",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
     Marker(markerId: MarkerId("68")
   ,
   position:LatLng(33.522300282105896, 73.15888474279112),
    infoWindow: InfoWindow(
    title: "Saya",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
     Marker(markerId: MarkerId("69")
   ,
   position:LatLng(33.5759389671938, 73.14967415333567),
 infoWindow: InfoWindow(
    title: "Saya",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
     Marker(markerId: MarkerId("70")
   ,
   position:LatLng(33.721020333172085, 73.05555980280185),
    infoWindow: InfoWindow(
    title: "Saya",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
  ];
  
List<Marker> _markerBreakout = [];
 late  List<Marker> BreakoutMarkers = [
    Marker(markerId: MarkerId("1")
   ,
   position:LatLng(33.723719220938165, 73.05977408878096),
  infoWindow: InfoWindow(
    title: "Breakout",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
   Marker(markerId: MarkerId("2")
   ,
   position:LatLng(33.70500477441406, 72.99679038712664),
   infoWindow: InfoWindow(
    title: "Breakout",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
   Marker(markerId: MarkerId("3")
   ,
   position:LatLng(33.71500052100535, 73.0547177348785),
   infoWindow: InfoWindow(
    title: "Breakout",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
   Marker(markerId: MarkerId("4")
   ,
   position:LatLng(33.55200907050392, 73.11627516838523),
   infoWindow: InfoWindow(
    title: "Breakout",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
   Marker(markerId: MarkerId("5")
   ,
   position:LatLng(33.52215836038009, 73.14917929868267),
   infoWindow: InfoWindow(
    title: "Breakout",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
   Marker(markerId: MarkerId("6")
   ,
   position:LatLng(33.5727040198571, 73.15074498403332),
   infoWindow: InfoWindow(
    title: "Breakout"
   )
   ),
   Marker(markerId: MarkerId("7")
   ,
   position:LatLng(33.648130790608796, 73.06980318047677),
   infoWindow: InfoWindow(
    title: "Breakout",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),

Marker(markerId: MarkerId("8")
   ,
   position:LatLng(33.593079475989356, 73.05126044785312),
   infoWindow: InfoWindow(
    title: "Breakout",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
  ];
  
List<Marker> _markerKhadi = [];
 late  List<Marker> KhadiMarkers = [
     Marker(markerId: MarkerId("1")
   ,
   position:LatLng(33.71818836285185, 73.05407379654625),
    infoWindow: InfoWindow(
    title: "Khadi",
     snippet: "Discount",
        onTap: () {
          
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
    Marker(markerId: MarkerId("2")
   ,
   position:LatLng(33.55930329022497, 73.13550124225708),
    infoWindow: InfoWindow(
    title: "Khadi",
     snippet: "Discount",
        onTap: () {
         
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
   
    Marker(markerId: MarkerId("3")
   ,
   position:LatLng(33.5727040198571, 73.12796027477422),
    infoWindow: InfoWindow(
    title: "Khadi",
     snippet: "Discount",
        onTap: () {
          // hgya 
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
    Marker(markerId: MarkerId("4")
   ,
   position:LatLng(33.51757874048688, 73.14643271683084),
    infoWindow: InfoWindow(
    title: "Khadi",
     snippet: "Discount",
        onTap: () {
          // hgya 
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
    Marker(markerId: MarkerId("5")
   ,
   position:LatLng(33.707289641098384, 73.0027844508303),
    infoWindow: InfoWindow(
    title: "Khadi",
     snippet: "Discount",
        onTap: () {
          // hgya 
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
    Marker(markerId: MarkerId("6")
   ,
   position:LatLng(33.72832338106523, 73.0415192115236),
    infoWindow: InfoWindow(
    title: "Khadi",
     snippet: "Discount",
        onTap: () {
          // hgya 
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
    Marker(markerId: MarkerId("7")
   ,
   position:LatLng(33.571763210039684, 73.15637661388439),
    infoWindow: InfoWindow(
    title: "Khadi",
     snippet: "Discount",
        onTap: () {
          // hgya 
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
    Marker(markerId: MarkerId("8")
   ,
   position:LatLng(33.65041716909746, 73.07804292603223),
    infoWindow: InfoWindow(
    title: "Khadi",
     snippet: "Discount",
        onTap: () {
          // hgya 
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
    Marker(markerId: MarkerId("9")
   ,
   position:LatLng(33.60290320623483, 73.04851386743262),
    infoWindow: InfoWindow(
    title: "Khadi",
     snippet: "Discount",
        onTap: () {
          // hgya 
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),

    Marker(markerId: MarkerId("10")
   ,
   position:LatLng(33.73281490362029, 73.08154624491806),
    infoWindow: InfoWindow(
    title: "Khadi",
     snippet: "Discount",
        onTap: () {
          // hgya 
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
  ];
              
              Future<Map<String,dynamic>> getDirections()async {
              
               
      
 String url =
        'https://maps.googleapis.com/maps/api/directions/json' +
            '?origin=islamabad' +
            '&destination=lahore' +
            '&key=AIzaSyCZJDq4ZZiah_srzkzjQDtxnXVE-gbf85M';
            var response = await http.get(Uri.parse(url));
            var jason = jsonDecode(response.body);
            print(jason);
            var results = {
               'bounds_ne':jason["routes"][0]['bounds']['northeast'],
               'bounds_sw':jason["routes"][0]['bounds']['southwest'],

               'start_location':jason["routes"][0]['legs'][0]['start_location'],
               'end_location':jason["routes"][0]['legs'][0]['end_location'],
               'polyline':jason["routes"][0]['overview_polyline']['points'],
               'polyline_decoded':PolylinePoints().decodePolyline(jason["routes"][0]['overview_polyline']['points']),

            };
             print(results);
            return results;
              }
               void navigateToMarker(double latitude, double longitude) async {
    final String googleMapsUrl = 'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude';
    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw 'Could not launch $googleMapsUrl';
    }
  }
  //================================================//
  List<Marker> _markerSanaSafinaz = [];
   LatLng markerPosition = LatLng(33.694800463538506, 73.0132787339014);
 late  List<Marker> sanaSafinazMarkers = [
  
     Marker(markerId: MarkerId("1")
   ,
   position:markerPosition,
   infoWindow: InfoWindow(
    title: "Sana Safinaz",
     snippet: "Discounts",
        onTap: () async{
           navigateToMarker(markerPosition.latitude, markerPosition.longitude);
            //  var directions =       await  getDirections();
            //   setPolyline(directions["polyline_decoded"]);
                      // Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   
   ),

   Marker(markerId: MarkerId("2")
   ,
   position:LatLng(33.72080697344674, 73.05496928007238),
   infoWindow: InfoWindow(
    title: "Sana Safinaz",
     snippet: "Discount",
        onTap: () {
          // hgya 
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
   Marker(markerId: MarkerId("3")
   ,
   position:LatLng(33.543265089276474, 73.12483611836817),
   infoWindow: InfoWindow(
    title: "Sana Safinaz",
     snippet: "Discount",
        onTap: () {
          // hgya 
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
   Marker(markerId: MarkerId("4")
   ,
   position:LatLng(33.52309744318231, 73.15242779539236),
   infoWindow: InfoWindow(
    title: "Sana Safinaz",
     snippet: "Discount",
        onTap: () {
          // hgya 
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
   Marker(markerId: MarkerId("5")
   ,
   position:LatLng(33.708146354032415, 73.04607578932301),
  infoWindow: InfoWindow(
    title: "Sana Safinaz",
     snippet: "Discount",
        onTap: () {
          // hgya 
                      Get.to(CardProductWrapperList(name:widget.name));// es py

 
        },
    
   ),
   ),
  ];
  List<Marker> _marker = [];
  List<Marker> 
  heyMarker = [
   Marker(markerId: MarkerId("1")
   ,
   position:LatLng(31.3936163,73.0209934),
   infoWindow: InfoWindow(
    title: "Current position"
   )
   ),
    Marker(markerId: MarkerId("2")
   ,
   position:LatLng(33.723719220938165, 73.05977408878096),
   infoWindow: InfoWindow(
    title: "Breakout"
   )
   ),
   Marker(markerId: MarkerId("3")
   ,
   position:LatLng(33.70500477441406, 72.99679038712664),
   infoWindow: InfoWindow(
    title: "Breakout"
   )
   ),
   Marker(markerId: MarkerId("4")
   ,
   position:LatLng(33.71500052100535, 73.0547177348785),
   infoWindow: InfoWindow(
    title: "Breakout"
   )
   ),
   Marker(markerId: MarkerId("5")
   ,
   position:LatLng(33.55200907050392, 73.11627516838523),
   infoWindow: InfoWindow(
    title: "Breakout"
   )
   ),
   Marker(markerId: MarkerId("6")
   ,
   position:LatLng(33.52215836038009, 73.14917929868267),
   infoWindow: InfoWindow(
    title: "Breakout"
   )
   ),
   Marker(markerId: MarkerId("7")
   ,
   position:LatLng(33.5727040198571, 73.15074498403332),
   infoWindow: InfoWindow(
    title: "Breakout"
   )
   ),
   Marker(markerId: MarkerId("8")
   ,
   position:LatLng(33.648130790608796, 73.06980318047677),
   infoWindow: InfoWindow(
    title: "Breakout"
   )
   ),

Marker(markerId: MarkerId("9")
   ,
   position:LatLng(33.593079475989356, 73.05126044785312),
   infoWindow: InfoWindow(
    title: "Breakout"
   )
   ),
   Marker(markerId: MarkerId("10")
   ,
   position:LatLng(33.70500477441406, 73.0041714508303),
   infoWindow: InfoWindow(
    title: "Alkaram"
   )
   ),
  Marker(markerId: MarkerId("11")
   ,
   position:LatLng(33.52673773780162, 73.16016562608995),
   infoWindow: InfoWindow(
    title: "Alkaram"
   )
   ),
   Marker(markerId: MarkerId("12")
   ,
   position:LatLng(33.705861510138746, 73.04607578932301),
   infoWindow: InfoWindow(
    title: "Alkaram"
   )
   ),
   Marker(markerId: MarkerId("13")
   ,
   position:LatLng(33.584145313092556, 73.14232738847784),
   infoWindow: InfoWindow(
    title: "Alkaram"
   )
   ),
   Marker(markerId: MarkerId("14")
   ,
   position:LatLng(33.60509091129415, 73.05126044907195),
   infoWindow: InfoWindow(
    title: "Alkaram"
   )
   ),
   Marker(markerId: MarkerId("15")
   ,
   position:LatLng(33.734511818067126, 73.0705599162584),
   infoWindow: InfoWindow(
    title: "J."
   )
   ),
     Marker(markerId: MarkerId("16")
   ,
   position:LatLng(33.52996634379518, 73.15242779539236),
   infoWindow: InfoWindow(
    title: "J."
   )
   ),
     Marker(markerId: MarkerId("17")
   ,
   position:LatLng(33.712715859467714, 73.05156895302666),
   infoWindow: InfoWindow(
    title: "J."
   )
   ),
     Marker(markerId: MarkerId("18")
   ,
   position:LatLng(33.69129429798703, 73.01549777823759),
   infoWindow: InfoWindow(
    title: "J."
   )
   ),
     Marker(markerId: MarkerId("19")
   ,
   position:LatLng(33.5727040198571, 73.1342795929224),
   infoWindow: InfoWindow(
    title: "J."
   )
   ),
     Marker(markerId: MarkerId("20")
   ,
   position:LatLng(33.58874973396603, 73.04576728467305),
   infoWindow: InfoWindow(
    title: "J."
   )
   ),
     Marker(markerId: MarkerId("21")
   ,
   position:LatLng(33.72926274568537, 73.05132721395321),
   infoWindow: InfoWindow(
    title: "J."
   )
   ),
     Marker(markerId: MarkerId("22")
   ,
   position:LatLng(33.64355785144285, 73.0752963441804),
   infoWindow: InfoWindow(
    title: "J."
   )
   ),
  
     Marker(markerId: MarkerId("23")
   ,
   position:LatLng(33.51528883961855, 73.15192588053449),
   infoWindow: InfoWindow(
    title: "Sapphire"
   )
   ),
    Marker(markerId: MarkerId("24")
   ,
   position:LatLng(33.70357660546378, 73.054798634878),
   infoWindow: InfoWindow(
    title: "Sapphire"
   )
   ),
    Marker(markerId: MarkerId("25")
   ,
   position:LatLng(33.56126121004355, 73.13829452032964),
   infoWindow: InfoWindow(
    title: "Sapphire"
   )
   ),
    Marker(markerId: MarkerId("26")
   ,
   position:LatLng(33.534964797779836, 73.16430155643482),
   infoWindow: InfoWindow(
    title: "Sapphire"
   )
   ),
    Marker(markerId: MarkerId("27")
   ,
   position:LatLng(33.52309744318231, 73.157920959096),
   infoWindow: InfoWindow(
    title: "Sapphire"
   )
   ),

    Marker(markerId: MarkerId("28")
   ,
   position:LatLng(33.71784072778411, 73.05956695950867),
   infoWindow: InfoWindow(
    title: "Limelight"
   )
   ),
    Marker(markerId: MarkerId("29")
   ,
   position:LatLng(33.69129429798703, 73.00703578268212),
   infoWindow: InfoWindow(
    title: "Limelight"
   )
   ),
    Marker(markerId: MarkerId("30")
   ,
   position:LatLng(33.70586151013877, 73.03802044376755),
   infoWindow: InfoWindow(
    title: "Limelight"
   )
   ),
    Marker(markerId: MarkerId("31")
   ,
   position:LatLng(33.58643338972781, 73.14251933847787),
   infoWindow: InfoWindow(
    title: "Limelight"
   )
   ),
    Marker(markerId: MarkerId("31")
   ,
   position:LatLng(33.71818836285185, 73.05407379654625),
   infoWindow: InfoWindow(
    title: "Khaadi"
   )
   ),
    Marker(markerId: MarkerId("32")
   ,
   position:LatLng(33.55930329022497, 73.13550124225708),
   infoWindow: InfoWindow(
    title: "Khaadi"
   )
   ),
    Marker(markerId: MarkerId("33")
   ,
   position:LatLng(33.5727040198571, 73.12796027477422),
   infoWindow: InfoWindow(
    title: "Khaadi"
   )
   ),
    Marker(markerId: MarkerId("34")
   ,
   position:LatLng(33.51757874048688, 73.14643271683084),
   infoWindow: InfoWindow(
    title: "Khaadi"
   )
   ),
    Marker(markerId: MarkerId("35")
   ,
   position:LatLng(33.707289641098384, 73.0027844508303),
   infoWindow: InfoWindow(
    title: "Khaadi"
   )
   ),
    Marker(markerId: MarkerId("36")
   ,
   position:LatLng(33.72832338106523, 73.0415192115236),
   infoWindow: InfoWindow(
    title: "Khaadi"
   )
   ),
    Marker(markerId: MarkerId("37")
   ,
   position:LatLng(33.571763210039684, 73.15637661388439),
   infoWindow: InfoWindow(
    title: "Khaadi"
   )
   ),
    Marker(markerId: MarkerId("38")
   ,
   position:LatLng(33.65041716909746, 73.07804292603223),
   infoWindow: InfoWindow(
    title: "Khaadi"
   )
   ),
    Marker(markerId: MarkerId("39")
   ,
   position:LatLng(33.60290320623483, 73.04851386743262),
   infoWindow: InfoWindow(
    title: "Khaadi"
   )
   ),
    Marker(markerId: MarkerId("40")
   ,
   position:LatLng(33.73281490362029, 73.08154624491806),
   infoWindow: InfoWindow(
    title: "Khaadi"
   )
   ),
    Marker(markerId: MarkerId("41")
   ,
   position:LatLng(33.69680632702146, 73.01392010211958),
   infoWindow: InfoWindow(
    title: "Maria B"
   )
   ),
    Marker(markerId: MarkerId("42")
   ,
   position:LatLng(33.6859716724306, 73.04719585635065),
   infoWindow: InfoWindow(
    title: "Maria B"
   )
   ),
    Marker(markerId: MarkerId("43")
   ,
   position:LatLng(33.72047497519845, 73.05460415733175),
   infoWindow: InfoWindow(
    title: "Maria B"
   )
   ),
    Marker(markerId: MarkerId("44")
   ,
   position:LatLng(33.707599530671665, 73.05083100247165),
   infoWindow: InfoWindow(
    title: "Maria B"
   )
   ),
    Marker(markerId: MarkerId("45")
   ,
   position:LatLng(33.593810760304954, 73.05546687658894),
   infoWindow: InfoWindow(
    title: "Maria B"
   )
   ),
    Marker(markerId: MarkerId("46")
   ,
   position:LatLng(33.694800463538506, 73.0132787339014),
   infoWindow: InfoWindow(
    title: "Sana Safinaz",
    
   ),
   
   ),

   Marker(markerId: MarkerId("47")
   ,
   position:LatLng(33.72080697344674, 73.05496928007238),
   infoWindow: InfoWindow(
    title: "Sana Safinaz"
   )
   ),
   Marker(markerId: MarkerId("48")
   ,
   position:LatLng(33.543265089276474, 73.12483611836817),
   infoWindow: InfoWindow(
    title: "Sana Safinaz"
   )
   ),
   Marker(markerId: MarkerId("49")
   ,
   position:LatLng(33.52309744318231, 73.15242779539236),
   infoWindow: InfoWindow(
    title: "Sana Safinaz"
   )
   ),
   Marker(markerId: MarkerId("50")
   ,
   position:LatLng(33.708146354032415, 73.04607578932301),
   infoWindow: InfoWindow(
    title: "Sana Safinaz"
   )
   ),
    Marker(markerId: MarkerId("51")
   ,
   position:LatLng(33.55243672083769, 73.13000807855344),
   infoWindow: InfoWindow(
    title: "Gul Ahmed"
   )
   ),
    Marker(markerId: MarkerId("51")
   ,
   position:LatLng(33.72518387934276, 73.0624993335724),
   infoWindow: InfoWindow(
    title: "Gul Ahmed"
   )
   ),
    Marker(markerId: MarkerId("52")
   ,
   position:LatLng(33.698149809685816, 73.00861726453392),
   infoWindow: InfoWindow(
    title: "Gul Ahmed"
   )
   ),
    Marker(markerId: MarkerId("53")
   ,
   position:LatLng(33.5727040198571, 73.14261033847785),
   infoWindow: InfoWindow(
    title: "Gul Ahmed"
   )
   ),
    Marker(markerId: MarkerId("54")
   ,
   position:LatLng(33.52595513811761, 73.08638846437735),
   infoWindow: InfoWindow(
    title: "Gul Ahmed"
   )
   ),
    Marker(markerId: MarkerId("55")
   ,
   position:LatLng(33.63669798725261, 73.07075209862492),
   infoWindow: InfoWindow(
    title: "Gul Ahmed"
   )
   ),
    Marker(markerId: MarkerId("56")
   ,
   position:LatLng(33.72095825061273, 73.05682699758125),
   infoWindow: InfoWindow(
    title: "Nishat Linen"
   )
   ),
     Marker(markerId: MarkerId("57")
   ,
   position:LatLng(33.698149809685816, 73.00584683268212),
   infoWindow: InfoWindow(
    title: "Nishat Linen"
   )
   ),
     Marker(markerId: MarkerId("58")
   ,
   position:LatLng(33.69529969586, 73.02876593099579),
   infoWindow: InfoWindow(
    title: "Nishat Linen"
   )
   ),
     Marker(markerId: MarkerId("59")
   ,
   position:LatLng(33.521375719256454, 73.08599821437737),
   infoWindow: InfoWindow(
    title: "Nishat Linen"
   )
   ),
     Marker(markerId: MarkerId("60")
   ,
   position:LatLng(33.712715859467714, 73.04922802117486),
   infoWindow: InfoWindow(
    title: "Nishat Linen"
   )
   ),
     Marker(markerId: MarkerId("61")
   ,
   position:LatLng(33.631688360599156, 72.96244213985817),
   infoWindow: InfoWindow(
    title: "Nishat Linen"
   )
   ),
     Marker(markerId: MarkerId("62")
   ,
   position:LatLng(33.52902733558037, 73.14643271683084),
   infoWindow: InfoWindow(
    title: "Nishat Linen"
   )
   ),
     Marker(markerId: MarkerId("63")
   ,
   position:LatLng(33.57956897780408, 73.15164358403331),
   infoWindow: InfoWindow(
    title: "Nishat Linen"
   )
   ),
     Marker(markerId: MarkerId("64")
   ,
   position:LatLng(33.55429799894469, 73.12176833208886),
   infoWindow: InfoWindow(
    title: "Nishat Linen"
   )
   ),
     Marker(markerId: MarkerId("65")
   ,
   position:LatLng(33.57728071915494, 73.13647590662603),
   infoWindow: InfoWindow(
    title: "Nishat Linen"
   )
   ),
     Marker(markerId: MarkerId("66")
   ,
   position:LatLng(33.69520000852347, 73.01385097936746),
   infoWindow: InfoWindow(
    title: "Saya"
   )
   ),
     Marker(markerId: MarkerId("67")
   ,
   position:LatLng(33.70781023817602, 73.04987460245385),
   infoWindow: InfoWindow(
    title: "Saya"
   )
   ),
     Marker(markerId: MarkerId("68")
   ,
   position:LatLng(33.522300282105896, 73.15888474279112),
   infoWindow: InfoWindow(
    title: "Saya"
   )
   ),
     Marker(markerId: MarkerId("69")
   ,
   position:LatLng(33.5759389671938, 73.14967415333567),
   infoWindow: InfoWindow(
    title: "Saya"
   )
   ),
     Marker(markerId: MarkerId("70")
   ,
   position:LatLng(33.721020333172085, 73.05555980280185),
   infoWindow: InfoWindow(
    title: "Saya"
   )
   ),
   Marker(markerId: MarkerId("71")
   ,
   position:LatLng(33.689734805862386, 73.03108497795836),
   infoWindow: InfoWindow(
    title: "OutFitters"
   )
   ),
   
    Marker(markerId: MarkerId("72")
   ,
   position:LatLng(33.72061883267114, 73.05011279696849),
   infoWindow: InfoWindow(
    title: "OutFitters"
   )
   ),
   
    Marker(markerId: MarkerId("73")
   ,
   position:LatLng(33.72061883267114, 73.05467620608883),
   infoWindow: InfoWindow(
    title: "OutFitters"
   )
   ),
    Marker(markerId: MarkerId("74")
   ,
   position:LatLng(33.69530390249251, 73.01387230121422),
   infoWindow: InfoWindow(
    title: "OutFitters"
   )
   ),
   
    Marker(markerId: MarkerId("75")
   ,
   position:LatLng(33.57286747208786, 73.14712646422798),
   infoWindow: InfoWindow(
    title: "OutFitters"
   )
   ),
   
    Marker(markerId: MarkerId("76")
   ,
   position:LatLng(33.68371697248938, 72.9893293190847),
   infoWindow: InfoWindow(
    title: "OutFitters"
   )
   ),
   
    Marker(markerId: MarkerId("77")
   ,
   position:LatLng(33.722903283914086, 73.05114276516292),
   infoWindow: InfoWindow(
    title: "OutFitters"
   )
   ),
   
    Marker(markerId: MarkerId("78")
   ,
   position:LatLng(33.64684525504162, 73.05985005110888),
   infoWindow: InfoWindow(
    title: "OutFitters"
   )
   ),
   
    Marker(markerId: MarkerId("79")
   ,
   position:LatLng(33.52224590308265, 73.14928819542004),
   infoWindow: InfoWindow(
    title: "OutFitters"
   )
   ),
   
    Marker(markerId: MarkerId("80")
   ,
   position:LatLng(33.70795343692952, 73.04901871898291),
   infoWindow: InfoWindow(
    title: "OutFitters"
   )
   ),
     Marker(markerId: MarkerId("81")
   ,
   position:LatLng(33.721710479204155, 73.05501952874818),
   infoWindow: InfoWindow(
    title: "OutFitters"
   )
   ),
      Marker(markerId: MarkerId("82")
   ,
   position:LatLng(33.694161317348474, 73.0147733830198),
   infoWindow: InfoWindow(
    title: "Bonanza Satrangi"
   )
   ),
     Marker(markerId: MarkerId("83")
   ,
   position:LatLng(33.521544489984876, 73.15581132731457),
   infoWindow: InfoWindow(
    title: "Bonanza Satrangi"
   )
   ),
     Marker(markerId: MarkerId("84")
   ,
   position:LatLng(33.707425382536215, 73.04827995121407),
   infoWindow: InfoWindow(
    title: "Bonanza Satrangi"
   )
   ),
   

     Marker(markerId: MarkerId("85")
   ,
   position:LatLng(33.720282684461836, 73.05501952874818),
   infoWindow: InfoWindow(
    title: "Bonanza Satrangi"
   )
   ),
     Marker(markerId: MarkerId("86")
   ,
   position:LatLng(33.52193031227467, 73.09342340852945),
   infoWindow: InfoWindow(
    title: "Bonanza Satrangi"
   )
   ),
     Marker(markerId: MarkerId("87")
   ,
   position:LatLng(33.52193031227467, 73.09342340852945),
   infoWindow: InfoWindow(
    title: "Bonanza Satrangi"
   )
   ),
     Marker(markerId: MarkerId("88")
   ,
   position:LatLng(33.70704975147965, 73.0869256152547),
   infoWindow: InfoWindow(
    title: "Bonanza Satrangi"
   )
   ),
     Marker(markerId: MarkerId("89")
   ,
   position:LatLng(33.63898466937216, 73.0752963441804),
   infoWindow: InfoWindow(
    title: "Bonanza Satrangi"
   )
   ),
      Marker(markerId: MarkerId("90")
   ,
   position:LatLng(33.72994347274675, 73.07879966181389),
   infoWindow: InfoWindow(
    title: "Bonanza Satrangi"
   )
   ),

   

  ];
  Completer<GoogleMapController>  _completer = Completer();
  static final CameraPosition _cameraPosition = CameraPosition(target: LatLng(30.3753, 69.3451),zoom: 7);
  //    void getUpdatess() {
  //     setState(() {
  //             if (session == null){
  //       session = uuid.v4();
  //     }
  //     });
  // sendData(textEditingController.text);


  //   }
    final LocatitonGeocoder geocoder = LocatitonGeocoder("AIzaSyCZJDq4ZZiah_srzkzjQDtxnXVE-gbf85M");

//     sendData(String input)async{
//       String kPLACES_API_KEY = "AIzaSyCZJDq4ZZiah_srzkzjQDtxnXVE-gbf85M";
//        String baseURL =
//           'https://maps.googleapis.com/maps/api/place/autocomplete/json';
//       String request = '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$session';

//       var response = await http.get(Uri.parse(request));
//       print(response);

//       if(response.statusCode == 200){
 
// setState(() {
//   _placesList = jsonDecode(response.body.toString())['predictions'];
// });


//       }
//       else{
//         throw Exception("Failed to Load Data");
//       }
// aik baat hamesha yaad rakho g kn c sab  se pehle apne hathyar ache hone chahiye  ye hadis hay 
// is dor k lehaz se hamaray hathyar ye computer laptop wagera hain 
//     }

   Position? _currentPosition;
  @override
  void initState() {
      print("=====================================");
   print("categoryName" + widget.name.toString());//


widget.name == "SanaSafinaz" ?
 _markerSanaSafinaz.addAll(sanaSafinazMarkers) : 
 widget.name == "Khadi" ?
    _markerKhadi.addAll(KhadiMarkers)  :
     widget.name == "Breakout" ?
    _markerBreakout.addAll(BreakoutMarkers) :
    widget.name == "Saya" ?
    _markerSaya.addAll(SayaMarkers) :
     widget.name == "Bonanza" ?
    _markerBonanza.addAll(BonanzaMarkers) :

     widget.name == "LimeLight" ?
    _markerLimeLight.addAll(LimeLightMarkers) :
     widget.name == "J." ?
    _markerJ.addAll(JMarkers) :
    widget.name == "Outfitters" ?
    _markerOutfitters.addAll(OutfittersMarkers) :
    widget.name == "MariaB" ?
    _markerMariaB.addAll(MariaBMarkers):
    widget.name == "Sapphire" ?
    _markerSapphire.addAll(SapphireMarkers):
    widget.name == "GulAhmad" ?
    _markerGulAhmad.addAll(GulAhmadMarkers):
    widget.name == "Alkaram Studio" ?
    _markerAlkaramStudio.addAll(AlkaramStudioMarkers):
    widget.name == "NishatLinen" ?
    _markerNishatLinen.addAll(NishatLinenMarkers):
     _marker.addAll(heyMarker);

// wait dnt do anythiing
// switch(widget.name) { 
//    case "SanaSafinaz": { 
//     _markerSanaSafinaz.addAll(sanaSafinazMarkers);
//    } 
//    break; 

//    case "Khadi": { 
//       _markerKhadi.addAll(KhadiMarkers);
//    } 
//    break; 
      
//    default: { 
//     _marker.addAll(heyMarker);
//    }
//    break; 
// }


    super.initState();
    _getssCurrentLocation();
  }
   _getssCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentPosition = position;
    });
  }

 
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
// floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
//        floatingActionButton: FloatingActionButton(
        
//         onPressed: ()async{
//           //  getUpdatess();
//            GoogleMapController controller = await _completer.future;
//     await    getsCurrentLocation().then((value) async{
//           // print(value.accuracy == null ? "" :value.accuracy);
//            controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(30.3753, 69.3451),zoom: 7))
            
            
//             );
//             // print(value.longitude);
//             setState(() {
              
//             });
//             //  _marker.add(Marker(
//             //     icon:
//             //     //  BitmapDescriptor.defaultMarker,
//             //     await  MarkerIcon.pictureAsset(assetPath: "assets/labour.png", width: 60, height: 60),
//             //   markerId: MarkerId("2"),
//             //   position: LatLng(48.8566, 2.3522),
//             //   draggable: true,
//             //    flat: true,
//             //   infoWindow: InfoWindow(title: "asd" +"   "+"asdas")
//             //  ));
//         });
         

           
 

//        },
//        child: Icon(Icons.location_on),
//        ),
      body:
           SafeArea(
             child: Stack(
                  children: <Widget>[
                    Container(
                      child: 
                            GoogleMap(initialCameraPosition:
                    _currentPosition != null?         CameraPosition(target: 
                             LatLng(_currentPosition!.latitude, _currentPosition!.longitude),zoom: 10):CameraPosition(target: LatLng(33.6844, 73.0479),zoom: 10),
                 mapType: MapType.normal,
                 myLocationEnabled: true,
                 myLocationButtonEnabled: true,
              //     onMapCreated: (GoogleMapController controller) {
              // _completer.complete(controller);
                 
              //     },
                  markers: Set<Marker>.of(widget.name == "SanaSafinaz"? _markerSanaSafinaz:widget.name == "Khadi"?_markerKhadi :
                  widget.name == "Breakout" ? _markerBreakout: widget.name == "Saya" ? _markerSaya:
                  widget.name == "Bonanza" ? _markerBonanza :
                  widget.name == "LimeLight" ? _markerLimeLight :
                  widget.name == "J." ? _markerJ :
                   widget.name == "Outfitters" ? _markerOutfitters :
                    widget.name == "MariaB" ? _markerMariaB :
                     widget.name == "Sapphire" ? _markerSapphire :
                     widget.name == "GulAhmad" ? _markerGulAhmad :
                     widget.name == "Alkaram Studio" ? _markerAlkaramStudio :
                      widget.name == "NishatLinen" ? _markerNishatLinen :
                     _marker),
                  
                  ),
                    ),
                    // Stack(
                    //     children: <Widget>[
                    //   Positioned(
                    //   bottom: 0,
                    //   right: 250,
                    //   child: ElevatedButton(
                    //         onPressed: (){} ,
                    //         child: Text("dosomething"),
                    //         // color: Colors.grey,
                    //         // textColor: Colors.black,
                            
                    //         )),
                    //   ]),
          //           Container( 
          //           height: 100,
          //           width: MediaQuery.of(context).size.width * 0.8,
          //           child: Row(
          //                  children: <Widget> [
           
          //                   Expanded(
          //  child: 
          //  new TextFormField(
          //    controller: textEditingController,
          //               decoration: new InputDecoration(
          //                 labelText: "Enter Address",
          //                 fillColor: Colors.white,
          //                 border: new OutlineInputBorder(
          //                   borderRadius: new BorderRadius.circular(25.0),
          //                   borderSide: new BorderSide(
          //                   ),
          //                 ),
          //                 //fillColor: Colors.green
          //               ),
          //               validator: (val) {
          //                 // if(val.length==0) {
          //                 //   return "Email cannot be empty";
          //                 // }else{
          //                 //   return null;
          //                 // }
          //               },
          //               keyboardType: TextInputType.emailAddress,
          //               style: new TextStyle(
          //                 fontFamily: "Poppins",
          //               ),
          //             ),
           
          //            ) ]
          //                  )
          //           ),
                    // textEditingController.text.length == 0 ?  Text("data") :
                    //                 Padding(
                    //                   padding: const EdgeInsets.only(top:120.0),
                    //                   child: Container( 
                    //                     // color: Colors.white,
                    //                                   height: MediaQuery.of(context).size.width * 0.3,
                    //                                   width: MediaQuery.of(context).size.width * 0.8,
                    //                                   child: Row(
                    //                                          children: <Widget> [
                                    
                    //                                           Expanded(
                    //                 child: 
                    //                 ListView.builder(
                    //                   itemCount:_placesList.length ,
                    //                   itemBuilder:(BuildContext context, index) {
                    //                     return ListTile(
                    //                        onTap: () async{
                    //                          final address = await geocoder.findAddressesFromQuery(_placesList[index]["description"]);
                    //                          textEditingController.text = "";
                    //                           // List<Location> locations = await locationFromAddress("Pakistan");
                    //                           // print(locations.last.longitude);
                    //                           print(address.first.coordinates.latitude);
                    //                        },
                    //                       title: Text(_placesList[index]["description"],style: TextStyle(color: Colors.black),));
                    //                   }) )
                                   
                                    
                    //                                     ]
                    //                                          )
                    //                                   ),
                    //                 ),
           
               ]
               
               // StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance.collection('labour').snapshots(),
               // builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
               //    if (!snapshot.hasData) {
               //         return Center(
               //           child: CircularProgressIndicator(),
               //         );
               //       }
               //       final docs = snapshot.data!.docs;
               //   return 
             
               // },
               
               ),
           )
       
    
    );
    
   

  
  }
}