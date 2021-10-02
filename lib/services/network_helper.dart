import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:myfood/widgets/dialogs.dart';

Future getData() async {
  Uri uri = Uri.parse('https://www.mocky.io/v2/5dfccffc310000efc8d2c1ad');
  try {
    var res = await http.get(uri);
    if (res.statusCode != 200) {
      showError(
          title: 'Error occurred',
          message: 'Check Internet Connection and try again');
    }

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    }
  } on SocketException {
    showError(
        title: 'Internet issue',
        message: 'Check Internet Connection and try again',
        onConfirm: () {
          Get.close(1);
          getData();
        });
  } catch (e) {
    showError();
  }
  return [];
}
