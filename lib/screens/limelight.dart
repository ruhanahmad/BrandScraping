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


  Future<List<Product>> limeLight() async {
    final response = await http.get(Uri.parse('https://www.limelight.pk/collections/limelight-sale'));

    final document = parser.parse(response.body);
  print(document);




final productWrappers = document.querySelectorAll('.card-wrapper');



    final List<Map<String, String>> data = [];
    final products = productWrappers.map((labelss)  {
 final badgeLink =  labelss.querySelector('.product-img-main .full-unstyled-link')!.attributes["href"];
  final badgeItemHeading =  labelss.querySelector('.product-img-main .full-unstyled-link')!.children[0].text;
    final badgeItemSsale =  labelss.querySelector('.product-img-main .full-unstyled-link .card.card--product.card--outline .card__inner .card__badge.kkk ')!.text ?? "";
    print("-------------------->+ ${badgeItemSsale}");

  

     return Product(title: badgeItemHeading, link: badgeLink!, sale: badgeItemSsale);
    }).toList();
    return products;


  }
  

class Limelight extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: limeLight(),
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