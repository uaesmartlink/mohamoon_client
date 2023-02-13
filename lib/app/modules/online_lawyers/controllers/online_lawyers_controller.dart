import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:client_mohamoon/app/models/lawyer_model.dart';
import 'package:client_mohamoon/app/models/time_slot_model.dart';
import 'package:client_mohamoon/app/service/lawyer_service.dart';
import 'package:client_mohamoon/app/utils/number_format.dart';
import 'package:intl/intl.dart';

class OnlineLawyersController extends GetxController
    with StateMixin<List<Lawyer>> {
  List<Lawyer> allLawyer = [];
  List<TimeSlot> timeSlotOfLawyers = [];
  List<String> names = [];

  //List<TimeSlot> allTimeSlot = [];
  var selectedBottomSheetButton = 3.obs;

  double? price = 2.5;
  int? duration = 0;

  @override
  void onInit() async {
    super.onInit();
    getOnlineLawyers();
  }

  Future<void> getOnlineLawyers() async {
    print("Hiii");
    allLawyer = await LawyerService().getOnlineLawyers();
    change(allLawyer, status: RxStatus.success());
  }

  Future<void> getLawyerOnline() async {
    List<Lawyer> allLawyerNow = [];
    List<TimeSlot> timeSlotOfLawyersNow = [];
    int cnt = 0;
    LawyerService().getAllLawyerTimeSlotNow().then((timeSlot) {
      for (int i = 0; i < timeSlot.length; i++) {
        var timeSlotFormat = DateFormat.yMd().format(timeSlot[i].timeSlot!);
        var hourSlotFormat = DateFormat.H().format(timeSlot[i].timeSlot!);
        var minutesSlotFormat =
        int.parse(DateFormat.m().format(timeSlot[i].timeSlot!));
        var minuteSlotFormat = timeSlot[i].duration! + minutesSlotFormat;

        if (minutesSlotFormat > 59) {
          minutesSlotFormat = minutesSlotFormat - 60;
          hourSlotFormat = (int.parse(hourSlotFormat) + 1).toString();
        }
        var timeNowFormat = DateFormat.yMd().format(DateTime.now());
        var hourNowFormat = DateFormat.H().format(DateTime.now());
        var minuteNowFormat = int.parse(DateFormat.m().format(DateTime.now()));

        if (timeNowFormat == timeSlotFormat &&
            hourNowFormat == hourSlotFormat &&
            minuteNowFormat < minuteSlotFormat) {
          timeSlotOfLawyersNow.add(timeSlot[i]);

          LawyerService().getLawyerDetail(timeSlot[i].lawyerid!).then((lawyer) {
            // names.add(lawyer.lawyerName!);

            allLawyerNow.forEach((element) {
              if (element.lawyerName == lawyer.lawyerName) return;
              allLawyerNow.add(lawyer);
            });
            if (allLawyer.isEmpty) {
              allLawyerNow.add(lawyer);
            }
            /* print(lawyer.lawyerName);
            if (names.contains(lawyer.lawyerName)) {
              names.add(lawyer.lawyerName!);
              allLawyerNow.add(lawyer);
            }*/
            change(allLawyerNow, status: RxStatus.success());
          });
        }
      }
      change([], status: RxStatus.empty());
    }).onError((error, stackTrace) {
      change([], status: RxStatus.error(error.toString()));
    });
    allLawyer = allLawyerNow;
    timeSlotOfLawyers = timeSlotOfLawyersNow;
  }

  calculatePrice(selectedDuration, timeslot, timeslotDuration, timeslotPrice) {
    return 2.5;
    // bool acceptDuration=calculateTime(selectedDuration, timeslot, timeslotDuration);
    // if(acceptDuration) {
    //   switch (selectedDuration) {
    //     case(15):
    //       {
    //         switch (timeslotDuration) {
    //           case(15):
    //             {
    //               return price = timeslotPrice;
    //             }
    //           case(30):
    //             {
    //               return price = NumberFormatted().formatNumber(timeslotPrice / 2);
    //             }
    //           case(45):
    //             {
    //               return price = NumberFormatted().formatNumber(timeslotPrice / 3);
    //             }
    //           case(60):
    //             {
    //               return price = NumberFormatted().formatNumber(timeslotPrice / 4);
    //             }
    //         }
    //         break;
    //       }
    //     case(30):
    //       {
    //         switch (timeslotDuration) {
    //           case(30):
    //             {
    //               return price = timeslotPrice ;
    //             }
    //           case(45):
    //             {
    //               return price = NumberFormatted().formatNumber(timeslotPrice / 1.5);
    //             }
    //           case(60):
    //             {
    //               return price = NumberFormatted().formatNumber(timeslotPrice / 2);
    //             }
    //         }
    //         break;
    //       }
    //     case(45):
    //       {
    //         switch (timeslotDuration) {
    //           case(45):
    //             {
    //               return price = timeslotPrice ;
    //             }
    //           case(60):
    //             {
    //               return price = NumberFormatted().formatNumber(timeslotPrice / 1.25);
    //             }
    //         }
    //         break;
    //       }
    //   }
    // }else{
    //   Fluttertoast.showToast(msg: 'You cant book this duration,not enough time'.tr);
    // }
  }

  calculateTime(
      selectedDuration,
      timeslot,
      timeslotDuration,
      ) {
    return 0;
    /* var minuteNowFormat = int.parse(
        DateFormat.m().format(DateTime.now()));
    var minuteSelected = minuteNowFormat + selectedDuration;
    var minutesSlotFormat = int.parse(
        DateFormat.m().format(timeslot));
    var minuteSlot = timeslotDuration + minutesSlotFormat;
    if (minuteSlot > 59) {
      minuteSlot = minuteSlot - 60;
      if (minuteSelected > 59) {
        minuteSelected = minuteSelected - 60;
        if(minuteSelected<=minuteSlot) {
          return true;
        } else {
          return false;
        }
      } else {
        return true;
      }
    } else{
      if (minuteSelected < 59) {
        if(minuteSelected<=minuteSlot) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    }*/
  }

  onTap(
      int selected,
      price,
      duration,
      // timeslot,
      // timeslotDuration,
      ) {
    if (price != 0) {
      // timeSlotOfLawyers[selected].price = price;
      // timeSlotOfLawyers[selected].duration = duration;
      Get.toNamed(
        '/appointment-detail',
        arguments: [
          null,
          allLawyer[selected],
          15,
        ],
      );
    } else {
      Fluttertoast.showToast(msg: 'please chose duration'.tr);
    }
  }

  @override
  void onClose() {}
}
