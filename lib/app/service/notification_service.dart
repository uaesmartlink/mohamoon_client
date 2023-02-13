//import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:custom_flutter_callkit_incoming/flutter_callkit_incoming.dart';

import 'package:get/get.dart';
import 'package:client_mohamoon/app/models/time_slot_model.dart';
import 'package:client_mohamoon/app/service/timeslot_service.dart';
import 'package:client_mohamoon/app/utils/styles/styles.dart';
import 'package:jiffy/jiffy.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:uuid/uuid.dart';
import 'package:client_mohamoon/app/service/videocall_service.dart';


const AndroidNotificationChannel channel = AndroidNotificationChannel(
    "high_important_channel", "High Importance Notifications",
    description: 'this channel is used for important notification',
    importance: Importance.max,
    playSound: true);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessaggingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('a big message just show up ${message.messageId!}');
  print(message.data['type']);
  print("---------");
  print(message.data);
  print("---------");
  print(message);
  print("---------");
  var _uuid = Uuid();
  var params = <String, dynamic>{
    'id': _uuid.v4(),
    'nameCaller': message.data['fromName'],
    'appName': 'Mohamoon',
    'avatar': '',
    'handle': '',
    'type': 1,
    'textAccept': 'Accept',
    'textDecline': 'Decline',
    'textMissedCall': 'Missed call',
    'textCallback': 'Call back',
    'duration': 150,
    // 'duration': 30000,
    'extra': <String, dynamic>{
      'roomName': message.data['roomName'],
      'token': message.data['token'],
      'selectedTimeslotId': message.data['timeSlotId'],
    },
    'headers': <String, dynamic>{},
    'android': <String, dynamic>{
      'isCustomNotification': false,
      'isShowLogo': true,
      'isShowMissedCallNotification': true,
      'isShowCallback': true,
      'ringtonePath': 'system_ringtone_default',
      'backgroundColor': '#0955fa',
      'backgroundUrl': '',
      'actionColor': '#4CAF50'
    },
    'ios': <String, dynamic>{
      'iconName': 'CallKitLogo',
      'handleType': 'generic',
      'supportsVideo': true,
      'maximumCallGroups': 2,
      'maximumCallsPerCallGroup': 1,
      'audioSessionMode': 'videoChat',
      'audioSessionActive': true,
      'audioSessionPreferredSampleRate': 44100.0,
      'audioSessionPreferredIOBufferDuration': 0.005,
      'supportsDTMF': true,
      'supportsHolding': true,
      'supportsGrouping': false,
      'supportsUngrouping': false,
      'ringtonePath': 'system_ringtone_default'
    }
  };
  await FlutterCallkitIncoming.showCallkitIncoming(params);
}

