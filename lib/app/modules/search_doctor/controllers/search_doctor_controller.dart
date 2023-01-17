import 'package:get/get.dart';
import 'package:client_mohamoon/app/models/doctor_model.dart';

class SearchDoctorController extends GetxController {
  Rx<Doctor> doctor = Doctor().obs;
  final count = 0.obs;

  @override
  void onClose() {}
  void increment() => count.value++;
}
