import 'package:get/get.dart';
import 'package:client_mohamoon/app/service/videocall_service.dart';
import '../controllers/video_call_controller.dart';

class VideoCallBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VideoCallController>(
      () => VideoCallController(),
    );
    Get.put(VideoCallService());
  }
}
