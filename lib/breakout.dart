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



class CardProductWrapperList extends StatefulWidget {

  String? name;
  CardProductWrapperList({this.name});

  @override
  _CardProductWrapperListState createState() => _CardProductWrapperListState();
}


class _CardProductWrapperListState extends State<CardProductWrapperList> {


     Future<List<Product>> NoSale() async {
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
      return Product(title: "No Sale", link: "No Sale", sale: "No Sale");
   

    }).toList();

return productss;


  
}

    Future<List<Product>> sapphire() async {
  final url = 'https://pk.sapphireonline.pk/pages/eid-bundles';
  final response = await http.get(Uri.parse(url));
  final document = parser.parse(response.body);
  
  final divElements = document.querySelectorAll('div.t4s-col-6.t4s-col-md-3 > a[href]');
    List disC = [];
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

    List disC = [];
    List disCtwo = []; 
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
 disC.addAll([badgeItemSale]);
      print(disC);
//     }
     return Product(title:badgeItemText, link: badgeItem!, sale: badgeItemSale);
    }).toList();
    return products;


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

  disCtwo.addAll([badgeItemtext]);
//       // print the text content of the badge item
//       print(badgeItem.text);
//     }
     return Product(title: badgeHeading, link: badgeItem.attributes["href"]!, sale: badgeItemtext.text);
    }).toList();
    return products;


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

  








     Future<List<Product>> gulAhmad() async {
    final response = await http.get(Uri.parse('https://www.gulahmedshop.com/sale?discount_percentage=40'));

    final document = parser.parse(response.body);
  print(document);


final productWrappers = document.querySelectorAll('.product-item-info');



    final List<Map<String, String>> data = [];
    final products = productWrappers.map((labelss)  {
 final badgeLink =  labelss.querySelector('.cdz-hover-section .cdz-product-top .product.photo.product-item-photo')!.attributes["href"];
  final badgeSale =  labelss.querySelector('.cdz-hover-section .cdz-product-labels .label-content')!.text;
    final badgeHead =  labelss.querySelector('.product.details.product-item-details > a[href] .product.name.product-item-name .product-item-link')!.text;

  // final badgeItemtext =  labelss.querySelector('.card.card--standard.card--media .card__content .card__information .card-information .price.price--on-sale .price__container .price__sale .price-item.price-item--sale.price-item--last')!.children[1];
  // final badgeHeading =  labelss.querySelector('.card.card--standard.card--media .card__content .card__information .title-swatches-wrapper.flex .card__heading.h5 .product-link-main')!.text;
// print(badgeHeading);
 print(badgeLink);
//  if (badgeItem != null && badgeItem.text.isNotEmpty) {
//       // print the text content of the badge item
//       print(badgeItem.text);
//     }
     return Product(title: badgeHead, link: badgeLink!, sale: badgeSale);
    }).toList();
    return products;


  }

  







  Future<List<Product>> getProductsqq() async {
  final response = await http.get(Uri.parse('https://bonanzasatrangi.com/collections/new-arrivals'));
  final document = parser.parse(response.body);

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
    Product(title:title, link: link!, sale: sale);
  }).toList();

  return products;
}
  Future<List<Product>> _getData() async {
    final response = await http.get(Uri.parse('https://breakout.com.pk/collections/men-sale'));

    final document = parser.parse(response.body);

    final wrapperElements = document.querySelectorAll('.card-product__wrapper');

    final List<Map<String, String>> data = [];
      final products = wrapperElements.map((labelElement) {
     
    final titleElement = labelElement.querySelector('.card__badge.badge-left.halo-productBadges.halo-productBadges--left.date-.date1-')!.children[0];
    final mediaElement = labelElement.querySelector('.card-media.card-media--adapt.media--hover-effect.media--loading-effect');
    final title = titleElement.text;
    final link = mediaElement!.attributes['href'];
    return 
    // sale;
    Product(title:title, link: link!,sale: title);
  }).toList();



    return products;
  }


