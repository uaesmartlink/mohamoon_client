import 'package:get/get.dart';

import '../controllers/list_lawyer_controller.dart';

class ListLawyerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListLawyerController>(
      () => ListLawyerController(),
    );
  }
}
