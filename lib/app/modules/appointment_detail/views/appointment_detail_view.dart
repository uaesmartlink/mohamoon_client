import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:client_mohamoon/app/modules/appointment_detail/views/widgets/lawyer_tile.dart';
import 'package:client_mohamoon/app/modules/widgets/background_container.dart';
import 'package:client_mohamoon/app/utils/styles/styles.dart';
import 'package:client_mohamoon/app/utils/timeformat.dart';
import '../../dashboard/views/dashboard_view.dart';
import '../controllers/appointment_detail_controller.dart';
import 'widgets/videocall_button.dart';

class AppointmentDetailView extends GetView<AppointmentDetailController> {
                  /*InkWell(
                        onTap: () => controller.toChatDoctor(),
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                          child: Icon(
                            Icons.message_rounded,
                            color: Colors.white,
                          ),
                        ),
                      )*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundContainer(
        onTap: () {
          // controller.toChatDoctor();
        },
        text: 'Consultation Detail'.tr,
        // icon: Icons.message_rounded,
        widget: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: controller.obx(
              (timeSlot) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Text(
                      'Appointment With'.tr,
                      style: Styles.appointmentDetailTextStyle,
                    ),
                  ),
                  LawyerTile(
                    imgUrl: timeSlot!.lawyer!.lawyerPicture!,
                    name: timeSlot.lawyer!.lawyerName!,
                    appointmentTime: timeSlot.purchaseTime!,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      'Schedule Detail'.tr,
                      style: Styles.appointmentDetailTextStyle,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 8),
                    height: 240,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x04000000),
                            blurRadius: 10,
                            spreadRadius: 10,
                            offset: Offset(0.0, 8.0),
                          )
                        ],
                        color: Colors.white),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Table(
                          children: [
                            TableRow(children: [
                              SizedBox(
                                  height: 50,
                                  child: Text('Appointment Time'.tr)),
                              SizedBox(
                                  height: 50,
                                  child: Text(TimeFormat().formatDate(
                                      controller.selectedTimeslot!.timeSlot!))),
                            ]),
                            TableRow(children: [
                              SizedBox(height: 50, child: Text('Duration'.tr)),
                              SizedBox(
                                  height: 50,
                                  child: Text(
                                      ': ${controller.selectedTimeslot!.bookedDuration}${' Minute'.tr}')),
                            ]),
                            TableRow(
                              children: [
                                SizedBox(
                                  height: 50,
                                  child: Text('Price'.tr),
                                ),
                                SizedBox(
                                  height: 50,
                                  child: Text(
                                    ': \$${controller.selectedTimeslot!.bookedAmount}${' (Paid)'.tr}',
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                SizedBox(
                                  height: 50,
                                  child: Text('Status'.tr),
                                ),
                                SizedBox(
                                  height: 50,
                                  child: Text(
                                    controller.selectedTimeslot!.status ?? '',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Obx(() => VideoCallButton(
                        function: () {
                          controller.startVideoCall();
                        },
                        text: 'Start Consultation'.tr,
                        active: controller.videoCallStatus.value,
                        nonActiveMsg:
                            'the lawyer has canceled the appointment, and your payment has been refunded'
                                .tr,
                      )),
                  controller.selectedTimeslot!.status == 'refund'
                      ? Text(
                          'the lawyer has canceled the appointment, and your payment has been refunded'
                              .tr,
                          style: Styles.greyTextInfoStyle,
                        )
                      : Text(
                          'the start consultation button will be active when the lawyer starts the consultation'
                              .tr,
                          style: Styles.greyTextInfoStyle,
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: DashboardView(),
    );
  }
}
