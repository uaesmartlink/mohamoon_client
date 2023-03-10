import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:client_mohamoon/app/modules/widgets/background_container.dart';
import 'package:client_mohamoon/app/utils/constants/style_constants.dart';
import 'package:intl/intl.dart';
import '../../dashboard/views/dashboard_view.dart';
import '../controllers/consultation_date_picker_controller.dart';

class ConsultationDatePickerView
    extends GetView<ConsultationDatePickerController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundContainer(
        text: 'Chose Timeslot'.tr,
        widget: Padding(
          padding: const EdgeInsets.only(bottom: 61),
          child: Column(children: [
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 0),
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 40,
                    )
                  ]),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Chose Date'.tr,
                      style: Constants.titleTextStyle,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: DatePicker(
                      DateTime.now(),
                      initialSelectedDate: DateTime.now(),
                      daysCount: 10,
                      selectionColor: Color(0xFF1b4170),
                      onDateChange: (date) {
                        controller.updateScheduleAtDate(
                            date.day, date.month, date.year);
                        controller.date = date;
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 40,
                    )
                  ]),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Chose Duration'.tr,
                      style:  Constants.titleTextStyle,
                    ),
                  ),
                  DurationTest(controller),
                ],
              ),
            ),
            // Column(
            //   children: [
            //     Container(
            //       margin: EdgeInsets.only(bottom: 10),
            //       alignment: Alignment.centerLeft,
            //       child: Text(
            //         'Chose Duration'.tr,
            //         style: Constants.titleTextStyle,
            //       ),
            //     ),
            //     DurationTest(controller),
            //   ],
            // ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 40,
                      )
                    ]),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Chose Time'.tr,
                        style: Constants.titleTextStyle,
                      ),
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: controller.obx(
                          (timeSlot) => GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 200,
                                    childAspectRatio: 3 / 2,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 20),
                            itemCount: timeSlot!.length,
                            itemBuilder: (BuildContext ctx, index) {
                              var timeStartFormat = DateFormat.Hm()
                                  .format(timeSlot[index].timeSlot!);
                              var timeEnd = timeSlot[index].timeSlot!.add(
                                  Duration(minutes: (controller.durationSelectedIndex + 1) * 15));
                              var timeEndFormat =
                                  DateFormat.Hm().format(timeEnd);
                              if (timeSlot[index].available!) {
                                return InkWell(
                                  onTap: () {
                                    controller.selectedTimeSlot.value =
                                        timeSlot[index];
                                  },
                                  child: Obx(
                                    () => Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        '$timeStartFormat - $timeEndFormat${'\n Available'.tr}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      decoration:
                                          (controller.selectedTimeSlot.value ==
                                                  timeSlot[index])
                                              ? BoxDecoration(
                                                  color: Color(0xFF1b4170),
                                                  border: Border.all(
                                                      color: Color(0xFF76e6da),
                                                      width: 5),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                )
                                              : BoxDecoration(
                                                  color: Color(0xFF76e6da),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                    ),
                                  ),
                                );
                              } else {
                                return Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    '$timeStartFormat - $timeEndFormat${'\n Unavailable'.tr}',
                                    textAlign: TextAlign.center,
                                    style:
                                        GoogleFonts.nunito(color: Colors.white),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[800],
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                onTap: () {
                  if (controller.selectedTimeSlot.value.timeSlotId == null) {
                    Fluttertoast.showToast(msg: 'Please select time slot'.tr);
                  } else {
                    controller.confirm();
                  }
                },
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(bottom: 115),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Color(0xFF1b4170),
                  ),
                  child: Text(
                    'Confirm'.tr,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
      bottomNavigationBar: DashboardView(),
    );
  }
}

class DurationTest extends  StatefulWidget {
  ConsultationDatePickerController controller;

  DurationTest(this.controller);

  @override
  State<DurationTest> createState() => _DurationTest(controller);
}

class _DurationTest extends State<DurationTest>{


  @override
  Widget build(BuildContext context) {
      return InkWell(
        child: Row(
          children: [
            ...List.generate(
              controller.durations.length,
                  (index) => InkWell(
                splashColor: Colors.cyanAccent,
                onTap: () {
                  setState(() {
                    controller.durationSelectedIndex = index;
                    controller.updateList();
                    controller.update();

                  });
                },
                child: Container(
                  padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                    right: 9,
                    left: 9,
                  ),
                  color: index == controller.durationSelectedIndex
                      ? Color(0xFF1b4170)
                      : Colors.white,
                  child: Text(
                    controller.durations[index],
                    style: TextStyle(
                      fontSize: 12,
                      color: index == controller.durationSelectedIndex
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ) ,
      );
  }
   ConsultationDatePickerController controller;
  _DurationTest(this.controller);
}