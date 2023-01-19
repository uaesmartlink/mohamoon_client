import 'package:get/get.dart';

import '../controllers/lawyer_category_controller.dart';

class LawyerCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LawyerCategoryController>(
      () => LawyerCategoryController(),
    );
  }
}
