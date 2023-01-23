import 'package:client_mohamoon/app/models/country_model.dart';
import 'package:get/get.dart';
import 'package:client_mohamoon/app/models/lawyer_category_model.dart';
import 'package:client_mohamoon/app/service/lawyer_category_service.dart';

class LawyerCategoryController extends GetxController
    with StateMixin<List<LawyerCategory>> {
  final count = 0.obs;
  Country country = Get.arguments;

  @override
  void onInit() {
    super.onInit();
    print(country);
    LawyerCategoryService().getListLawyerCategory().then((value) {
      change(value, status: RxStatus.success());
    }).catchError((err) {
      print('error : $err');
      change([], status: RxStatus.error(err.toString()));
    });
  }

  @override
  void onClose() {}

  void increment() => count.value++;
}
