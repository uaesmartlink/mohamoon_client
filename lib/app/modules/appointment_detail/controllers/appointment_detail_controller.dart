import 'dart:async';

import 'package:client_mohamoon/app/service/user_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:client_mohamoon/app/models/lawyer_model.dart';
import 'package:client_mohamoon/app/models/appointment_model.dart';
import 'package:client_mohamoon/app/models/time_slot_model.dart';
import 'package:client_mohamoon/app/service/lawyer_service.dart';
import 'package:client_mohamoon/app/service/appointment_service.dart';
import 'package:client_mohamoon/app/service/videocall_service.dart';
import 'package:client_mohamoon/app/service/notification_service.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
class AppointmentDetailController extends GetxController
    with StateMixin<TimeSlot> {
  NotificationService notificationService = Get.find<NotificationService>();

  final count = 0.obs;
  VideoCallService videoCallService = Get.find();
  var videoCallStatus = true.obs;

  //ParseObject? room;
  dynamic selectedTimeslot = Get.arguments[0];
  Lawyer lawyer = Get.arguments[1];
  late Appointment appointment;
  late String token;
  var database = FirebaseDatabase.instance.ref();
  late StreamSubscription _roomStreaming;
  var active = true.obs;

  @override
  void onInit() async {
    super.onInit();
    print("AAA");
    if (selectedTimeslot != null) {
      print("CCC");
      LawyerService().getLawyerDetail(selectedTimeslot.lawyerid!).then(
            (doc) {
          selectedTimeslot.lawyer = doc;
          change(selectedTimeslot, status: RxStatus.success());
          if (selectedTimeslot.status == 'refund') {
            Get.defaultDialog(
              title: 'Appointment Canceled'.tr,
              content: Text(
                  'the lawyer has canceled the appointment, and your payment has been refunded'
                      .tr),
              onConfirm: () {
                Get.back();
              },
            );
          }
        },
      );
    } else {
      LawyerService().getLawyerById(lawyer.lawyerId.toString()).then(
            (doc) {
          selectedTimeslot = TimeSlot(
            timeSlot: DateTime.now(),
            lawyer: lawyer,
            timeSlotId: DateTime.now().hashCode.toString(),
            price: (lawyer.lawyerPrice! / 4).toDouble(),
            lawyerid: lawyer.lawyerId,
            duration: 15,
            purchaseTime: DateTime.now(),
          );
          change(selectedTimeslot, status: RxStatus.success());
        },
      );
    }


    var roomSnapshot = FirebaseFirestore.instance
        .collection('RoomVideoCall')
        .doc(DateTime.now().hashCode.toString())
        .snapshots();

    _roomStreaming = roomSnapshot.listen((event) async {
      if (event.data() == null) {
        videoCallStatus.value = true;
      } else {
        await Future.delayed(const Duration(seconds: 3), () {
          videoCallStatus.value = true;
          token = event.data()!['token'];
          printInfo(info: 'token : $token');
        });
      }
    });
  }

  @override
  void onClose() {
    _roomStreaming.cancel();
  }

  void startVideoCall() async {
    if (videoCallStatus.value) {
      token =
      await VideoCallService().getAgoraToken(DateTime.now().hashCode.toString());
      print(token);
      final roomData = <String, dynamic>{
        'room': selectedTimeslot.timeSlotId,
        'token': token,
        'timestamp': Timestamp.fromDate(DateTime.now())
      };

      await VideoCallService().createRoom(selectedTimeslot.timeSlotId!, roomData);

      notificationService.notificationStartAppointment(
          selectedTimeslot.lawyer!.lawyerName!,
          UserService().getUserId(),
          selectedTimeslot.timeSlotId!,
          token,
          selectedTimeslot.timeSlotId!);
      Get.toNamed('/video-call', arguments: [
        {
          'timeSlot': selectedTimeslot,
          'room': selectedTimeslot.timeSlotId,
          'token': token
        }
      ]);
    } else {
      if (selectedTimeslot.status == 'refund') {
        Fluttertoast.showToast(
            msg:
            'the lawyer has canceled the appointment, and your payment has been refunded'
                .tr,
            toastLength: Toast.LENGTH_LONG);
      } else {
        Fluttertoast.showToast(
            msg:
            'the lawyer has not started the meeting session, this button will automatically turn on when the lawyer has started it'
                .tr,
            toastLength: Toast.LENGTH_LONG);
      }
    }
  }

  toConsultationConfirm() {
    Get.toNamed('/consultation-confirm', arguments: selectedTimeslot);
  }

  Future getOrder() async {
    try {
      appointment = await AppointmentService().getSuccessAppointment(selectedTimeslot);
    } catch (err) {
      Fluttertoast.showToast(msg: err.toString());
    }
  }

  void rescheduleAppointment() {
    Get.toNamed('/consultation-date-picker',
        arguments: [selectedTimeslot.lawyer, selectedTimeslot]);
  }

  void toChatDoctor() async {
    // String lawyerUserId = await LawyerService().getUserId(lawyer);
    print(lawyer.lawyerId);
    print(lawyer.lawyerName);
    print(lawyer.lawyerPicture);
    if (lawyer.lawyerId!.isEmpty) {
      Fluttertoast.showToast(msg: 'Lawyer no longger exist'.tr);
      return;
    }
    final otherUser = types.User(
      id: lawyer.lawyerId!,
      firstName: lawyer.lawyerName,
      imageUrl: lawyer.lawyerPicture,
    );

    final room = await FirebaseChatCore.instance.createRoom(
      otherUser,
    );
    Get.toNamed('/chat', arguments: [room, lawyer]);
  }

}
