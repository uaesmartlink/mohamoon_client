import 'package:client_mohamoon/app/service/lawyer_service.dart';
import 'package:client_mohamoon/app/service/user_service.dart';

import '../models/lawyer_model.dart';

class ChatService {
  Future<Lawyer> getLawyerByUserId(String userId) async {
    try {
      var user = await UserService().getUsernameById(userId);
      var lawyer = await LawyerService().getLawyerDetail(user!.lawyerId!);
      return lawyer;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
