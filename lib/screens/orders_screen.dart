import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:myfood/controllers/order_controller.dart';
import 'package:myfood/models/restaurant_model.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var ordersController = Get.find<OrdersController>();
  int totalOrders = 0;

  Container _buildOrderItem(CategoryDish dish) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(15.0),
        border: Border.all(width: 1.0, color: Colors.grey[200]),
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    dish.dishName,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'INR ${dish.dishPrice}',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '${dish.dishCalories.toInt()} calories',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.black54),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(50.0),
                  border: Border.all(width: 0.8, color: Colors.black54),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (dish.orderQuantity == 1)
                            ordersController.removeOrder(dish.dishId);
                          dish.decreaseOrderQuantity();
                        });
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.minus,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Text(
                      '${dish.orderQuantity}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            if (dish.orderQuantity == 0) {
                              ordersController.addOrder(dish);
                            }
                            dish.increaseOrderQuantity();
                          });
                        },
                        icon: FaIcon(FontAwesomeIcons.plus),
                        color: Colors.white),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'INR ${dish.dishPrice * dish.orderQuantity}',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container _buildOrderSummary() {
    int totalDishes = ordersController.orders.length;
    int totalItems = 0;
    ordersController.orders.forEach((order) {
      totalItems += order.orderQuantity;
    });

    return Container(
      height: 60.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, -1),
            blurRadius: 6.0,
          ),
        ],
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Center(
          child: TextButton(
              onPressed: () {},
              child: Text(
                '$totalDishes Dishes - $totalItems Items',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ))),
    );
  }

  _buildTotalAmount() {
    double totalCost = 0;
    ordersController.orders.forEach((CategoryDish order) {
      totalCost += order.dishPrice * order.orderQuantity;
    });
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Total Amount',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'INR $totalCost',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  _showOrderPlacedDialog() {
    Get.defaultDialog(
      barrierDismissible: false,
      title: 'Successful!',
      middleText: 'Order has been placed successfully',
      confirm: ElevatedButton(
          style:
              ElevatedButton.styleFrom(primary: Theme.of(context).primaryColor),
          onPressed: () {
            ordersController.clearOrders();
            Get.back();
            Get.back();
          },
          child: Text('OK')),
    );
  }

  _buildPlaceOrder() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 60.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, -1),
              blurRadius: 6.0,
            ),
          ],
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Center(
            child: TextButton(
                onPressed: _showOrderPlacedDialog,
                child: Text(
                  'Place Order',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                  ),
                ))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    totalOrders = ordersController.orders.length;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order Summary',
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 16, 6, 0),
        child: ListView(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: totalOrders + 2,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return _buildOrderSummary();
                    } else if (index == totalOrders + 1) {
                      return _buildTotalAmount();
                    } else {
                      return _buildOrderItem(
                          ordersController.orders[index - 1]);
                    }
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      height: 1.0,
                      color: Colors.grey,
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 120)
          ],
        ),
      ),
      bottomSheet: _buildPlaceOrder(),
    );
  }
}
