import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'package:scrapingdart/bonanza.dart';
import 'package:scrapingdart/breakout.dart';
import 'package:scrapingdart/components/login_page.dart';
import 'package:scrapingdart/saya.dart';
import 'package:scrapingdart/screens/login.dart';
import 'package:scrapingdart/screens/splashScreen.dart';
import 'package:scrapingdart/test/cubit/cubit_todo.dart';
import 'package:scrapingdart/test/cubit/todo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
    // BlocProvider(create: (context)=>Todocubit()..insan(),
    
    // child:MaterialApp(home:
    // // SplashScreen() 
    // TODOSCRAPE() 
    
    // ),
    
    // );
     const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase GridView Example',
      home: 
    SplashScreen()  ,
      // CardProductWrapperList()
      // LoginPages(),
    );
  }
}
// void main() async{
//  WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//    WidgetsFlutterBinding.ensureInitialized();

// runApp(MaterialApp(
// 	theme: ThemeData(
// 	accentColor: Colors.green,
// 	scaffoldBackgroundColor: Colors.green[100],
// 	primaryColor: Colors.green,
// 	),
// 	home: LoginPage ()));}

// class MyApp extends StatefulWidget {
// const MyApp({Key? key}) : super(key: key);

// @override
// _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
	
// // Strings to store the extracted Article titles
// String result1 = 'Result 1';
// String result2 = 'Result 2';
// String result3 = 'Result 3';
	
// // boolean to show CircularProgressIndication
// // while Web Scraping awaits
// bool isLoading = false;

// Future<List> getProductsss() async {
//   final response = await http.get(Uri.parse('https://saya.pk/collections/jacquard-2023'));
//   final document = parser.parse(response.body);

//   final productElements = document.querySelectorAll('.inner-top .product-top .product-label .label.sale-label');
//   final products = productElements.map((labelElement) {
//                       final ss = labelElement.text;
//                       print(ss);
//     final productElement = labelElement.parent!.parent!.parent;
//     final titleElement = productElement?.querySelector('.product-details .product-title');
//     final title = titleElement!.text;
//     final link = titleElement.attributes['href'];
//     print(link);
//     return title;
//     //  Product(title: title, link: link);
//   }).toList();

//   return products;
// }




// Future<List> getProducts() async {
//   final response = await http.get(Uri.parse('https://saya.pk/collections/jacquard-2023'));
//   final document = parser.parse(response.body);

//   final productElements = document.querySelectorAll('.inner-top .product-details .product-title');
//   final products = productElements.map((element) {
//     final title = element.text;
//     final link = element.attributes['href'];
//     print(title);
//     print(link);
//     return title;
    
//   }).toList();

//   return products;
// }




//   static const String _mainPageLink = 'https://saya.pk/collections/jacquard-2023';

//  Future<List<String>> _getProductLinks() async {
//     final response = await http.get(Uri.parse(_mainPageLink));
//     final document = parser.parse(response.body);
//     final productLinks = <String>[];
//     for (final element in document.querySelectorAll('a.product-grid-image')) {
//       final productLink = element.attributes['href'];
//       print(productLink);
//       if (productLink != null) {
//         productLinks.add(productLink);
//       }
//     }
//     return productLinks;
//   }
// Future<List<String>> scrapeData() async {
//   final response = await http.get(Uri.parse('https://saya.pk/collections/jacquard-2023'));
//   final document = parser.parse(response.body);
//   final elements = document.getElementsByClassName("label sale-label");
//   final data = elements.map((element) => element.text).toList();
//   return data;
// }
//  extractData() async {

// 	// Getting the response from the targeted url
// 	final response =
// 		await http.Client().get(Uri.parse('https://saya.pk/collections/jacquard-2023'));
	
// 		// Status Code 200 means response has been received successfully
// 	if (response.statusCode == 200) {
		
// 	// Getting the html document from the response
// 	var document = parser.parse(response.body);
//   return document;
//   }}
// // 	try {
		
// // 	// Scraping the first article title
// //   print(document);
// //   var responseString1 ;
// //  for (var i =0;i < 10;i++){
// // 	 responseString1 = document
// // 			.getElementsByClassName("label sale-label")[i];
// //       print(responseString1.text.trim());

      

// //  }
	
// // 			// .children[0]
// // 			// .children[0];
// // 			// .children[0];

		


		
// // 	// Scraping the second article title
// // 	// 	var responseString2 = document
// // 	// 		.getElementsByClassName('articles-list')[0]
// // 	// 		.children[1]
// // 	// 		.children[0]
// // 	// 		.children[0];

// // 	// 	print(responseString2.text.trim());
		
// // 	// // Scraping the third article title
// // 	// 	var responseString3 = document
// // 	// 		.getElementsByClassName('articles-list')[0]
// // 	// 		.children[2]
// // 	// 		.children[0]
// // 	// 		.children[0];

// // 	// 	print(responseString3.text.trim());
		
