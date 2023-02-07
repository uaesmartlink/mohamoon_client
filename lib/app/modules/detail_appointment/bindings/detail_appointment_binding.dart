import 'package:get/get.dart';
import 'package:client_mohamoon/app/service/payment_service.dart';
import '../../../service/timeslot_service.dart';
import '../controllers/detail_appointment_controller.dart';
import '../../balance/controllers/balance_controller.dart';

class DetailAppointmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailAppointmentController>(
      () => DetailAppointmentController(),
    );
    Get.lazyPut<PaymentService>(
      () => PaymentService(),
    );
    Get.lazyPut<TimeSlotService>(
      () => TimeSlotService(),
    );
    Get.lazyPut<BalanceController>(
      () => BalanceController(),
    );
  }
}