class NotificationService {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationService() {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessaggingBackgroundHandler);
    setupFlutterNotification();
    setupTimezone();
    setupNotificationAction();
  }

  void setupFlutterNotification() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  void showNotification() {
    flutterLocalNotificationsPlugin.show(
      0,
      "testing",
      "How you doing",
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          importance: Importance.high,
          color: Styles.primaryBlueColor,
          icon: '@mipmap/ic_launcher',
        ),
      ),
    );
  }

  void listenNotification() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        if (message.data['type'] == 'call') {
          await showCallNotification(
              message.data['fromName'],
              message.data['roomName'],
              message.data['token'],
              message.data['timeSlotId']);
        } else {
          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                  android: AndroidNotificationDetails(channel.id, channel.name,
                      channelDescription: channel.description,
                      color: Styles.primaryBlueColor,
                      playSound: true,
                      icon: '@mipmap/ic_launcher')));
        }
      }
    });
 FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('a new message opened app are was published');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        Get.defaultDialog(
            title: notification.title!,
            content: Text(notification.body ?? 'body empty'));
      }
    });

  }

  void setupTimezone() async {
    tz.initializeTimeZones();
    // final String currentTimeZone =
    //     await FlutterNativeTimezone.getLocalTimezone();
    // tz.setLocalLocation(tz.getLocation(currentTimeZone));
    //printInfo(info: 'local timezone : ' + currentTimeZone);
  }

  void setupNotificationAction() async {
    FlutterCallkitIncoming.onEvent.listen((event) async {
      print("-----");
      print(event);
      print("-----");
      switch (event!.name) {
        case CallEvent.ACTION_CALL_INCOMING:
          print('incoming call gaes');
          break;
        case CallEvent.ACTION_CALL_ACCEPT:
          print('body ' + event.body['extra']['roomName']);
          print('accept the data');
          TimeSlot selectedTimeslot = await TimeSlotService()
              .getTimeSlotById(event.body['extra']['roomName']);
          print("SSSSSSSSSs");
          print(event.body['extra']['roomName']);
          print(selectedTimeslot.timeSlotId);
          print("SSSSSSSSSs");
          Get.toNamed('/video-call', arguments: [
            {
              'timeSlot': selectedTimeslot,
              'room': event.body['extra']['roomName'],
              'token': event.body['extra']['token']
            }
          ]);
          break;
        case CallEvent.ACTION_CALL_DECLINE:
          print('declien call gaes');
          await VideoCallService().removeRoom(event.body['extra']['roomName']);
          break;
      }
      print("XCVBN");
    });
    // connecticube.ConnectycubeFlutterCallKit.instance.init(
    //   onCallAccepted: _onCallAccepted,
    //   onCallRejected: _onCallRejected,
    // );
  }

  Future showCallNotification(String fromName, String roomName, String token,
      String selectectedTimeslotId) async {
    var _uuid = Uuid();
    var params = <String, dynamic>{
      'id': _uuid.v4(),
      'nameCaller': fromName,
      'appName': 'Tatbeeb',
      'avatar': '',
      'handle': '',
      'type': 1,
      'textAccept': 'Accept',
      'textDecline': 'Decline',
      'textMissedCall': 'Missed call',
      'textCallback': 'Call back',
      'duration': 300,
      'extra': <String, dynamic>{
        'roomName': roomName,
        'token': token,
        'selectedTimeslotId': selectectedTimeslotId,
      },
      'headers': <String, dynamic>{},
      'android': <String, dynamic>{
        'isCustomNotification': false,
        'isShowLogo': true,
        'isShowMissedCallNotification': true,
        'isShowCallback': true,
        'ringtonePath': 'system_ringtone_default',
        'backgroundColor': '#0955fa',
        'actionColor': '#4CAF50'
      },
      'ios': <String, dynamic>{
        'iconName': 'CallKitLogo',
        'handleType': 'generic',
        'supportsVideo': true,
        'maximumCallGroups': 2,
        'maximumCallsPerCallGroup': 1,
        'audioSessionMode': 'videoChat',
        'audioSessionActive': true,
        'audioSessionPreferredSampleRate': 44100.0,
        'audioSessionPreferredIOBufferDuration': 0.005,
        'supportsDTMF': true,
        'supportsHolding': true,
        'supportsGrouping': false,
        'supportsUngrouping': false,
        'ringtonePath': 'system_ringtone_default'
      }
    };
    await FlutterCallkitIncoming.showCallkitIncoming(params);
  }

  Future<String?> getNotificationToken() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      return token;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future testNotification() async {
    try {
      await FirebaseFunctions.instance.httpsCallable('notificationTest').call();
      //var clientSecret = results.data;
      print('send notification : ');
      //return clientSecret;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future testVideoNotification() async {
    try {
      await showCallNotification(
          "TestCall", "0123456789", "012345678", "123456789");
      //var clientSecret = results.data;
      print('test call video : ');
      //return clientSecret;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  //set local notification before appoinment time
  setNotificationAppointment(DateTime time) {
    var notificationDate = Jiffy(time).subtract(minutes: 10).dateTime;
    printInfo(
        info:
            'Date time sebelum TZ Date (dikurang 10 menit): $notificationDate');
    var myTzDatetime = tz.TZDateTime.local(
      notificationDate.year,
      notificationDate.month,
      notificationDate.day,
      notificationDate.hour,
      notificationDate.minute,
      notificationDate.second,
      notificationDate.millisecond,
    );
    printInfo(info: 'Date time setelah TZ Date $myTzDatetime');
    flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'Consultation will start soon',
        "The consultation session will start in 10 minutes",
        myTzDatetime,
        NotificationDetails(
          android: AndroidNotificationDetails(channel.id, channel.name,
              channelDescription: channel.description,
              importance: Importance.high,
              color: Styles.primaryBlueColor,
              icon: '@mipmap/ic_launcher'),
        ),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);
    printInfo(info: 'set local notification 10 before notification happen');
  }

  Future notificationStartAppointment(String userName, String lawerId,
      String roomName, String token, String timeSlotId) async {
    try {
      var callable = FirebaseFunctions.instance
          .httpsCallable('notificationStartAppointment');
      print("from: " + userName);
      print("to: " + lawerId);
      await callable({
        'lawyerName': userName,
        'userId': lawerId,
        'roomName': roomName,
        'token': token,
        'timeSlotId': timeSlotId
      });
      printInfo(info: 'notification user id : $lawerId');
      print('Notification start appointment send');
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
/*

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:custom_flutter_callkit_incoming/flutter_callkit_incoming.dart';

import 'package:get/get.dart';
import 'package:client_mohamoon/app/models/time_slot_model.dart';
import 'package:client_mohamoon/app/service/timeslot_service.dart';
import 'package:client_mohamoon/app/utils/styles/styles.dart';
import 'package:jiffy/jiffy.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:uuid/uuid.dart';
import 'package:client_mohamoon/app/service/videocall_service.dart';
const AndroidNotificationChannel channel = AndroidNotificationChannel(
    "high_important_channel", "High Importance Notifications",
    description: 'this channel is used for important notification',
    importance: Importance.high,
    playSound: true);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessaggingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('a big message just show up ' + message.messageId!);
}

class NotificationService {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  NotificationService() {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessaggingBackgroundHandler);
    setupFlutterNotification();
    setupTimezone();
    setupNotificationAction();
  }
  void setupFlutterNotification() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);
  }

  void showNotification() {
    flutterLocalNotificationsPlugin.show(
      0,
      "testing",
      "How you doing",
      NotificationDetails(
        android: AndroidNotificationDetails(channel.id, channel.name,
            channelDescription: channel.description,
            importance: Importance.high,
            color: Styles.primaryBlueColor,
            icon: '@mipmap/ic_launcher'),
      ),
    );
  }

  void listenNotification() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        print('masuk notifikasinya');
        if (message.data['type'] == 'call') {
          await showCallNotification(
              message.data['fromName'],
              message.data['roomName'],
              message.data['token'],
              message.data['timeSlotId']);
        } else {
          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                  android: AndroidNotificationDetails(channel.id, channel.name,
                      channelDescription: channel.description,
                      color: Styles.primaryBlueColor,
                      playSound: true,
                      icon: '@mipmap/ic_launcher')));
        }
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('a new message opened app are was published');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        Get.defaultDialog(
            title: notification.title!,
            content: Text(notification.body ?? 'body empty'));
      }
    });
  }

  void setupTimezone() async {
    tz.initializeTimeZones();
    // final String currentTimeZone =
    //     await FlutterNativeTimezone.getLocalTimezone();
    // tz.setLocalLocation(tz.getLocation(currentTimeZone));
    //printInfo(info: 'local timezone : ' + currentTimeZone);
  }

  void setupNotificationAction() async {
    FlutterCallkitIncoming.onEvent.listen((event) async {
      switch (event!.name) {
        case CallEvent.ACTION_CALL_INCOMING:
          print('incoming call gaes');
          break;
        case CallEvent.ACTION_CALL_ACCEPT:
          print('body ' + event.body['extra']['roomName']);
          print('accept the data');
          TimeSlot selectedTimeslot = await TimeSlotService()
              .getTimeSlotById(event.body['extra']['selectedTimeslotId']);
          Get.toNamed('/video-call', arguments: [
            {
              'timeSlot': selectedTimeslot,
              'room': event.body['extra']['roomName'],
              'token': event.body['extra']['token']
            }
          ]);
          break;
        case CallEvent.ACTION_CALL_DECLINE:
          print('declien call gaes');
          break;
      }
    });
    // connecticube.ConnectycubeFlutterCallKit.instance.init(
    //   onCallAccepted: _onCallAccepted,
    //   onCallRejected: _onCallRejected,
    // );
  }

  Future showCallNotification(String fromName, String roomName, String token,
      String selectectedTimeslotId) async {
    var params = <String, dynamic>{
      'id': 'adsfadfds',
      'nameCaller': fromName,
      'appName': 'Moneyvizer',
      'avatar': '',
      'handle': '',
      'type': 1,
      'textAccept': 'Accept',
      'textDecline': 'Decline',
      'textMissedCall': 'Missed call',
      'textCallback': 'Call back',
      'duration': 30000,
      'extra': <String, dynamic>{
        'roomName': roomName,
        'token': token,
        'selectedTimeslotId': selectectedTimeslotId
      },
      'headers': <String, dynamic>{'apiKey': 'Abc@123!', 'platform': 'flutter'},
      'android': <String, dynamic>{
        'isCustomNotification': true,
        'isShowLogo': false,
        'isShowCallback': false,
        'ringtonePath': 'system_ringtone_default',
        'backgroundColor': '#0955fa',
        'backgroundUrl': 'https://i.pravatar.cc/500',
        'actionColor': '#4CAF50'
      },
      'ios': <String, dynamic>{
        'iconName': 'CallKitLogo',
        'handleType': 'generic',
        'supportsVideo': true,
        'maximumCallGroups': 2,
        'maximumCallsPerCallGroup': 1,
        'audioSessionMode': 'default',
        'audioSessionActive': true,
        'audioSessionPreferredSampleRate': 44100.0,
        'audioSessionPreferredIOBufferDuration': 0.005,
        'supportsDTMF': true,
        'supportsHolding': true,
        'supportsGrouping': false,
        'supportsUngrouping': false,
        'ringtonePath': 'system_ringtone_default'
      }
    };
    await FlutterCallkitIncoming.showCallkitIncoming(params);
  }

  Future<String?> getNotificationToken() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      return token;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future testNotification() async {
    try {
      await FirebaseFunctions.instance.httpsCallable('notificationTest').call();
      //var clientSecret = results.data;
      print('send notification : ');
      //return clientSecret;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  //set local notification before appoinment time
  setNotificationAppointment(DateTime time) {
    var notificationDate = Jiffy(time).subtract(minutes: 10).dateTime;
    printInfo(
        info: 'Date time sebelum TZ Date (dikurang 10 menit): ' +
            notificationDate.toString());
    var myTzDatetime = tz.TZDateTime.local(
      notificationDate.year,
      notificationDate.month,
      notificationDate.day,
      notificationDate.hour,
      notificationDate.minute,
      notificationDate.second,
      notificationDate.millisecond,
    );
    printInfo(info: 'Date time setelah TZ Date ' + myTzDatetime.toString());
    flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'Consultation will start soon',
        "The consultation session will start in 10 minutes",
        myTzDatetime,
        NotificationDetails(
          android: AndroidNotificationDetails(channel.id, channel.name,
              channelDescription: channel.description,
              importance: Importance.high,
              color: Styles.primaryBlueColor,
              icon: '@mipmap/ic_launcher'),
        ),
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);
    printInfo(info: 'set local notification 10 before notification happen');
  }
}
*/


//import 'package:onesignal_flutter/onesignal_flutter.dart';