// // 		// Converting the extracted titles into
// // 		// string and returning a list of Strings
// // 		return [
// // 		responseString1.text.trim(),
// // 		// responseString2.text.trim(),
// // 		// responseString3.text.trim()
// // 		];
// // 	} catch (e) {
// // 		return ['', '', 'ERROR!'];
// // 	}
// // 	} else {
// // 	return ['', '', 'ERROR: ${response.statusCode}.'];
// // 	}
// // }

// @override
// Widget build(BuildContext context) {
// 	return Scaffold(
// 	appBar: AppBar(title: Text('GeeksForGeeks'),
  
//   actions: [
   
// IconButton(onPressed: ()async{
// await getProductsss();

// }, icon: Icon(Icons.abc))
//   ],
//   ),
// 	body: Padding(
// 		padding: const EdgeInsets.all(16.0),
// 		child: Center(
// 			child:
//       FutureBuilder(
//         future:scrapeData(),
//         builder: (BuildContext ctx, AsyncSnapshot snapshot) 
//         {
//        return  snapshot.hasData ?
//        ListView.builder(
        
//         itemCount:snapshot.data.length,
//          itemBuilder: (BuildContext context, index) =>
//        Column(children: [
// Text(
//  snapshot.data![index],
// 						style: TextStyle(
// 							fontSize: 20, fontWeight: FontWeight.bold)),
// 					SizedBox(
// 						height: MediaQuery.of(context).size.height * 0.05,
// 					),
//       //     			MaterialButton(
// 			// onPressed: () async {
				
// 			// // Setting isLoading true to show the loader
// 			// 	setState(() {
// 			// 	isLoading = true;
// 			// 	});
				
// 			// 	// Awaiting for web scraping function
// 			// 	// to return list of strings
// 			// 	final response = await extractData();
				
// 			// 	// Setting the received strings to be
// 			// 	// displayed and making isLoading false
// 			// 	// to hide the loader
// 			// 	setState(() {
// 			// 	result1 = response[0];
// 			// 	// result2 = response[1];
// 			// 	// result3 = response[2];
// 			// 	isLoading = false;
// 			// 	});
// 			// },
// 			// child: Text(
// 			// 	'Scrap Data',
// 			// 	style: TextStyle(color: Colors.white),
// 			// ),
// 			// color: Colors.green,
// 			// )
//        ],)

        
//         ):Text("data");
//       //     if (snapshot.connectionState == ConnectionState.done) {
//       // // If we got an error
//       // if (snapshot.hasError) {
//       //   return Center(
//       //     child: Text(
//       //       '${snapshot.error} occurred',
//       //       style: TextStyle(fontSize: 18),
//       //     ),
//       //   );
         
//       //   // if we got our data
//       // } else if (snapshot.hasData) {
//       //   // Extracting data from snapshot object
//       //   final data = snapshot.data as String;
//       //   return Center(
//       //     child: Text(
//       //       '$data',
//       //       style: TextStyle(fontSize: 18),
//       //     ),
//       //   );
//       // }
//       // }
      
//       }
      
//       ))
      
//     //    Column(
// 		// mainAxisAlignment: MainAxisAlignment.center,
// 		// children: [
			
// 		// 	// if isLoading is true show loader
// 		// 	// else show Column of Texts
// 		// 	isLoading
// 		// 		? CircularProgressIndicator()
// 		// 		: 
//     //     Column(
// 		// 			children: [

// 		// 			Text(result1,
// 		// 				style: TextStyle(
// 		// 					fontSize: 20, fontWeight: FontWeight.bold)),
// 		// 			SizedBox(
// 		// 				height: MediaQuery.of(context).size.height * 0.05,
// 		// 			),
// 		// 			// Text(result2,
// 		// 			// 	style: TextStyle(
// 		// 			// 		fontSize: 20, fontWeight: FontWeight.bold)),
// 		// 			// SizedBox(
// 		// 			// 	height: MediaQuery.of(context).size.height * 0.05,
// 		// 			// ),
// 		// 			// Text(result3,
// 		// 			// 	style: TextStyle(
// 		// 			// 		fontSize: 20, fontWeight: FontWeight.bold)),
// 		// 			],
// 		// 		),
// 		// 	SizedBox(height: MediaQuery.of(context).size.height * 0.08),
// 		// 	MaterialButton(
// 		// 	onPressed: () async {
				
// 		// 	// Setting isLoading true to show the loader
// 		// 		setState(() {
// 		// 		isLoading = true;
// 		// 		});
				
// 		// 		// Awaiting for web scraping function
// 		// 		// to return list of strings
// 		// 		final response = await extractData();
				
// 		// 		// Setting the received strings to be
// 		// 		// displayed and making isLoading false
// 		// 		// to hide the loader
// 		// 		setState(() {
// 		// 		result1 = response[0];
// 		// 		// result2 = response[1];
// 		// 		// result3 = response[2];
// 		// 		isLoading = false;
// 		// 		});
// 		// 	},
// 		// 	child: Text(
// 		// 		'Scrap Data',
// 		// 		style: TextStyle(color: Colors.white),
// 		// 	),
// 		// 	color: Colors.green,
// 		// 	)
// 		// ],
// 		// )
//     ),
// 	);

// }
// }
