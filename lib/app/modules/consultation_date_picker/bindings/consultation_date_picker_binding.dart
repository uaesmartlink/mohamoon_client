import 'package:get/get.dart';
import 'package:client_mohamoon/app/service/lawyer_service.dart';

import '../controllers/consultation_date_picker_controller.dart';

class ConsultationDatePickerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConsultationDatePickerController>(
      () => ConsultationDatePickerController(),
    );
    Get.lazyPut<LawyerService>(() => LawyerService());
  }
}
