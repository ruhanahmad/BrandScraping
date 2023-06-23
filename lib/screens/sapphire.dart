import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;
import 'package:url_launcher/url_launcher.dart';

class Product {
  final String title;
  final String link;
  final String sale;

  Product({required this.title, required this.link,required this.sale});
}


//   Future<List<Product>> sapphire() async {
//     final response = await http.get(Uri.parse('https://pk.sapphireonline.pk/pages/eid-bundles'));

//     final document = parser.parse(response.body);
//   print(document);
// //  final productWrappers = document.querySelectorAll('.price__container');



// //     final List<Map<String, String>> data = [];
// //     final products = productWrappers.map((labelss)  {
// //  final badgeItem = labelss.querySelector('.price__sale .price-item.price-item--sale.price-item--last')!.children[1];
// //  print(badgeItem.text);
// // //  if (badgeItem != null && badgeItem.text.isNotEmpty) {
// // //       // print the text content of the badge item
// // //       print(badgeItem.text);
// // //     }
// //      return Product(title: "badgeItem.text", link: "badgeItem.text", sale: "badgeItem.text");
// //     }).toList();




// final productWrappers = document.querySelectorAll('.t4s-row');



//     final List<Map<String, String>> data = [];
//     final products = productWrappers.map((labelss)  {
//  final badgeLink =  labelss.querySelector('.t4s-col-6.t4s-col-md-3');
//  print(badgeLink);
//   final badgeItemHeading =  labelss.querySelector('.t4s-col-6.t4s-col-md-3 .cstm-sticker .blink_me')!.text ?? "";
//     print(badgeItemHeading);
//     // final badgeItemSsale =  labelss.querySelector('.product-img-main .full-unstyled-link .card.card--product.card--outline .card__inner .card__badge.kkk ')!.text ?? "";
//     // print("-------------------->+ ${badgeItemSsale}");

  
//   // final badgeItemtext =  labelss.querySelector('.grid-product__tag.grid-product__tag--sale .grid-product__link .asas.grid-product__meta .grid-product__title.grid-product__title--body .price-box-list-left')!.children[0].text;
  
// // print(badgeHeading);

// //  if (badgeItem != null && badgeItem.text.isNotEmpty) {
// //       // print the text content of the badge item
// //       print(badgeItem.text);
// //     }
//      return Product(title: "badgeItemHeading", link: "badgeLink!", sale: "badgeItemSsale");
//     }).toList();
//     return products;


//   }


  Future<List<Product>> sapphire() async {
  final url = 'https://pk.sapphireonline.pk/pages/eid-bundles';
  final response = await http.get(Uri.parse(url));
  final document = parser.parse(response.body);
  
  final divElements = document.querySelectorAll('div.t4s-col-6.t4s-col-md-3 > a[href]');
    
    final productss = divElements.map((labels)  {
    final link = labels.attributes['href'];
    final spanElement = labels.querySelector('span.cstm-sticker > .blink_me ');
    //  final heading = divElement.querySelector('span.cstm-sticker')!.children[0];
    final text2 = spanElement?.nextElementSibling?.text ?? "";
 
      final text = spanElement!.text;
      final head = text2;
      print('$link: $text  $head' );
      return Product(title: text, link: link!, sale: text);
   

    }).toList();

return productss;


  
}
  

class Sapphire extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: sapphire(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final products = snapshot.data;

        if (products == null || products.isEmpty) {
          return Center(child: Text('No products found'));
        }

        return Scaffold(
          body: ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ListTile(
                title: Text(product.title),
                subtitle: Text(product.sale),
                trailing: Text(product.link),
              );
            },
          ),
        );
      },
    );
  }
}