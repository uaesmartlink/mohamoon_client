import 'package:get/get.dart';

import 'package:client_mohamoon/app/modules/appointment/bindings/appointment_binding.dart';
import 'package:client_mohamoon/app/modules/appointment/views/appointment_view.dart';
import 'package:client_mohamoon/app/modules/appointment_detail/bindings/appointment_detail_binding.dart';
import 'package:client_mohamoon/app/modules/appointment_detail/views/appointment_detail_view.dart';
import 'package:client_mohamoon/app/modules/balance/bindings/balance_binding.dart';
import 'package:client_mohamoon/app/modules/balance/views/balance_view.dart';
//import 'package:client_mohamoon/app/modules/chat/bindings/chat_binding.dart';
//import 'package:client_mohamoon/app/modules/chat/views/chat_view.dart';
import 'package:client_mohamoon/app/modules/consultation_confirm/bindings/consultation_confirm_binding.dart';
import 'package:client_mohamoon/app/modules/consultation_confirm/views/consultation_confirm_view.dart';
import 'package:client_mohamoon/app/modules/consultation_date_picker/bindings/consultation_date_picker_binding.dart';
import 'package:client_mohamoon/app/modules/consultation_date_picker/views/consultation_date_picker_view.dart';
import 'package:client_mohamoon/app/modules/dashboard/bindings/dashboard_binding.dart';
import 'package:client_mohamoon/app/modules/dashboard/views/dashboard_view.dart';
import 'package:client_mohamoon/app/modules/detail_lawyer/bindings/detail_lawyer_binding.dart';
import 'package:client_mohamoon/app/modules/detail_lawyer/views/detail_lawyer_view.dart';
import 'package:client_mohamoon/app/modules/detail_order/bindings/detail_order_binding.dart';
import 'package:client_mohamoon/app/modules/detail_order/views/detail_order_view.dart';
import 'package:client_mohamoon/app/modules/lawyer_category/bindings/lawyer_category_binding.dart';
import 'package:client_mohamoon/app/modules/lawyer_category/views/lawyer_category_view.dart';
import 'package:client_mohamoon/app/modules/forgot_password/bindings/forgot_password_binding.dart';
import 'package:client_mohamoon/app/modules/forgot_password/views/forgot_password_view.dart';
import 'package:client_mohamoon/app/modules/home/bindings/home_binding.dart';
import 'package:client_mohamoon/app/modules/home/views/home_view.dart';
import 'package:client_mohamoon/app/modules/list_chat/bindings/list_chat_binding.dart';
import 'package:client_mohamoon/app/modules/list_chat/views/list_chat_view.dart';
import 'package:client_mohamoon/app/modules/list_lawyer/bindings/list_lawyer_binding.dart';
import 'package:client_mohamoon/app/modules/list_lawyer/views/list_lawyer_view.dart';
import 'package:client_mohamoon/app/modules/login/bindings/login_binding.dart';
import 'package:client_mohamoon/app/modules/login/views/login_view.dart';
import 'package:client_mohamoon/app/modules/online_lawyers/bindings/online_lawyers_bindings.dart';
import 'package:client_mohamoon/app/modules/online_lawyers/views/online_lawyers_view.dart';
import 'package:client_mohamoon/app/modules/payment_success/bindings/payment_success_binding.dart';
import 'package:client_mohamoon/app/modules/payment_success/views/payment_success_view.dart';
import 'package:client_mohamoon/app/modules/profile/bindings/profile_binding.dart';
import 'package:client_mohamoon/app/modules/profile/views/profile_view.dart';
import 'package:client_mohamoon/app/modules/register/bindings/register_binding.dart';
import 'package:client_mohamoon/app/modules/register/views/register_view.dart';
import 'package:client_mohamoon/app/modules/reset_password/bindings/reset_password_binding.dart';
import 'package:client_mohamoon/app/modules/reset_password/views/reset_password_view.dart';
import 'package:client_mohamoon/app/modules/review/bindings/review_binding.dart';
import 'package:client_mohamoon/app/modules/review/views/review_view.dart';
import 'package:client_mohamoon/app/modules/search_lawyer/bindings/search_lawyer_binding.dart';
import 'package:client_mohamoon/app/modules/search_lawyer/views/search_lawyer_view.dart';
import 'package:client_mohamoon/app/modules/top_rated_lawyer/bindings/top_rated_lawyer_binding.dart';
import 'package:client_mohamoon/app/modules/top_rated_lawyer/views/top_rated_lawyer_view.dart';
import 'package:client_mohamoon/app/modules/video_call/bindings/video_call_binding.dart';
import 'package:client_mohamoon/app/modules/video_call/views/video_call_view.dart';
import '../modules/onboarding_page/bindings/onboarding_binding.dart';
import '../modules/onboarding_page/views/onboarding_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const DASHBOARD = Routes.DASHBOARD;
  static const HOME = Routes.HOME;
  static const LOGIN = Routes.LOGIN;
  static const OnBoarding = Routes.onBoarding;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.LAWYER_CATEGORY,
      page: () => LawyerCategoryView(),
      binding: LawyerCategoryBinding(),
    ),
    GetPage(
      name: _Paths.LIST_LAWYER,
      page: () => ListLawyerView(),
      binding: ListLawyerBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_LAWYER,
      page: () => DetailLawyerView(),
      binding: DetailLawyerBinding(),
    ),
    GetPage(
      name: _Paths.CONSULTATION_DATE_PICKER,
      page: () => ConsultationDatePickerView(),
      binding: ConsultationDatePickerBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_ORDER,
      page: () => DetailOrderView(),
      binding: DetailOrderBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT_SUCCESS,
      page: () => PaymentSuccessView(),
      binding: PaymentSuccessBinding(),
    ),
    GetPage(
      name: _Paths.VIDEO_CALL,
      page: () => VideoCallView(),
      binding: VideoCallBinding(),
    ),
    GetPage(
      name: _Paths.APPOINTMENT,
      page: () => AppointmentView(),
      binding: AppointmentBinding(),
    ),
    GetPage(
      name: _Paths.APPOINTMENT_DETAIL,
      page: () => AppointmentDetailView(),
      binding: AppointmentDetailBinding(),
    ),
    GetPage(
      name: _Paths.REVIEW,
      page: () => ReviewView(),
      binding: ReviewBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.TOP_RATED_LAWYER,
      page: () => TopRatedLawyerView(),
      binding: TopRatedLawyerBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_LAWYER,
      page: () => SearchLawyerView(),
      binding: SearchLawyerBinding(),
    ),
    GetPage(
      name: _Paths.CONSULTATION_CONFIRM,
      page: () => ConsultationConfirmView(),
      binding: ConsultationConfirmBinding(),
    ),
    /*GetPage(
      name: _Paths.CHAT,
      page: () => ChatView(),
      binding: ChatBinding(),
    ),*/
    GetPage(
      name: _Paths.LIST_CHAT,
      page: () => ListChatView(),
      binding: ListChatBinding(),
    ),
    GetPage(
      name: _Paths.online_lawyers,
      page: () => OnlineLawyersView(),
      binding: OnlineLawyersBindings(),
    ),
    GetPage(
      name: _Paths.onBoarding,
      page: () => OnBoardingView(),
      binding: OnBoardingBindings(),
    ),
    GetPage(
      name: _Paths.balance,
      page: () => BalanceView(),
      binding: BalanceBinding(),
    ),
  ];
}
