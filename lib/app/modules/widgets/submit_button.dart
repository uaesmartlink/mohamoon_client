import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:client_mohamoon/app/utils/constants/style_constants.dart';

Widget submitButton({required VoidCallback onTap, required String text}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      width: Get.width/1.3,
      padding: EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Constants.thirdlyColor,
          borderRadius: BorderRadius.all(Radius.circular(17)),
          ),
      child: Text(
        text,
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    ),
  );
}
