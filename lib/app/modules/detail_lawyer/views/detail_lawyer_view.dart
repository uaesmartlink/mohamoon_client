import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:client_mohamoon/app/modules/dashboard/views/dashboard_view.dart';
import 'package:client_mohamoon/app/modules/widgets/background_container.dart';
import '../../../utils/constants/constants.dart';
import '../../list_lawyer/views/widgets/list_lawyer_card.dart';
import '../controllers/detail_lawyer_controller.dart';

class DetailLawyerView extends GetView<DetailLawyerController> {
  @override
  Widget build(BuildContext context) {
    print("XXX");
    return Scaffold(
      body: BackgroundContainer(
        text: 'Lawyer'.tr,
        widget: controller.obx(
          (lawyer) => Container(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LawyerCard(
                  lawyerName: lawyer!.lawyerName!,
                  categories: lawyer.categories!,
                  lawyerPrice: currencySign + lawyer.lawyerPrice.toString(),
                  lawyerPhotoUrl: lawyer.lawyerPicture!,
                  lawyerHospital: lawyer.lawyerHospital!,
                  onTap: () {
                    Get.toNamed('/consultation-date-picker',
                        arguments: [controller.selectedLawyer, null]);
                  },
                ),
                const SizedBox(
                  height: 34,
                ),
                Text(
                  'Service'.tr,
                  style: const TextStyle(
                      fontSize: 18,
                      color: Color(0xFF333333),
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 17,
                ),
                Text(
                  lawyer.lawyerShortBiography!,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF333333),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: DashboardView(),
    );
  }
}
