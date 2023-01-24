import 'package:get/get.dart';
import 'package:client_mohamoon/app/models/lawyer_category_model.dart';
import 'package:client_mohamoon/app/models/lawyer_model.dart';
import 'package:client_mohamoon/app/service/lawyer_service.dart';

import '../../../models/country_model.dart';

class ListLawyerController extends GetxController
    with StateMixin<List<Lawyer>> {
  LawyerCategory lawyerCategory = Get.arguments[0];
  Country country = Get.arguments[1];
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    print("----");
    print(lawyerCategory.categoryName);
    print(country.countryName);
    print("----");

    //print('lawyer category Name : ${lawyerCategory.categoryName!}');
    LawyerService().getListLawyerByCategory(lawyerCategory,country).then((value) {
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
