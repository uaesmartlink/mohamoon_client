import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:client_mohamoon/app/utils/styles/styles.dart';
import 'package:client_mohamoon/app/utils/constants/style_constants.dart';

// ignore: must_be_immutable
class VideoCallButton extends Container {
  final VoidCallback function;
  final String text;
  @override
  // ignore: overridden_fields
  final Color color;
  final Color textColor;
  final Color splashColor;
  final double fontSize;
  bool active;
  final String nonActiveMsg;

  VideoCallButton(
      {super.key, required this.function,
        required this.text,
        this.splashColor = Colors.blueGrey,
        this.fontSize = 16,
        this.color = Constants.primaryColor,
        this.textColor = Constants.secondaryColor,
        this.active = false,
        required this.nonActiveMsg});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: active
          ? function
          : () {
        Fluttertoast.showToast(msg: nonActiveMsg);
      },
      child: Container(
        width: Get.width,
        padding: const EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: const Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: active == true
                ? [Constants.secondaryColor, Constants.primaryColor]
                : [Colors.grey, Colors.grey],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.video_call_rounded,
              color: Colors.white,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              text,
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
