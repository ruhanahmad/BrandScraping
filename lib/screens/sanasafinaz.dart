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


  Future<List<Product>> sanasafinaz() async {
    final response = await http.get(Uri.parse('https://www.sanasafinaz.com/pk/sale.html'));

    final document = parser.parse(response.body);
  print(document);


final productWrappers = document.querySelectorAll('.product.details.product-item-details');



    final List<Map<String, String>> data = [];
    final products = productWrappers.map((labelss)  {
 
 final badgeItem =  labelss.querySelector('.product.name.product-item-name .product-item-link')!.attributes["href"];
 final badgeItemSale =  labelss.querySelector('.price-box.price-final_price .sale-discount-percentage')!.text;
  final badgeItemText =  labelss.querySelector('.product.name.product-item-name .product-item-link')!.text;

//     }
     return Product(title:badgeItemText, link: badgeItem!, sale: badgeItemSale);
    }).toList();
    return products;


  }
  

class SanaSafina extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: sanasafinaz(),
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