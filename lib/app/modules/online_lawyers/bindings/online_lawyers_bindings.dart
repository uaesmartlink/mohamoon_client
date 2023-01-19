import 'package:get/get.dart';
import 'package:client_mohamoon/app/service/lawyer_service.dart';
import '../controllers/online_lawyers_controller.dart';

class OnlineLawyersBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnlineLawyersController>(
          () => OnlineLawyersController(),
    );
    Get.lazyPut<LawyerService>(() => LawyerService());
  }
}