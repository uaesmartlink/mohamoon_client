import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:client_mohamoon/app/utils/constants/style_constants.dart';

class OnlineLawyerCard extends StatelessWidget {
  final String lawyerPhotoUrl;
  final String lawyerName;
  final List<dynamic> categories;
  final VoidCallback onTap;

  String listToString(List<dynamic> categories) {
    String res = "";
    for (var element in categories) {
      res += "$element, ";
    }
    res = res.substring(0, res.length - 2);

    return res;
  }

  const OnlineLawyerCard({
    Key? key,
    required this.lawyerPhotoUrl,
    required this.lawyerName,
    required this.categories,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 40,
            )
          ]),
      child: IntrinsicHeight(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(13),
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(lawyerPhotoUrl)),
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            height: 17,
                            width: 17,
                            decoration: BoxDecoration(
                                color: Colors.green, shape: BoxShape.circle),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            lawyerName,
                            style: Constants.lawyerNameStyle,
                          ),
                        ),
                      ),
                      Text(
                        listToString(categories),
                        style: TextStyle(
                          color: Color(0xFF0faa9a),
                        ),
                      ),
                      RatingBarIndicator(
                          rating: 4.5,
                          itemCount: 5,
                          itemSize: 20,
                          itemBuilder: (context, index) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              )),
                    ],
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: onTap,
              child: Container(
                alignment: Alignment.center,
                height: 40,
                margin: EdgeInsets.all(13),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  color: Color(0xFF125a9a),
                ),
                child: Text(
                  'Start Consultation'.tr,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
