import 'package:get/get.dart';
import 'package:client_mohamoon/app/modules/appointment/controllers/appointment_controller.dart';
import 'package:client_mohamoon/app/modules/balance/controllers/balance_controller.dart';
import 'package:client_mohamoon/app/modules/home/controllers/home_controller.dart';
import 'package:client_mohamoon/app/modules/profile/controllers/profile_controller.dart';
import 'package:client_mohamoon/app/service/notification_service.dart';
import 'package:client_mohamoon/app/service/timeslot_service.dart';
import 'package:client_mohamoon/app/service/auth_service.dart';
import 'package:client_mohamoon/app/service/user_service.dart';
import '../controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthService());
    Get.lazyPut<DashboardController>(
      () => DashboardController(),
    );
    Get.lazyPut<NotificationService>(
      () => NotificationService(),
    );
    Get.lazyPut<UserService>(() => UserService());
    Get.put(HomeController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<BalanceController>(() => BalanceController());
    Get.lazyPut<AppointmentController>(() => AppointmentController());
    Get.lazyPut<TimeSlotService>(() => TimeSlotService());
  }
}
