import 'package:get/get.dart';
import 'package:client_mohamoon/app/service/doctor_service.dart';
import '../controllers/online_doctors_controller.dart';

class OnlineDoctorsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnlineDoctorsController>(
          () => OnlineDoctorsController(),
    );
    Get.lazyPut<DoctorService>(() => DoctorService());
  }
}