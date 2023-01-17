import 'package:get/get.dart';
import 'package:client_mohamoon/app/service/doctor_service.dart';

import '../controllers/detail_doctor_controller.dart';

class DetailDoctorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailDoctorController>(
      () => DetailDoctorController(),
    );
    Get.lazyPut<DoctorService>(
      () => DoctorService(),
    );
  }
}
