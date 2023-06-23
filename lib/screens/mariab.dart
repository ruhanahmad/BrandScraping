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


  Future<List<Product>> mariab() async {
    final response = await http.get(Uri.parse('https://www.mariab.pk/collections/all-sale'));

    final document = parser.parse(response.body);
  print(document);



final productWrappers = document.querySelectorAll('.grid-product__content');



    final List<Map<String, String>> data = [];
    final products = productWrappers.map((labelss)  {
 final badgeLink =  labelss.querySelector('.grid-product__link')!.attributes["href"];
  final badgeItemText =  labelss.querySelector('.grid-product__link .asas.grid-product__meta .grid-product__title.grid-product__title--body')!.text;
  // final badgeItemtext =  labelss.querySelector('.grid-product__tag.grid-product__tag--sale .grid-product__link .asas.grid-product__meta .grid-product__title.grid-product__title--body .price-box-list-left')!.children[0].text;
  final badgeItemsale =  labelss.querySelector('.grid-product__link .asas.grid-product__meta .price-box-list-left .grid-product__price--savings')!.text;
// print(badgeHeading);

//  if (badgeItem != null && badgeItem.text.isNotEmpty) {
//       // print the text content of the badge item
//       print(badgeItem.text);
//     }
     return Product(title: badgeItemText, link: badgeLink!, sale: badgeItemsale);
    }).toList();
    return products;


  }
  

class MariaB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: mariab(),
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