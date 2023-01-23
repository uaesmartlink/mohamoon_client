import 'package:get/get.dart';
import 'package:client_mohamoon/app/models/country_model.dart';
import 'package:client_mohamoon/app/service/country_service.dart';

class CountryController extends GetxController
    with StateMixin<List<Country>> {
  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    print("Hi");
    CountryService().getListCountry().then((value) {
      print("----");
      print(value);
      print("----");

      change(value, status: RxStatus.success());
    }).catchError((err) {
      change([], status: RxStatus.error(err.toString()));
    });
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
