import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:myfood/controllers/google_auth_controller.dart';
import 'package:myfood/routing/routes.dart';
import 'package:myfood/screens/home_screen.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text(
              'Something went wrong\nPlease check your Internet connection',
              textAlign: TextAlign.center,
            ));
          } else if (snapshot.hasData) {
            return HomeScreen();
          }
          return loginWidget();
        });
  }
}

Scaffold loginWidget() {
  return Scaffold(
    body: SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Hero(
              tag: 'logo',
              child: Image.asset(
                'assets/images/firebase.png',
              ),
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.put(GoogleAuthController()).login();
                  },
                  child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(50)),
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Image.asset(
                                'assets/images/google.png',
                                fit: BoxFit.contain,
                                scale: 5,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Google',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox()
                        ],
                      )),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteList.phoneAuthScreen);
                  },
                  child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(50)),
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.phoneAlt,
                            color: Colors.white,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Phone',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox()
                        ],
                      )),
                )
              ],
            )
          ],
        ),
      ),
    ),
  );
}
