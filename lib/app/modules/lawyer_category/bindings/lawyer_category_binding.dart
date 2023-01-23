import 'package:get/get.dart';

import '../controllers/lawyer_category_controller.dart';
import '../views/wedgets/select_country.dart';

class LawyerCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LawyerCategoryController>(
      () => LawyerCategoryController(),
    );
    Get.lazyPut<DropdownButtonExample>(
      () => DropdownButtonExample(),
    );
  }
}
