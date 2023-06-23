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


  Future<List<Product>> khadi() async {
    final response = await http.get(Uri.parse('https://pk.khaadi.com/sale.html'));

    final document = parser.parse(response.body);
  print(document);



final productWrappers = document.querySelectorAll('.product-item-info.type3');



    final List<Map<String, String>> data = [];
    final products = productWrappers.map((labelss)  {
 final badgeLink =  labelss.querySelector('.product.photo.product-item-photo')!.children[0].attributes["href"];
  final badgeText =  labelss.querySelector('.product.details.product-item-details .product.name.product-item-name .product-item-link')!.text;
    final badgeSale =  labelss.querySelector('.product.photo.product-item-photo .product-labels .product-label.sale-label')!.text;

  // final badgeItemtext =  labelss.querySelector('.card.card--standard.card--media .card__content .card__information .card-information .price.price--on-sale .price__container .price__sale .price-item.price-item--sale.price-item--last')!.children[1];
  // final badgeHeading =  labelss.querySelector('.card.card--standard.card--media .card__content .card__information .title-swatches-wrapper.flex .card__heading.h5 .product-link-main')!.text;
// print(badgeHeading);
 print(badgeLink);
//  if (badgeItem != null && badgeItem.text.isNotEmpty) {
//       // print the text content of the badge item
//       print(badgeItem.text);
//     }
     return Product(title: badgeText, link: badgeLink!, sale: badgeSale);
    }).toList();
    return products;


  }
  

class kahadii extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: khadi(),
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