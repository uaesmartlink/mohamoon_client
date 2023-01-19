import 'package:get/get.dart';
import 'package:client_mohamoon/app/models/lawyer_category_model.dart';
import 'package:client_mohamoon/app/models/lawyer_model.dart';
import 'package:client_mohamoon/app/service/lawyer_service.dart';

class ListLawyerController extends GetxController
    with StateMixin<List<Lawyer>> {
  LawyerCategory lawyerCategory = Get.arguments;
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    //print('lawyer category Name : ${lawyerCategory.categoryName!}');
    LawyerService().getListLawyerByCategory(lawyerCategory).then((value) {
      if (value.isEmpty) return change([], status: RxStatus.empty());
      //print('lawyer : $value');
      change(value, status: RxStatus.success());
    }).catchError((err) {
      change([], status: RxStatus.error(err.toString()));
    });
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
