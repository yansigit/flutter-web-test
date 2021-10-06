import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:save_order/model/model.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:save_order/page/orderstatus_page.dart';
import 'package:save_order/state/controllers.dart';
import 'package:save_order/view/pages/bottomNavConnectPages/FindNearStore.dart';

class NowPayment extends StatefulWidget {
  NowPayment({Key? key}) : super(key: key);

  @override
  State<NowPayment> createState() => _NowPaymentState();
}

class _NowPaymentState extends State<NowPayment> {
  final body = box.read("orderJson");

  Future<int> requestOrder() async {
    var res = await http.Client().post(Uri.parse("https://${devMode()}.dalbodre.me/api/Order"),
        body: body, headers: <String, String>{'token': '${userToken}', 'Content-Type': 'application/json'});
    if (res.statusCode == 200) {
      print(res.body);
      print("WELL DONE");
      final data = jsonDecode(res.body);
      if (data["status"] == "succeed") {
        print(data["orderId"]);
        final int orderId = data["orderId"] as int;
        box.write("orderId", orderId);
        return 1;
      } else {
        return 0;
      }
    } else {
      print(body);
      print("Order Failed");
      print("statusCode: ${res.statusCode}");
      return -1;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      requestOrder().then((value) {
        if (value == 1) {
          Get.offAll(NearStoresPage());
          Get.to(() => OrderStatusPage());
          Get.snackbar("결제", "주문이 정상적으로 접수되었습니다.", backgroundColor: Colors.white);
        } else {
          Get.back();
          Get.snackbar("결제", "주문에 실패하였습니다. 다시 시도해주세요..", backgroundColor: Colors.white);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Center(
        child: Text(
          "결제 진행중입니다...",
          style: TextStyle(
            color: Color(0xff00276b),
          ),
        ),
      )),
    );
  }
}
