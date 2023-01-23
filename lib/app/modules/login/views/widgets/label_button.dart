import 'package:flutter/material.dart';
import 'package:client_mohamoon/app/utils/styles/styles.dart';
import 'package:client_mohamoon/app/utils/constants/style_constants.dart';

class LabelButton extends StatelessWidget {
  const LabelButton(
      {Key? key, required this.onTap, required this.title, this.subTitle = ''})
      : super(key: key);
  final VoidCallback onTap;
  final String title;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              subTitle,
              style: TextStyle(
                  color: Constants.mFillColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w900),
            ),
          ],
        ),
      ),
    );
  }
}
