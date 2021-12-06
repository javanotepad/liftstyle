import 'package:flutter/material.dart';
import 'package:liftstyle/models/vmodel/Item.dart';
import 'package:liftstyle/models/vmodel/cart.dart';
import 'package:liftstyle/models/vmodel/product.dart';
import 'package:liftstyle/screens/shared/home/productDetails.dart';
import 'package:liftstyle/utilities/constants.dart';

class CartCard extends StatelessWidget {
  const CartCard({Key? key, required this.item}) : super(key: key);
  final Item item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        /*
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetails(
                Product: item.Product!,
              ),
            ));
      */
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
        ),
        height: 350.0,
        margin: EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 24.0,
        ),
        child: Stack(
          children: <Widget>[
            Card(
                clipBehavior: Clip.antiAlias,
                child: Column(children: [
                  ListTile(
                      title: Text(item.title),
                      subtitle: Text(
                        item.desception,
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ))
                ])),
            Container(
              height: 350.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  item.productimageurl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [
                    0.2,
                    0.2,
                    0.5,
                  ],
                  colors: [
                    Colors.white54,
                    Colors.indigo,
                    Colors.teal,
                  ],
                )),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.title,
                        style: regularHeading,
                      ),
                      Text(
                        item.price.toString(),
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

/* Card buildCard(String title, String details, String price, String url) {
    var heading = '\$';
    var subheading = '2 bed, 1 bath, 1300 sqft';
    var cardImage = NetworkImage(url);
    var supportingText =
        'Beautiful home to rent, recently refurbished with modern appliances...';
    return Card(
        elevation: 4.0,
        child: Column(
          children: [
            ListTile(
              title: Text(title),
              subtitle: Text(details),
              trailing: Icon(Icons.favorite_outline),
            ),
            Container(
              height: 200.0,
              child: Ink.image(
                image: cardImage,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.centerLeft,
              child: Text(details),
            ),
            ButtonBar(
              children: [
                TextButton(
                  child: const Text('CONTACT AGENT'),
                  onPressed: () {/* ... */},
                ),
                TextButton(
                  child: const Text('LEARN MORE'),
                  onPressed: () {/* ... */},
                )
              ],
            )
          ],
        ));
  }*/
}
