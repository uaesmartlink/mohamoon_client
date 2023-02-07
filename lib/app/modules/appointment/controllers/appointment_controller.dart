import 'package:get/get.dart';
import 'package:client_mohamoon/app/models/time_slot_model.dart';
import 'package:client_mohamoon/app/service/timeslot_service.dart';
import 'package:client_mohamoon/app/service/user_service.dart';

import '../../dashboard/controllers/dashboard_controller.dart';
import '../../home/controllers/home_controller.dart';

class AppointmentController extends GetxController
    with StateMixin<List<TimeSlot>> {
  //final count = 0.obs;
  final TimeSlotService _appointmentService = Get.find();
  UserService userService = Get.find();

  @override
  void onInit() async {
    super.onInit();
    getListAppointment();
  }

  @override
  void onClose() {}

  Future<void> getListAppointment() async {
    try {
      var listAppointmentedTimeslot = await _appointmentService
          .getListAppointment(userService.currentUser!);
      if (listAppointmentedTimeslot.isEmpty) {
        return change([], status: RxStatus.empty());
      }
      change(listAppointmentedTimeslot, status: RxStatus.success());
    } catch (err) {
      change([], status: RxStatus.error(err.toString()));
    }
  }

  // todo: confirm go home when book appointment
  Future<bool> toHome() async {
    Get.find<HomeController>;
    return true;
  }
}
