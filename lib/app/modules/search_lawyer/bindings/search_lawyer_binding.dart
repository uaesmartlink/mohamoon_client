import 'package:get/get.dart';

import '../controllers/search_lawyer_controller.dart';

class SearchLawyerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchLawyerController>(
      () => SearchLawyerController(),
    );
  }
}
