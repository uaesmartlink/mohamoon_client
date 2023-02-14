import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:client_mohamoon/app/modules/widgets/background_container.dart';
import 'package:client_mohamoon/app/utils/constants/style_constants.dart';
import '../../../utils/localization.dart';
import '../../dashboard/views/dashboard_view.dart';
import '../controllers/lawyer_category_controller.dart';
import './wedgets/select_country.dart';

class LawyerCategoryView extends GetView<LawyerCategoryController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundContainer(
          text: 'Lawyer Specialist in ${controller.country.countryName}'.tr,
          isPadding: 0,
          widget:
              Padding(
                padding: EdgeInsets.all(20),
                child: controller.obx(
                  (listCategory) => Padding(
                    padding: const EdgeInsets.only(bottom: 200),
                    child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(20),
                        itemCount: listCategory!.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          childAspectRatio: 3 / 4,
                        ),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Get.toNamed('/list-lawyer', arguments: [
                                listCategory[index],
                                controller.country
                              ]);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
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
                                            imageUrl:
                                                listCategory[index].iconUrl!),
                                      )),
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      padding: EdgeInsets.only(top: 20),
                                      child: Text(
                                        (Get.locale ==
                                                LocalizationService.locales[0])
                                            ? listCategory[index].categoryName!
                                            : listCategory[index]
                                                .categoryTranslation!,
                                        style:
                                            Constants.lawyerCategoryTextStyle,
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
              ),),
      bottomNavigationBar: DashboardView(),
    );
  }
}
