import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:client_mohamoon/app/utils/search/search_lawyer_delegate.dart';
import '../controllers/search_lawyer_controller.dart';

class SearchLawyerView extends GetView<SearchLawyerController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Search Lawyer'.tr),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () async {
                controller.lawyer.value = (await showSearch(
                  context: context,
                  delegate: SearchLawyerDelegat(),
                ))!;
              },
              icon: Icon(Icons.search),
            )
          ],
        ),
        body: Obx(
          () => Container(
            padding: EdgeInsets.fromLTRB(10, 15, 10, 10),
            child: controller.lawyer.value.lawyerName == null
                ? Center(
                    child: Text(
                      'Search Lawyer'.tr,
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                : ListView(children: [
                    Card(
                      child: ListTile(
                        onTap: () {
                          Get.toNamed('/detail-lawyer',
                              arguments: controller.lawyer.value);
                        },
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        leading: CircleAvatar(
                          radius: 20,
                          backgroundImage: CachedNetworkImageProvider(
                              controller.lawyer.value.lawyerPicture!),
                        ),
                        title: Text(controller.lawyer.value.lawyerName!),
                        trailing: RatingBarIndicator(
                            rating: 4.5,
                            itemCount: 5,
                            itemSize: 20.0,
                            itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                )),
                      ),
                    ),
                  ]),
          ),
        ));
  }
}
