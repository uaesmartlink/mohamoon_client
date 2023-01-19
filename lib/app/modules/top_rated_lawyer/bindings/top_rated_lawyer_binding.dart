import 'package:get/get.dart';

import '../controllers/top_rated_lawyer_controller.dart';

class TopRatedLawyerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TopRatedLawyerController>(
      () => TopRatedLawyerController(),
    );
  }
}
