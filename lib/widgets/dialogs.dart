import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

showLoader(String msg) {
  Get.dialog(Material(
    color: Colors.white,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SpinKitCircle(
          size: 100,
          color: Colors.green,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text('$msg ...',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        )
      ],
    ),
  ));
}

hideLoader() {
  if (Get.isDialogOpen) {
    Get.back();
  }
}

showError(
    {String title = 'Alert!',
    String message = 'Some error occurred',
    onConfirm}) {
  if (Get.isDialogOpen) {
    Get.back();
  }
  Get.defaultDialog(
    barrierDismissible: false,
    title: title,
    middleText: message,
    confirm: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: Colors.green),
        onPressed: onConfirm ??
            () {
              Get.back();
            },
        child: Text('OK')),
  );
}
