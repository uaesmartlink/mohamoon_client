import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:client_mohamoon/app/modules/dashboard/views/dashboard_view.dart';

import 'package:client_mohamoon/app/modules/home/views/components/background_home.dart';
import 'package:client_mohamoon/app/modules/home/views/components/icon_card.dart';

import 'package:client_mohamoon/app/modules/home/views/components/search_container.dart';

import 'package:client_mohamoon/app/utils/constants/style_constants.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../utils/search/search_lawyer_delegate.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final CarouselController carouselController = CarouselController();
    [Permission.microphone, Permission.camera, Permission.phone, Permission.notification].request();

    return Scaffold(
      backgroundColor: Constants.mBackgroundColor,
      body: BackgroundHome(
        text: controller.userService.currentUser!.displayName!,
        widget1: InkWell(
          onTap: () {
            controller.toProfile();
          },
          child: SizedBox(
            height: 40,
            child: controller.userPicture.value.isEmpty
                ? Image.asset('assets/images/user.png')
                : CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(
                        controller.userPicture.value),
                  ),
          ),
        ),
        widget2: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              child: Column(
                children: [
                  SearchContainer(
                    onTap: () async {
                      //controller.toSearchLawyer();
                      await showSearch(
                        context: context,
                        delegate: SearchLawyerDelegat(),
                      );
                    },

                  ),
                  const Spacer(),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconCard(
                          path: "assets/images/booking.png",
                          // iconData: Icons.local_hospital_outlined,
                          text: 'Book Appointment'.tr,
                          //   text1: 'Consultation with a specialist'.tr,
                          // color1: Color(0xFFa80000),
                          // color2: Color(0xFFa80000),

                          onTap: () {
                            controller.toCountry();
                            // controller.testViedoNotify();
                          },
                        ),
                        IconCard(
                          path: "assets/images/call24.png",
                          // iconData: Icons.local_hospital_outlined,
                          text: 'Quick Consultation'.tr,
                          //   text1: 'Consultation with a specialist'.tr,
                          // color1: Color(0xFFa80000),
                          // color2: Color(0xFFa80000),

                          onTap: () {
                            controller.toOnlineLawyers();
                            // controller.testViedoNotify();
                          },
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  GetBuilder<HomeController>(
                    builder: (_) {
                      return CarouselSlider(
                        carouselController: carouselController,
                        options: CarouselOptions(
                            height: 200,
                            autoPlay: true,
                            aspectRatio: 2.0,
                            viewportFraction: 0.9,
                            onPageChanged: (index, reason) {
                              controller.carouselChange(index);
                            }),
                        items: imgListAssetSlider(controller.listImageCarousel),
                      );
                    },
                  ),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: controller.listImageCarousel.isNotEmpty
                          ? controller.listImageCarousel
                              .asMap()
                              .entries
                              .map((entry) {
                              return GestureDetector(
                                onTap: () =>
                                    carouselController.animateToPage(entry.key),
                                child: Container(
                                  width: 12.0,
                                  height: 12.0,
                                  margin: EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 4.0),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: (Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? Colors.white
                                              : Colors.black)
                                          .withOpacity(
                                              controller.getcaoruselIndex ==
                                                      entry.key
                                                  ? 0.9
                                                  : 0.4)),
                                ),
                              );
                            }).toList()
                          : imgListAsset.asMap().entries.map((entry) {
                              return GestureDetector(
                                onTap: () =>
                                    carouselController.animateToPage(entry.key),
                                child: Container(
                                  width: 12.0,
                                  height: 12.0,
                                  margin: EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 4.0),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: (Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? Colors.white
                                              : Colors.black)
                                          .withOpacity(
                                              controller.getcaoruselIndex ==
                                                      entry.key
                                                  ? 0.9
                                                  : 0.4)),
                                ),
                              );
                            }).toList(),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 4.5,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: DashboardView(),
    );
  }

  Future<void> test() async {
    return Future.delayed(Duration(seconds: 5));
  }
}

final List<String> imgListAsset = [
  'assets/images/carousel.jpg',
  'assets/images/carousel.jpg'
];

List<Widget> imgListAssetSlider(List<String?> imgCarouselList) {
  if (imgCarouselList.isEmpty) {
    return imgListAsset
        .map((item) => Container(
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(
                      children: <Widget>[
                        Image.asset(item, fit: BoxFit.cover, width: 1000.0),
                      ],
                    )),
              ),
            ))
        .toList();
  }
  return imgCarouselList
      .map((item) => Container(
            child: Container(
              margin: EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.network(item ?? "",
                          fit: BoxFit.cover, width: 1000.0),
                    ],
                  )),
            ),
          ))
      .toList();
}
