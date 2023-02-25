import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:client_mohamoon/app/modules/widgets/background_container.dart';
import '../../dashboard/views/dashboard_view.dart';
import '../controllers/country_controller.dart';
import '../../../utils/localization.dart';
import 'package:client_mohamoon/app/utils/constants/style_constants.dart';

class CountryView extends GetView<CountryController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundContainer(
        text: 'Select Country'.tr,
        isPadding: 0,
        widget:
            Padding(
              padding: EdgeInsets.all(20),
              child: controller.obx(
                    (listCountry) => Padding(
                  padding: const EdgeInsets.only(bottom: 170),
                  child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(10),
                      itemCount: listCountry!.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        childAspectRatio: 1,
                      ),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Get.toNamed('/lawyer-category',
                                arguments: listCountry[index]);
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 10,
                                  )
                                ]),
                            child: Column(
                              children: [
                                Expanded(
                                    flex: 5,
                                    child: Container(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: CachedNetworkImage(
                                          imageUrl: listCountry[index].iconUrl!),
                                    )),
                                Expanded(
                                  flex: 4,
                                  child: Container(
                                    padding: EdgeInsets.only(top: 20),
                                    child: Text(
                                      (Get.locale == LocalizationService.locales[0])
                                          ? listCountry[index].countryName!
                                          : listCountry[index].countryTranslation!,
                                      style: Constants.lawyerCategoryTextStyle,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ),
        ),
      bottomNavigationBar: DashboardView(),
    );
  }
}
/*
      Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: controller.obx(
                    (listCountry) => Padding(
                  padding: const EdgeInsets.only(bottom: 170),
                  child: GridView.builder(
                      padding: const EdgeInsets.all(10),
                      itemCount: listCountry!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        childAspectRatio: 3 / 4,
                      ),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Get.toNamed('/lawyer_category',
                                arguments: listCountry[index]);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 10,
                                  )
                                ]),
                            child: Column(
                              children: [
                                Expanded(
                                    flex: 5,
                                    child: Container(
                                      child: CachedNetworkImage(
                                          imageUrl: listCountry[index].iconUrl!),
                                    )),
                                Expanded(
                                  flex: 4,
                                  child: Container(
                                    padding: EdgeInsets.only(top: 20),
                                    child: Text(
                                      (Get.locale == LocalizationService.locales[0])
                                          ? listCountry[index].countryName!
                                          : listCountry[index].countryTranslation!,
                                      style: Constants.lawyerCategoryTextStyle,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ),
          ],
        ),
        */
