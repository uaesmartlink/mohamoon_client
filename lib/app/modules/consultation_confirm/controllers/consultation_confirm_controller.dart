import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:client_mohamoon/app/models/time_slot_model.dart';
import 'package:client_mohamoon/app/service/appointment_service.dart';
import 'package:client_mohamoon/app/service/problem_service.dart';
import 'package:client_mohamoon/app/service/timeslot_service.dart';

class ConsultationConfirmController extends GetxController {
  TimeSlot timeSlot = Get.arguments[0];
  String timeSlotId = Get.arguments[1];
  var problemVisible = false.obs;

  @override
  void onClose() {}

  sendProblem(String problem) {
    EasyLoading.show();
    ProblemService().sendProblem(problem, timeSlot).then((value) {
      Get.back();
      Get.defaultDialog(
          title: 'Info'.tr,
          onConfirm: () => Get.back(),
          middleText: 'Payment for '.tr +
              timeSlot.lawyer!.lawyerName! +
              ' will be delayed until the problem is resolved'.tr);
      EasyLoading.dismiss();
    });
  }

  confirmConsultation() async {
    try {
      EasyLoading.show();
      print("#####");
      print(timeSlotId);
      await TimeSlotService().updateTimeslotAvailable(timeSlotId);
      print("****");
      await AppointmentService().confirmAppointment(timeSlot,timeSlotId);
      print("----");
      EasyLoading.dismiss();
      Get.offNamedUntil('/review', ModalRoute.withName('/appointment-detail'),
          arguments: timeSlot);
      print("++++");
    } catch (e) {
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
