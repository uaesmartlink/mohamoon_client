import 'package:get/get.dart';
import 'package:client_mohamoon/app/models/lawyer_model.dart';
import 'package:client_mohamoon/app/service/lawyer_service.dart';

class TopRatedLawyerController extends GetxController
    with StateMixin<List<Lawyer>> {
  //TODO: Implement TopRatedLawyerController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    LawyerService().getTopRatedLawyer().then((value) {
      change(value, status: RxStatus.success());
    });
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
