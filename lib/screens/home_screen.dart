import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:myfood/controllers/home_controller.dart';
import 'package:myfood/controllers/order_controller.dart';
import 'package:myfood/models/restaurant_model.dart';
import 'package:myfood/routing/routes.dart';
import 'package:myfood/widgets/my_drawer.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TabController _tabController;
  var homeController = Get.put(HomeController());
  var ordersController = Get.put(OrdersController());

  _buildCategories() {
    return homeController.restaurantModel.tableMenuList
        .map((TableMenuList tml) => Tab(text: tml.menuCategory))
        .toList();
  }

  List<Widget> _buildCategoriesDishes() {
    return homeController.restaurantModel.tableMenuList
        .map((TableMenuList tml) => _buildDishes(tml.categoryDishes))
        .toList();
  }

  ListView _buildDishes(List<CategoryDish> dishes) {
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: dishes.length,
        itemBuilder: (context, index) {
          return _buildDish(dishes[index]);
        });
  }

  Container _buildDish(CategoryDish dish) {
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'INR ${dish.dishPrice}',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        '${dish.dishCalories.toInt()} calories',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    dish.dishDescription,
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 16.0,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 16),
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
                  if (dish.addonCat.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text('Customizations available',
                          style: TextStyle(color: Colors.red)),
                    )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image(
                  height: 100.0,
                  width: 100.0,
                  image: AssetImage('assets/images/pulav.jpg'),
                  fit: BoxFit.cover,
                )),
          ),
        ],
      ),
    );
  }

  _showNoOrdersDialog() {
    Get.defaultDialog(
      title: 'There is no order',
      middleText: 'Please select dishes to Order',
      confirm: ElevatedButton(
          style:
              ElevatedButton.styleFrom(primary: Theme.of(context).primaryColor),
          onPressed: () {
            Get.back();
          },
          child: Text('OK')),
    );
  }

  Padding _buildCart() {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          Align(
            alignment: Alignment.center,
            child: IconButton(
                onPressed: () {
                  if (ordersController.orders.isEmpty)
                    _showNoOrdersDialog();
                  else
                    Get.toNamed(RouteList.ordersScreen)
                        .then((value) => setState(() {}));
                },
                icon: Padding(
                  padding: const EdgeInsets.only(right: 24.0),
                  child: FaIcon(
                    FontAwesomeIcons.shoppingCart,
                    color: Colors.grey,
                    size: 30,
                  ),
                )),
          ),
          Material(
            color: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
              child: GetBuilder<OrdersController>(
                builder: (_) {
                  return Text('${ordersController.orders.length}',
                      style: TextStyle(color: Colors.white));
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Shimmer buildCategoryShimmer() {
    return Shimmer(
      color: Colors.grey[400],
      child: Container(height: 50, width: double.infinity),
    );
  }

  ListView buildBodyShimmer() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Shimmer(
              color: Colors.grey[400],
              child: Container(height: 200, width: double.infinity),
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      homeController.getRestaurantData().then((_) {
        _tabController = TabController(
            length: homeController.restaurantModel.tableMenuList.length,
            vsync: this);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        key: _scaffoldKey,
        drawer: MyDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.menu,
              size: 30.0,
              color: Colors.black54,
            ),
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();
            },
          ),
          actions: [_buildCart()],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: GetBuilder<HomeController>(
              builder: (_) {
                return homeController.isDataLoaded &&
                        homeController.restaurantModel != null
                    ? TabBar(
                        isScrollable: true,
                        unselectedLabelColor: Colors.black54,
                        labelColor: Colors.red,
                        tabs: _buildCategories(),
                        controller: _tabController,
                        indicatorColor: Colors.red,
                        indicatorSize: TabBarIndicatorSize.tab,
                      )
                    : buildCategoryShimmer();
              },
            ),
          ),
        ),
        body: GetBuilder<HomeController>(builder: (_) {
          return homeController.isDataLoaded &&
                  homeController.restaurantModel != null
              ? TabBarView(
                  children: _buildCategoriesDishes(),
                  controller: _tabController,
                )
              : buildBodyShimmer();
        }),
      ),
    );
  }
}
