import 'package:get/get.dart';
import 'package:client_mohamoon/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:client_mohamoon/app/service/auth_service.dart';
import 'package:client_mohamoon/app/service/user_service.dart';
import '../../../service/notification_service.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<DashboardController>(
          () => DashboardController(),
    );
    Get.lazyPut<NotificationService>(
          () => NotificationService(),
    );
    Get.put(AuthService());
    Get.put(UserService());
  }
}
