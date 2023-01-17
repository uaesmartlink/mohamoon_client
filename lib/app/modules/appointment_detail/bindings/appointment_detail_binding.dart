import 'package:get/get.dart';
import 'package:client_mohamoon/app/service/videocall_service.dart';

import '../controllers/appointment_detail_controller.dart';

class AppointmentDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppointmentDetailController>(
      () => AppointmentDetailController(),
    );
    Get.lazyPut<VideoCallService>(
      () => VideoCallService(),
    );
  }
}
