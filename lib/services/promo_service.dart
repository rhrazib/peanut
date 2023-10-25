import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:peanut/api/dio.dart';
import 'package:xml/xml.dart';

class PromoService {
 // final Dio _dio = Dio();

  Future<List<Map<String, dynamic>>?> fetchPromoData() async {
    final url = 'https://api-forexcopy.contentdatapro.com/Services/CabinetMicroService.svc';
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
      final response = await DioClient.dio.post(
        url,
        options: Options(headers: headers),
        data: envelope,
      );

      if (response.statusCode == 200) {
        final getCCPromoResultElement = XmlDocument.parse(response.data).findAllElements('GetCCPromoResult').first;
        var getCCPromoResultContent = getCCPromoResultElement.text;

        // Replace "False" with "false" in the JSON string
        getCCPromoResultContent = getCCPromoResultContent.replaceAll('False', 'false');

        final promoData = json.decode(getCCPromoResultContent);

        if (promoData is Map) {
          return promoData.entries.map((entry) {
            return {
              'promoKey': entry.key,
              'promoItem': entry.value,
            };
          }).toList();
        }
      }
    } catch (e) {
      print('Error: $e');
    }

    return null;
  }
}
