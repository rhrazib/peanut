import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peanut/controllers/promo_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class PromoItemCard extends StatelessWidget {
  final PromoController controller = Get.find(); // Access the controller
  final String dynamicDomain = "forex-images.ifxdb.com"; // Set the dynamic domain
  final String promoKey;
  final int index;

  PromoItemCard({
    required this.promoKey,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    String imageUrl = controller.promoItems[index]['promoItem']['image']
        .replaceAll("forex-images.instaforex.com", dynamicDomain);

    return Obx(() {
      final promoItem = controller.promoItems[index]['promoItem'];

      return Card(
        margin: EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: 180,
              height: 180,
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    Image.asset('assets/images/img_placeholder.png'),
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(promoItem['text'], style: TextStyle(fontSize: 16)),
                  SizedBox(height: 8),
                 // Text('Link: ${promoItem['link']}'),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        final url = Uri.encodeFull(promoItem['link']);
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      } catch (e) {
                        print('Error launching URL: $e');
                      }
                    },
                    child: Text(promoItem['button_text']),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Color(int.parse(promoItem['button_color'].substring(1, 7), radix: 16) + 0xFF000000),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}