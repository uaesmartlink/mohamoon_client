import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:client_mohamoon/app/utils/constants/style_constants.dart';
import '../../../../utils/localization.dart';

class LawyerCard extends StatelessWidget {
  final String lawyerPhotoUrl;
  final String lawyerName;
  final String lawyerHospital;
  final String lawyerPrice;
  final List<dynamic> categories;
  final VoidCallback onTap;

  String listToString(List<dynamic> categories){
    String res = "";

    for (var element in categories) {
      // String value = Get.locale == LocalizationService.locales[0]) ? element.categoryName! : element.categoryTranslation!;
      res += "$element, ";
    }
    res = res.substring(0, res.length - 2);

    return res;
  }

  const LawyerCard(
      {Key? key,
      required this.lawyerPhotoUrl,
      required this.lawyerName,
      required this.lawyerHospital,
      required this.lawyerPrice,
      required this.categories,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("SSS");
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
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            lawyerName,
                            style: Constants.lawyerNameStyle,
                          ),
                        ),
                        TextWithIcon(
                          text: listToString(categories) ,
                          imageAsset: 'assets/icons/Stethoscope.png',
                        ),
                        TextWithIcon(
                          text: lawyerHospital,
                          imageAsset: 'assets/icons/global.png',
                        ),
                        Row(
                          children: [
                            RatingBarIndicator(
                                rating: 4.5,
                                itemCount: 5,
                                itemSize: 20,
                                itemBuilder: (context, index) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    )),
                            const SizedBox(
                              width: 17,
                            ),
                            Text(
                              '$lawyerPrice/hr',
                              style: Constants.priceNumberTextStyle,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: onTap,
              child: Container(
                alignment: Alignment.center,
                height: 40,
                margin: const EdgeInsets.all(13),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  color: Constants.thirdlyColor,
                ),
                child: Text(
                  'Book Consultation'.tr,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextWithIcon extends StatelessWidget {
  const TextWithIcon({Key? key, required this.text, required this.imageAsset})
      : super(key: key);

  final String text;
  final String imageAsset;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          WidgetSpan(
            child: Image.asset(
              imageAsset,
              height: 20,
              width: 20,
              color: Color(0xFF0faa9a),
            ),
          ),
          WidgetSpan(
              child: SizedBox(
            width: 6,
          )),
          TextSpan(
              text: text,
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }


}
