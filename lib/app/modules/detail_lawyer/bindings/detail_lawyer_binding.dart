import 'package:get/get.dart';
import 'package:client_mohamoon/app/service/lawyer_service.dart';

import '../controllers/detail_lawyer_controller.dart';

class DetailLawyerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailLawyerController>(
      () => DetailLawyerController(),
    );
    Get.lazyPut<LawyerService>(
      () => LawyerService(),
    );
  }
}
