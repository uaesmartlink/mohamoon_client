import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:client_mohamoon/app/utils/constants/style_constants.dart';

class LawyerCard extends StatelessWidget {
  final String? lawyerName;
  final String? lawyerSpecialty;
  final String? imageUrl;
  final VoidCallback onTap;
  const LawyerCard(
      {Key? key,
      this.lawyerName,
      this.lawyerSpecialty,
      this.imageUrl,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 100,
            width: double.maxFinite,
            padding: EdgeInsets.fromLTRB(18, 3, 18, 3),
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Image.network(imageUrl!),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          lawyerName!,
                          style: Constants.lawyerNameTextStyle,
                        ),
                      ),
                      Text(
                        lawyerSpecialty!,
                        style: Constants.specialistTextStyle,
                      ),
                      RatingBarIndicator(
                          rating: 4.5,
                          itemCount: 5,
                          itemSize: 20.0,
                          itemBuilder: (context, index) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ))
                    ],
                  ),
                  Expanded(
                    child: InkWell(
                        onTap: onTap,
                        child: Container(
                          height: 50,
                          margin: EdgeInsets.only(left: 10, right: 10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Constants.thirdlyColor,
                              borderRadius: BorderRadius.circular(8)),
                          child: Text(
                            "Book Appointment".tr,
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        )),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
