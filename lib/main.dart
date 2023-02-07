import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:client_mohamoon/app/service/notification_service.dart';
import 'package:client_mohamoon/app/utils/environment.dart';
import 'package:client_mohamoon/app/utils/localization.dart';
import 'app/routes/app_pages.dart';
import 'app/service/firebase_service.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load();
  NotificationService();
  bool isUserLogin = await FirebaseService().checkUserAlreadyLogin();
  Stripe.publishableKey = Environment.stripePublishableKey;
  initializeDateFormatting('en', null);
  FirebaseChatCore.instance
      .setConfig(FirebaseChatCoreConfig(null, 'Rooms', 'Users'));
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      home: MySplashScreen(isUserLogin: isUserLogin,),
      //initialRoute: isUserLogin ? AppPages.DASHBOARD : AppPages.OnBoarding,
      getPages: AppPages.routes,
      builder: EasyLoading.init(),
      localizationsDelegates: [
        FormBuilderLocalizations.delegate,
      ],
      locale: LocalizationService.locale,
      translations: LocalizationService(),
    ),
  );
}
