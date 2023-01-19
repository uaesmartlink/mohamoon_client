import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:client_mohamoon/app/modules/list_lawyer/views/widgets/list_lawyer_card.dart';
import 'package:client_mohamoon/app/modules/widgets/empty_list.dart';
import 'package:client_mohamoon/app/utils/constants/constants.dart';

import '../controllers/top_rated_lawyer_controller.dart';

class TopRatedLawyerView extends GetView<TopRatedLawyerController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Lawyer'.tr),
        centerTitle: true,
      ),
      body: Container(
        child: Column(children: [
          Expanded(
            child: controller.obx(
                (listLawyer) => ListView.builder(
                      padding: EdgeInsets.only(top: 10.0),
                      itemCount: listLawyer!.length,
                      itemBuilder: (context, index) {
                        return LawyerCard(
                            lawyerName: listLawyer[index].lawyerName!,
                            lawyerCategory:
                                listLawyer[index].lawyerCategory!.categoryName!,
                            lawyerPrice: currencySign +
                                listLawyer[index].lawyerPrice.toString(),
                            lawyerPhotoUrl: listLawyer[index].lawyerPicture!,
                            lawyerHospital: listLawyer[index].lawyerHospital!,
                            onTap: () {
                              Get.toNamed('/detail-lawyer',
                                  arguments: listLawyer[index]);
                            });
                      },
                    ),
                onEmpty: Center(
                    child: EmptyList(
                        msg: 'No Lawyer Registered in this Category'.tr))),
          )
        ]),
      ),
    );
  }
}
