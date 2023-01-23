import 'package:flutter/material.dart';
import 'package:client_mohamoon/app/utils/constants/style_constants.dart';

class LogContainer extends StatelessWidget{

  final Widget? widget;
  const LogContainer({Key? key,@required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height:MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          gradient:const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Constants.secondaryColor,
                Constants.primaryColor,
              ]
          )
      ),
      child: widget,
    );
  }
}