import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:myfood/controllers/google_auth_controller.dart';
import 'package:myfood/controllers/phone_auth_controller.dart';
import 'package:myfood/widgets/CustomListTile.dart';
import 'package:myfood/widgets/default_profile.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Drawer(
        child: ListView(
          children: [
            Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),
                    ),
                    gradient: LinearGradient(
                        colors: [Colors.green, Colors.lightGreen])),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: user.photoURL == null
                          ? defaultProfile()
                          : CachedNetworkImage(
                              imageUrl: user.photoURL,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => Shimmer(
                                child: defaultProfile(),
                              ),
                              errorWidget: (context, url, error) =>
                                  defaultProfile(),
                            ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            user.displayName == null
                                ? user.phoneNumber
                                : user.displayName,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('ID : ${user.uid}'),
                        )
                      ],
                    )
                  ],
                )),
            CustomListTile(
                title: 'Logout',
                iconData: FontAwesomeIcons.signOutAlt,
                onTap: () {
                  if (user.phoneNumber != null) {
                    Get.put(PhoneAuthController()).logout();
                  } else {
                    Get.put(GoogleAuthController()).logout();
                  }
                },
                color: Colors.grey)
          ],
        ),
      ),
    );
  }
}
