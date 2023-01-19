import 'package:get/get.dart';
import 'package:client_mohamoon/app/models/lawyer_model.dart';

class SearchLawyerController extends GetxController {
  Rx<Lawyer> lawyer = Lawyer().obs;
  final count = 0.obs;

  @override
  void onClose() {}
  void increment() => count.value++;
}
