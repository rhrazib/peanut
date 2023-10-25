import 'package:get/get.dart';
import 'package:peanut/services/promo_service.dart';

class PromoController extends GetxController {
  final PromoService promoService = PromoService();
  final RxList<Map<String, dynamic>> promoItems = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    final data = await promoService.fetchPromoData();
    if (data != null) {
      promoItems.assignAll(data);
    }
  }
}
