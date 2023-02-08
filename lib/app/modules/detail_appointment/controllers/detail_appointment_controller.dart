import 'package:client_mohamoon/app/models/appointment_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

//import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:client_mohamoon/app/models/lawyer_model.dart';
import 'package:client_mohamoon/app/models/appointment_detail_model.dart';
import 'package:client_mohamoon/app/models/time_slot_model.dart';
import 'package:client_mohamoon/app/service/notification_service.dart';
import 'package:client_mohamoon/app/service/payment_service.dart';
import 'package:client_mohamoon/app/service/user_service.dart';
import 'package:client_mohamoon/app/service/timeslot_service.dart';
import 'package:client_mohamoon/app/utils/constants/constants.dart';
import 'package:intl/intl.dart';
import '../../balance/views/balance_view.dart';

class DetailAppointmentController extends GetxController {
  final username = ''.obs;
  final UserService userService = Get.find();
  final TimeSlotService timeSlotService = Get.find();
  List<AppointmentDetailModel> appointmentDetail = List.empty();
  dynamic selectedTimeSlot = Get.arguments[0];
  Lawyer lawyer = Get.arguments[1];
  int duration = Get.arguments[2];
  dynamic timeSlots = Get.arguments[3];
  PaymentService paymentService = Get.find();
  NotificationService notificationService = Get.find<NotificationService>();
  late String clientSecret;
  late double price;

  @override
  void onInit() async {
    super.onInit();
    userService.getUsername().then((value) {
      username.value = value;
    });
    price = (lawyer.lawyerPrice)!.toDouble();
    price = price / 4;
  }

  @override
  void onClose() {}

  AppointmentDetailModel buildOrderDetail() {
    if (selectedTimeSlot != null) {
      var formatter = DateFormat('yyyy-MM-dd hh:mm');
      var time = formatter.format(selectedTimeSlot.timeSlot!);

      var appointmentDetail = AppointmentDetailModel(
          itemId: selectedTimeSlot.timeSlotId!,
          itemName: 'Consultation with ${lawyer.lawyerName!}',
          time: time,
          duration: '$duration minute',
          price: currencySign + price.toString());
      return appointmentDetail;
    } else {
      var appointmentDetail = AppointmentDetailModel(
          itemId: "0",
          itemName: 'Consultation with ${lawyer.lawyerName!}',
          time: DateTime.now().toString(),
          duration: '${duration} minute',
          price: currencySign + price.toString());
      return appointmentDetail;
    }
  }

  void makePayment() async {
    EasyLoading.show();
    try {
      String? userId = userService.currentUser!.uid;
      double? balance = await userService.getUserBalance(userId);
      /* print(balance);
      balance = 0;
      print(balance);*/
      if (balance! >= price!) {
        if (selectedTimeSlot != null) {
          await paymentService.makePayment(selectedTimeSlot.timeSlotId!,
              userService.getUserId(), price, duration);
          for (int i = 0; i < timeSlots.length; i++) {
            print(timeSlots[i].timeSlot);
            await timeSlotService.deleteTimeSlot(timeSlots[i]);
          }
          EasyLoading.dismiss();
          Get.offNamed(
            '/payment-success',
            arguments: price,
          );
          notificationService
              .setNotificationAppointment(selectedTimeSlot.timeSlot!);
        } else {
          await paymentService.makePayment(
            "0",
            userService.getUserId(),
            price,
            duration,
          );

          EasyLoading.dismiss();
          print("SSSS");
          print(lawyer.lawyerId);
          Get.offNamed(
            '/appointment-detail',
            arguments: [
              null,
              lawyer,
            ],
          );
        }
      } else {
        Fluttertoast.showToast(msg: 'please charge your balance!');
        EasyLoading.dismiss();
        Get.to(() => BalanceView());
      }
    } catch (err) {
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: err.toString());
      return null;
    }
  }
/*
  void makePayment() async {
    EasyLoading.show();
    try {
      var clientSecret = await paymentService.getClientSecret(
          selectedTimeSlot.timeSlotId!, userService.getUserId());
      if (clientSecret.isEmpty) return;
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        applePay: true,
        googlePay: true,
        testEnv: true,
        merchantCountryCode: 'US',
        merchantDisplayName: 'Helo Lawyer',
        paymentIntentClientSecret: clientSecret,
      ));
      EasyLoading.dismiss();
      await Stripe.instance.presentPaymentSheet();
      Get.offNamed('/payment-success', arguments: selectedTimeSlot);
      //selectedTimeSlot.timeSlot
      notificationService.setNotificationAppointment(selectedTimeSlot.timeSlot!);
    } on StripeException catch (err) {
      Fluttertoast.showToast(msg: err.error.message!);
      return null;
    } catch (err) {
      Fluttertoast.showToast(msg: err.toString());
      return null;
    } finally {}
  }*/
}
