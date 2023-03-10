import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:client_mohamoon/app/service/auth_service.dart';
import 'package:client_mohamoon/app/service/user_service.dart';
import '../../../service/payment_service.dart';
import 'dart:async';
import 'dart:io';
import '../../../service/charge_service.dart';
import '../../../models/charge.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_sell_sdk_flutter/go_sell_sdk_flutter.dart';
import '../../../service/charge_service.dart';
import 'package:auto_reload/auto_reload.dart';

class BalanceController extends GetxController {
  var balance = 0.0.obs;
  String userId = '';
  ChargeService chargeService = new ChargeService();
  AuthService authService = Get.find();
  UserService userService = Get.find();
  String bunlde = Platform.isAndroid
      ? "ae.smartlink.client_mohamoon.client_mohamoon"
      : "ae.smartlink.clientmohamoon.clientMohamoon";
  String productionSecreteKey = Platform.isAndroid
      ? "sk_live_wAk2Uj9PrtLfmKG1TblMNZFJ"
      : "sk_live_Oa9fiGtYIFD58mTPoelhwEu4";
  String sandBoxsecretKey = Platform.isAndroid
      ? "sk_test_8GIkirp3fQTmWuEJy1ZtMx9D"
      : "sk_test_nh1BbHeKPk6pz9YMW2IgDN8c";
  String lang = "en";
  String transactionCurrency = "aed";
  TransactionMode trxMode = TransactionMode.PURCHASE;

  @override
  void onInit() async {
    super.onInit();
    print("Hi");

    userId = userService.currentUser!.uid;
    balance.value = (await userService.getUserBalance(userId))!;
  }

  @override
  void onClose() {}

  void changeBalance(String amount) async {
    balance.value = (balance.value + double.parse(amount));
    update();
  }

  void chargeBalance(dynamic tapSDKResult, double amount) async {
    try {
      print("----------------");
      print(tapSDKResult);
      print("----------------");

      String chargeId = tapSDKResult['charge_id'];
      DateTime createdAt = DateTime.now();
      String currency = "aed";
      String status = tapSDKResult["sdk_result"];
      userService.updateUserBalance(userId, amount);
      Charge charge = new Charge(
        chargeId: chargeId,
        userId: userId,
        currency: currency,
        createdAt: createdAt,
        amount: amount,
        status: status,
      );

      await chargeService.chargeBalance(charge);
      balance.value = (await userService.getUserBalance(userId))!;
      update();
      //  await Stripe.instance.initPaymentSheet(
      //     paymentSheetParameters: SetupPaymentSheetParameters(
      //       applePay: true,
      //       googlePay: true,
      //       testEnv: true,
      //       merchantCountryCode: 'US',
      //       merchantDisplayName: 'Helo Lawyer',
      //       paymentIntentClientSecret: clientSecret,
      //     ));
      // await Stripe.instance.presentPaymentSheet();

    } catch (err) {
      Fluttertoast.showToast(msg: err.toString());
      return null;
    } finally {}
  }
}
