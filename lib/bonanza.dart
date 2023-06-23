import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html;

class Product {
  final String title;
  final String link;
  final String sale;

  Product({required this.title, required this.link,required this.sale});
}

Future<List<Product>> getProductsqq() async {
  final response = await http.get(Uri.parse('https://bonanzasatrangi.com/collections/new-arrivals'));
  final document = html.parse(response.body);

  final productElements = document.querySelectorAll('.grid-view_image .thisproduct.product-labels.rounded .lbl.on-sale ');
  final products = productElements.map((labelElement) {
      final sale = labelElement.text;
                      print(sale);
    final productElement = labelElement.parent!.parent!;
    final titleElement = productElement?.querySelector('.grid-view_image .grid-view-item__link');
    final title = titleElement!.text;
    final link = titleElement.attributes['href'];
    return 
    // sale;
    Product(title:sale, link: link!, sale: link!);
  }).toList();

  return products;
}

class jayKantss extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: getProductsqq(),
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
                subtitle: Text(product.link),
                trailing: Text(product.sale),
              );
            },
          ),
        );
      },
    );
  }
}