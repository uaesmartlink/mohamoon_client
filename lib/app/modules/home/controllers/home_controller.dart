import 'package:flutter_easyloading/flutter_easyloading.dart';

//import 'package:flutter_stripe/flutter_stripe.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:client_mohamoon/app/models/charge.dart';
import 'package:client_mohamoon/app/service/auth_service.dart';
import 'package:client_mohamoon/app/service/carousel_service.dart';
import 'package:client_mohamoon/app/service/user_service.dart';
import '../../../service/notification_service.dart';
// import '../../../service/charge_service.dart';

import '../../dashboard/controllers/dashboard_controller.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  NotificationService notificationService = Get.find<NotificationService>();
  // ChargeService chargeService = new ChargeService();
  final caoruselIndex = 0.obs;

  get getcaoruselIndex => caoruselIndex.value;
  AuthService authService = Get.find();
  UserService userService = Get.find();
  var userPicture = ''.obs;
  List<String?> listImageCarousel = [];

  @override
  void onInit() async {
    super.onInit();
    print("Hello");
    EasyLoading.instance.maskType = EasyLoadingMaskType.black;
    userPicture.value = userService.getProfilePicture()!;
    listImageCarousel = await CarouselService().getListCarouselUrl();
    //print('jumlah image carousel : ${listImageCarousel.length}');
    update();
  }

  @override
  void onClose() {}


  void carouselChange(int index) {
    caoruselIndex.value = index;
  }

  void logout() async {
    authService.logout().then((value) => Get.toNamed('/login'));
  }

  void toProfile() {
    Get.find<DashboardController>().selectedIndex = 3;
    Get.toNamed('/profile');
  }

  void testNotify() {
    notificationService.testNotification();
  }

  // void testViedoNotify() {
  //   notificationService.testVideoNotification();
  // }

  void toOnlineLawyers() {
    Get.toNamed('/online_lawyers');
  }

  void toCountry() {
    Get.toNamed('/country');
  }

  void toTopRatedLawyer() {
    Get.toNamed('/top-rated-lawyer');
  }

  void toSearchLawyer() {
    Get.toNamed('/search-lawyer');
  }
}
