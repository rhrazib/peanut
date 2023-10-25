import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xml/xml.dart';
import 'dart:convert';


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, dynamic>> promoItems = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final url =
        'https://api-forexcopy.contentdatapro.com/Services/CabinetMicroService.svc';
    final soapAction = 'http://tempuri.org/CabinetMicroService/GetCCPromo';

    final headers = {
      'Content-Type': 'text/xml; charset=utf-8',
      'SOAPAction': soapAction,
    };

    final envelope = '''<?xml version="1.0" encoding="utf-8"?>
    <s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">
      <s:Body>
        <GetCCPromo xmlns="http://tempuri.org/">
          <lang>en</lang>
        </GetCCPromo>
      </s:Body>
    </s:Envelope>''';

    try {
      final dio = Dio();
      //todo new

      //todo here
      final response = await dio.post(
        url,
        options: Options(headers: headers),
        data: envelope,
      );

      if (response.statusCode == 200) {
        final document = XmlDocument.parse(response.data);
        final getCCPromoResultElement =
            document.findAllElements('GetCCPromoResult').first;
        var getCCPromoResultContent = getCCPromoResultElement.text;

        // Replace "False" with "false" in the JSON string
        getCCPromoResultContent =
            getCCPromoResultContent.replaceAll('False', 'false');

        final promoData = json.decode(getCCPromoResultContent);

        if (promoData is Map) {
          promoItems = promoData.entries.map((entry) {
            return {
              'promoKey': entry.key,
              'promoItem': entry.value,
            };
          }).toList();
        }

        setState(() {
          // Set state if necessary
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Promotional Items'),
      ),
      body: ListView.builder(
        itemCount: promoItems.length,
        itemBuilder: (context, index) {
          final promoKey = promoItems[index]['promoKey'];
          final promoItem = promoItems[index]['promoItem'];

          return PromoItemCard(promoKey: promoKey, promoItem: promoItem);
        },
      ),
    );
  }
}

class PromoItemCard extends StatelessWidget {
  final String promoKey;
  final Map<String, dynamic> promoItem;

  PromoItemCard({
    required this.promoKey,
    required this.promoItem,
  });

  @override
  Widget build(BuildContext context) {
    print(promoItem['image']);

    return Card(
      margin: EdgeInsets.all(16),
      child: Column(
        children: [
          CachedNetworkImage(
            imageUrl: promoItem['image'],
            placeholder: (context, url) =>
            const Center(child: CircularProgressIndicator()), // Loading indicator
            errorWidget: (context, url, error) =>
                Text('Error: $error'), // Display the error message
            fit: BoxFit.cover,
          ),

          // Image.network(promoItem['image']),
          //   CachedNetworkImage(
          //     imageUrl: promoItem['image'],
          //     placeholder: (context, url) =>
          //     const Center(child: CircularProgressIndicator()), // Loading indicator
          //     errorWidget: (context, url, error) =>
          //         Image.asset('assets/replacement_image.png'), // Replacement image on error
          //     fit: BoxFit.cover,
          //   ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Text(promoItem['text'], style: TextStyle(fontSize: 16)),
                SizedBox(height: 8),
                Text('Link: ${promoItem['link']}'),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () async {
                    final url = promoItem['link'];
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  child: Text(promoItem['button_text']),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Color(int.parse(promoItem['button_color'].substring(1, 7),
                          radix: 16) +
                          0xFF000000),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
