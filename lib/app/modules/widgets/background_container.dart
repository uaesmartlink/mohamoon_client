import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/localization.dart';
import 'package:client_mohamoon/app/utils/constants/style_constants.dart';

class BackgroundContainer extends StatelessWidget {
  final Widget widget;
  final Widget? widgetHead;
  final String text;
  final IconData? icon;
  final VoidCallback? onTap;
  final int? isArrowBack;
  final int? isPadding;

  const BackgroundContainer(
      {Key? key,
      required this.widget,
      required this.text,
      this.widgetHead,
      this.icon,
      this.onTap,
      this.isArrowBack,
      this.isPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          SafeArea(
            child: Container(
              height: 105,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                    Constants.secondaryColor,
                    Constants.primaryColor,
                  ])),
              child: Row(
                children: [
                  if (isArrowBack == null)
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(9)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 7),
                          child:Icon(
                            Icons.arrow_back_ios,
                            color: Color(0xFF1b4170),
                            size: 15,
                          ),
                        ) ,

                      ),
                    ),
                  Text(text,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize:
                              (Get.locale == LocalizationService.locales[0])
                                  ? 18
                                  : 17,
                          fontWeight: FontWeight.w500)),
                  const Spacer(),
                  IconButton(
                    onPressed: onTap,
                    icon: Icon(
                      icon,
                      color: Colors.white,
                      size: 30,
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 111,
            child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding: (isPadding == null)
                    ? EdgeInsets.only(left: 20, right: 20)
                    : null,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: widget
            ),
          ),
        ],
      ),
    );
  }
}
