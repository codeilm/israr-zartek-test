import 'package:get/get.dart';
import 'package:myfood/models/restaurant_model.dart';

class OrdersController extends GetxController {
  List<CategoryDish> orders = [];
  void addOrder(CategoryDish dish) {
    orders.add(dish);
    update();
  }

  void removeOrder(String id) {
    orders.removeWhere((order) => order.dishId == id);
    update();
  }

  void clearOrders() {
    orders.forEach((order) {
      order.orderQuantity = 0;
    });
    orders.clear();
    update();
  }
}
