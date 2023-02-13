import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:client_mohamoon/app/modules/online_lawyers/controllers/online_lawyers_controller.dart';
import 'package:client_mohamoon/app/modules/online_lawyers/views/widgets/custom_button.dart';
import 'package:client_mohamoon/app/modules/online_lawyers/views/widgets/online_lawyer_card.dart';
import '../../dashboard/views/dashboard_view.dart';
import '../../widgets/background_container.dart';
import '../../widgets/empty_list.dart';
import 'package:intl/intl.dart';

class OnlineLawyersView extends GetView<OnlineLawyersController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () {
          return controller.getOnlineLawyers();
        },
        child: BackgroundContainer(
          text: 'Online Lawyers'.tr,
          widget: controller.obx(
                  (onlineLawyers) => ListView.builder(
                padding: EdgeInsets.only(top: 10.0),
                itemCount: onlineLawyers!.length,
                itemBuilder: (context, index) {
                  return OnlineLawyerCard(
                      lawyerPhotoUrl: onlineLawyers[index].lawyerPicture!,
                      lawyerName: onlineLawyers[index].lawyerName!,
                      categories: onlineLawyers[index].categories!,
                      onTap: () {
                        // var timeslot=controller.timeSlotOfLawyers[index].timeSlot;
                        // int duration=controller.timeSlotOfLawyers[index].duration!;
                        // double price= controller.timeSlotOfLawyers[index].price!;
                        viewBottomSheet(
                          context,
                          onlineLawyers[index].lawyerPrice! / 4,
                          // timeslot,
                          15,
                          index,
                        );
                      });
                },
              ),
              onEmpty: Center(child: EmptyList(msg: 'No Online Lawyers'.tr))),
        ),
      ),
      bottomNavigationBar: DashboardView(),
    );
  }

  viewBottomSheet(
      context,
      price,
      // timeslot,
      duration,
      index,
      ) {
    return showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        context: context,
        builder: (BuildContext c) {
          // var timeAvailable = controller.timeSlotOfLawyers[index].timeSlot!.add(
          //     Duration(minutes: controller.timeSlotOfLawyers[index].duration!));
          // var timeAvailableFormat = DateFormat.Hm().format(timeAvailable);
          return FractionallySizedBox(
            heightFactor: 0.5,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: SizedBox(
                height: 300,
                child: Column(
                  children: [
                    /*  Text(
                        'Choose a duration for consulting '.tr,
                        style: TextStyle(
                          fontSize:17
                        ),
                      ),*/
                    /*  Text(
                    'Lawyer is available until $timeAvailableFormat'.tr,
                    style: TextStyle(color: Color(0xFF0faa9a)),
                  ),
                  SizedBox(
                    height: 30,
                  ),*/
                    /*  Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                              CustomButton(
                                  onTap: (){
                                     controller.selectedBottomSheetButton.value=0;
                                     controller.duration=15;
                                     controller.calculatePrice(15, timeslot, timeslotDuration, price);
                                  },
                                  text: '15 min',
                                  color: controller.selectedBottomSheetButton.value==0
                                      ?Color(0xFF0faa9a)
                                      :Colors.grey ,
                              ),
                              CustomButton(
                                  onTap: (){
                                    controller.selectedBottomSheetButton.value=1;
                                    controller.duration=30;
                                    controller.calculatePrice(30, timeslot, timeslotDuration, price);
                                  },
                                  text: '30 min',
                                  color: controller.selectedBottomSheetButton.value==1
                                      ?Color(0xFF0faa9a)
                                      : Colors.grey,
                              ),
                              CustomButton(
                                  onTap: (){
                                    controller.selectedBottomSheetButton.value=2;
                                    controller.duration=45;
                                    controller.calculatePrice(45, timeslot, timeslotDuration, price);
                                  },
                                  text: '45 min',
                                  color: controller.selectedBottomSheetButton.value==2
                                      ?Color(0xFF0faa9a)
                                      :Colors.grey ,
                              ),
                          ],
                        ),
                      SizedBox(height: 25,),*/
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text('Consulting will cost = '),
                        Text(
                          '${price.toString()} USD to 15 minutes',
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 51,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButton(
                          onTap: () {
                            Get.back();
                          },
                          text: 'Cancel'.tr,
                          color: Colors.black54,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        CustomButton(
                          onTap: () {
                            controller.onTap(
                              index,
                              price,
                              15,
                              /*    timeslot,
                            timeslotDuration,*/
                            );
                          },
                          text: 'Confirm'.tr,
                          color: Color(0xFF195076),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
