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
          text: 'Lawyer Specialist'.tr,
          isPadding: 0,
          widget: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: DropdownButtonApp(),
              ),
            ],
          )),
      bottomNavigationBar: DashboardView(),
    );
  }
}
