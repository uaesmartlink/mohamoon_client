import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:client_mohamoon/app/modules/list_lawyer/views/widgets/list_lawyer_card.dart';
import 'package:client_mohamoon/app/modules/widgets/empty_list.dart';
import 'package:client_mohamoon/app/utils/constants/constants.dart';

import '../../dashboard/views/dashboard_view.dart';
import '../../widgets/background_container.dart';
import '../controllers/list_lawyer_controller.dart';

class ListLawyerView extends GetView<ListLawyerController> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: BackgroundContainer(
            text:'Lawyers'.tr,
            widget: controller.obx(
                (listLawyer) => Padding(
                  padding: const EdgeInsets.only(bottom: 180),
                  child: ListView.builder(
                        padding: EdgeInsets.only(top: 10.0),
                        itemCount: listLawyer!.length,
                        itemBuilder: (context, index) {
                          return LawyerCard(
                              lawyerName: listLawyer[index].lawyerName!,
                              categories:
                                  listLawyer[index].categories!,
                              lawyerPrice: currencySign +
                                  listLawyer[index].lawyerPrice.toString(),
                              lawyerPhotoUrl: listLawyer[index].lawyerPicture!,
                              lawyerHospital: listLawyer[index].lawyerHospital!,
                              onTap: () {
                                print(listLawyer[index].lawyerName);
                                Get.toNamed('/detail-lawyer',
                                    arguments: listLawyer[index]);
                              });
                        },
                      ),
                ),
                onEmpty: Center(
                    child: EmptyList(
                        msg: 'No Lawyer Registered in this Category'.tr))),

      ),
      bottomNavigationBar: DashboardView(),
    );
  }
}
