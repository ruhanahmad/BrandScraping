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


  Future<List<Product>> outfitterss() async {
    final response = await http.get(Uri.parse('https://outfitters.com.pk/collections/men-special-prices'));

    final document = parser.parse(response.body);
  print(document);



final productWrappers = document.querySelectorAll('.card-wrapper.underline-links-hover');



    final List<Map<String, String>> data = [];
    final products = productWrappers.map((labelss)  {
 final badgeItem =  labelss.querySelector('.card.card--standard.card--media ')!.children[0];
  final badgeItemtext =  labelss.querySelector('.card.card--standard.card--media .card__content .card__information .card-information .price.price--on-sale .price__container .price__sale .price-item.price-item--sale.price-item--last')!.children[1];
  final badgeHeading =  labelss.querySelector('.card.card--standard.card--media .card__content .card__information .title-swatches-wrapper.flex .card__heading.h5 .product-link-main')!.text;
print(badgeHeading);
 print(badgeItem.attributes["href"]);
//  if (badgeItem != null && badgeItem.text.isNotEmpty) {
//       // print the text content of the badge item
//       print(badgeItem.text);
//     }
     return Product(title: badgeHeading, link: badgeItem.attributes["href"]!, sale: badgeItemtext.text);
    }).toList();
    return products;


  }
  

class karam extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: outfitterss(),
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