Future<List<Product>> getProducts() async {
  final response = await http.get(Uri.parse('https://saya.pk/collections/jacquard-2023'));
  final document = parser.parse(response.body);

  final productElements = document.querySelectorAll('.inner-top .product-top .product-label .label.sale-label');
  final products = productElements.map((labelElement) {
      final sale = labelElement.text;
                      print(sale);
    final productElement = labelElement.parent!.parent!.parent;
    final titleElement = productElement?.querySelector('.product-details .product-title');
    final title = titleElement!.text;
    final link = titleElement.attributes['href'];
    return Product(title: title, link: link!, sale: sale);
  }).toList();

  return products;
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:
    
       FutureBuilder<List<Product>>(
        future: widget.name == "Breakout" ?_getData():widget.name == "Bonanza" ?getProductsqq():widget.name == "Saya" ?getProducts():widget.name == "Bonanza" ?gulAhmad() :widget.name == "Khadi"? khadi(): widget.name == "LimeLight"? limeLight() : widget.name == "MariaB"?mariab():widget.name == "Outfitters" ? outfitterss():widget.name == "SanaSafinaz" ?sanasafinaz():widget.name == "SanaSafinaz" ?sanasafinaz():widget.name == "J."?NoSale(): widget.name == "Alkaram Studio"?NoSale() :widget.name == "NishatLinen" ?NoSale():  _getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final item = snapshot.data![index];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      title: Text(item.title),
                      subtitle:widget.name == "Breakout"
                      ? Text("https://breakout.com.pk/collections/men-sale" +item.link):
                      widget.name == "Bonanza"?
                      Text("https://bonanzasatrangi.com/collections/new-arrivals" +item.link):
                      widget.name == "Saya"?
                      Text("https://saya.pk/" +item.link):
                      widget.name == "GulAhmad"?
                      Text(item.link):
                      widget.name == "Khadi" ?
                       Text(item.link):
                        widget.name == "LimeLight" ?
                        Text("https://www.limelight.pk" +item.link):
                        widget.name == "MariaB" ?
                  Text("https://www.mariab.pk/collections/all-sale" +item.link):
                  widget.name == "Outfitters" ?
                  
                     Text( "https://outfitters.com.pk" +item.link):  
                     widget.name == "SanaSafinaz" ?
                      Text( item.link):
                      widget.name == "Sapphire" ?
                       Text(item.link):
                        widget.name == "J." ? 
                        Text("No Sale"):
                         widget.name == "Alkaram Studio" ?
                         Text("No Sale"):
                          widget.name == "NishatLinen" ?
                          Text("No Sale"):
                      Text("https://breakout.com.pk/collections/men-sale" +item.link),
                      leading: CircleAvatar(child: Text(item.sale)),
                      trailing: ElevatedButton(
                        onPressed: () {
                          launchUrl(widget.name == "Breakout"?
                           Uri.parse("https://breakout.com.pk/collections/men-sale" +item.link):widget.name == "Bonanza"?
                           Uri.parse("https://bonanzasatrangi.com/collections/new-arrivals" +item.link):widget.name == "Saya"?
                           Uri.parse("https://saya.pk/" +item.link):widget.name == "GulAhmad"? 
                           Uri.parse(item.link):widget.name == "Khadi" ?
                            Uri.parse(item.link): widget.name == "LimeLight" ?
                             Uri.parse("https://www.limelight.pk" +item.link):
                            widget.name == "MariaB" ?
                            Uri.parse("https://www.mariab.pk/collections/all-sale" +item.link):
                            widget.name == "Outfitters" ?
                            Uri.parse("https://outfitters.com.pk" +item.link):
                             widget.name == "SanaSafinaz" ?
                               Uri.parse(item.link):
                    widget.name == "Sapphire" ?
                    Uri.parse(item.link):
                     widget.name == "Alkaram Studio" ?
                     Uri.parse(""):
                      widget.name == "J." ?
                      Uri.parse(""):
                       widget.name == "NishatLinen" ?
                       Uri.parse(""):
                            Uri.parse("https://breakout.com.pk/collections/men-sale" +item.link)
                           );
                        },
                        child: Text('Open URL'),
                      ),
                  
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:html/parser.dart' as parser;
// import 'package:html/dom.dart' as dom;

// class CardBadgeList extends StatefulWidget {
//   @override
//   _CardBadgeListState createState() => _CardBadgeListState();
// }

// class _CardBadgeListState extends State<CardBadgeList> {
//   List<String> badges = [];

//   Future<List<String>> _getData() async {
//     // Make a GET request to the website
//     final response = await http.get(Uri.parse('https://breakout.com.pk/collections/men-sale'));

//     // Use the html parser to parse the response body
//     final document = parser.parse(response.body);

//     // Find all elements with class name "card__badge badge-left halo-productBadges halo-productBadges--left date- date1-"
//     final badgesElements = document.querySelectorAll('.card__badge.badge-left.halo-productBadges.halo-productBadges--left.date-.date1-');

//     // Loop through the elements and find the sub class "badge sale-badge"
//     for (final badgeElement in badgesElements) {
//       final subClass = badgeElement.querySelector('.badge.sale-badge');

//       // If the sub class exists, add its text to the badges list
//       if (subClass != null) {
//         badges.add(subClass.text);
//       }
//     }

//     return badges;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder<List<String>>(
//         future: _getData(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return ListView.builder(
//               itemCount: snapshot.data!.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(snapshot.data![index]),
//                 );
//               },
//             );
//           } else if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           } else {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
