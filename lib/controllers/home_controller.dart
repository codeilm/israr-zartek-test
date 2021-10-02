import 'package:get/get.dart';
import 'package:myfood/models/restaurant_model.dart';
import 'package:myfood/services/network_helper.dart';

class HomeController extends GetxController {
  RestaurantModel restaurantModel;
  bool isDataLoaded = false;
  Future<void> getRestaurantData() async {
    List data = await getData();
    if (data.isNotEmpty) {
      restaurantModel = RestaurantModel.fromJson(data.first);
    }
    isDataLoaded = true;
    update();
  }
}
