import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peanut/controllers/promo_controller.dart';
import 'package:peanut/views/promo_item_card.dart';
import 'package:peanut/common/utils/app_txt.dart';
class PromoView extends GetView<PromoController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppText.promotionalCampaigns),
      ),
      body: Obx(
            () {
          if (controller.promoItems.isEmpty) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: controller.promoItems.length,
              itemBuilder: (context, index) {
                final promoKey = controller.promoItems[index]['promoKey'];
                return PromoItemCard(promoKey: promoKey, index: index);
              },
            );
          }
        },
      ),
    );
  }
}




