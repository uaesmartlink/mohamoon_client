import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:client_mohamoon/app/models/lawyer_model.dart';
import 'package:client_mohamoon/app/models/review_model.dart';
import 'package:client_mohamoon/app/service/lawyer_service.dart';
import 'package:client_mohamoon/app/service/review_service.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class DetailLawyerController extends GetxController with StateMixin<Lawyer> {
  final count = 0.obs;
  Lawyer selectedLawyer = Get.arguments;
  List<ReviewModel> listReview = [];
  @override
  void onInit() {
    super.onInit();
    ReviewService().getLawyerReview(lawyer: selectedLawyer).then((value) {
      listReview = value;
      change(selectedLawyer, status: RxStatus.success());
    });
  }

  @override
  void onClose() {}
  void increment() => count.value++;



  void toChatLawyer() async {
    String lawyerUserId = await LawyerService().getUserId(selectedLawyer);
    if (lawyerUserId.isEmpty) {
      Fluttertoast.showToast(msg: 'Lawyer no longger exist'.tr);
      return;
    }
    final otherUser = types.User(
        id: lawyerUserId,
        displayName: selectedLawyer.lawyerName,
        imageUrl: selectedLawyer.lawyerPicture);
    final room = await FirebaseChatCore.instance.createRoom(otherUser);
    Get.toNamed('/chat', arguments: [room, selectedLawyer]);
  }
}
