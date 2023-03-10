import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:client_mohamoon/app/utils/styles/styles.dart';
import 'package:client_mohamoon/app/utils/timeformat.dart';

class LawyerTile extends StatelessWidget {
  const LawyerTile({
    Key? key,
    required this.imgUrl,
    required this.name,
    required this.appointmentTime,
  }) : super(key: key);

  final String imgUrl;
  final String name;
  final DateTime appointmentTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      height: 68,
      width: double.infinity,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: Color(0x04000000),
                blurRadius: 10,
                spreadRadius: 10,
                offset: Offset(0.0, 8.0))
          ],
          color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            width: 12,
          ),
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Styles.whiteGreyColor,
              image: DecorationImage(
                image: NetworkImage(imgUrl),
              ),
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  name,
                  style: GoogleFonts.nunito(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
                FittedBox(
                  child: Text(
                    'Appointment at : '.tr +
                        TimeFormat().formatDate(appointmentTime.toLocal()),
                    style: GoogleFonts.nunito(
                        fontWeight: FontWeight.w700, color: Colors.grey),
                    maxLines: 2,
                    softWrap: false,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 15,
          )
        ],
      ),
    );
  }
}
