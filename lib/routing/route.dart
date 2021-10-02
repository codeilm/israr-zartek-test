import 'package:flutter/material.dart';
import 'package:myfood/routing/routes.dart';
import 'package:myfood/screens/error_screen.dart';
import 'package:myfood/screens/home_screen.dart';
import 'package:myfood/screens/login_screen.dart';
import 'package:myfood/screens/orders_screen.dart';
import 'package:myfood/screens/phone_auth_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  final args = settings.arguments;
  switch (settings.name) {
    case RouteList.loginScreen:
      return MaterialPageRoute(builder: (_) => LoginScreen());
    case RouteList.homeScreen:
      return MaterialPageRoute(builder: (_) => HomeScreen());
    case RouteList.ordersScreen:
      return MaterialPageRoute(builder: (_) => OrdersScreen());
    case RouteList.phoneAuthScreen:
      return MaterialPageRoute(builder: (_) => PhoneAuthScreen());
    default:
      return MaterialPageRoute(builder: (_) => ErrorScreen());
  }
}
