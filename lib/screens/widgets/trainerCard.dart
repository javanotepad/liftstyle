import 'package:flutter/material.dart';
import 'package:liftstyle/models/vmodel/login_user_model.dart';
import 'package:liftstyle/screens/shared/home/TrainerDetails.dart';

import 'package:liftstyle/screens/shared/home/productDetails.dart';
import 'package:liftstyle/utilities/constants.dart';

class TrainerCard extends StatelessWidget {
  const TrainerCard({Key? key, required this.item}) : super(key: key);
  final loginModel item;

  @override
  Widget build(BuildContext context) {
    item.img ??= trainer_img_df;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TrainerDetails(
                Trainer: item,
              ),
            ));
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
                      title: Text(item.FullName.toString()),
                      subtitle: Text(
                        item.FullName.toString(),
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ))
                ])),
            Container(
              height: 350.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  item.img.toString(),
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
                    0.4,
                    0.4,
                    0.5,
                  ],
                  colors: [
                    Colors.white54,
                    Colors.white60,
                    Colors.white38,
                  ],
                )),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.FullName.toString(),
                        style: regularHeading,
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
