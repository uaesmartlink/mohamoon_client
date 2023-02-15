import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/video_call_controller.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;


class VideoCallView extends GetView<VideoCallController> {
  const VideoCallView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<VideoCallController>(
          builder: (_) {
            return Stack(
              children: [
                Center(
                  child: _remoteVideo(),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    width: 100,
                    height: 150,
                    child: Center(
                      child: controller.localUserJoined
                          ? const RtcLocalView.SurfaceView()
                          : const CircularProgressIndicator(),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  child: SizedBox(
                    width: Get.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FloatingActionButton(
                          onPressed: controller.toggleLocalAudioMuted,
                          heroTag: 'micOff',
                          child: controller.localAudioMute == false
                              ? const Icon(Icons.mic)
                              : const Icon(Icons.mic_off),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        FloatingActionButton(
                          onPressed: controller.toggleLocalCamOff,
                          heroTag: 'camOff',
                          child: controller.localCamOff == false
                              ? const Icon(Icons.videocam)
                              : const Icon(Icons.videocam_off),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        FloatingActionButton(
                          onPressed: controller.switchCamera,
                          heroTag: 'cameraSwitch',
                          child: const Icon(Icons.switch_camera),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        FloatingActionButton(
                          onPressed: () {
                            controller.completedConsultation();
                          },
                          backgroundColor: Colors.red,
                          heroTag: 'endMeeting',
                          child: const Icon(Icons.call_end),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _remoteVideo() {
    if (controller.remoteUid != null) {
      return RtcRemoteView.SurfaceView(
        uid: controller.remoteUid!,
        channelId: controller.room,
      );
    } else {
      return Text(
        'Please wait for remote user to join'.tr,
        textAlign: TextAlign.center,
      );
    }
  }
}
