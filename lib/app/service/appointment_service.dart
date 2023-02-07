import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:client_mohamoon/app/models/appointment_model.dart';
import 'package:client_mohamoon/app/models/time_slot_model.dart';
import 'package:client_mohamoon/app/service/user_service.dart';

class AppointmentService {
  Future<Appointment> getSuccessAppointment(TimeSlot timeSlot) async {
    try {
      var appointmentSnapshot = await FirebaseFirestore.instance
          .collection('Appointment')
          .where('timeSlotId', isEqualTo: timeSlot.timeSlotId)
          .where('status', isEqualTo: 'payment_success')
          .limit(1)
          .get();
      var data = appointmentSnapshot.docs.elementAt(0).data();
      data['appointmentId'] = appointmentSnapshot.docs.elementAt(0).reference.id;
      Appointment appointment = Appointment.fromMap(data);
      return appointment;
    } on FirebaseException catch (e) {
      return Future.error(e.message!);
    }
  }

  Future<Appointment> getAppointment(TimeSlot timeSlot,String timeSlotId) async {
    try {
      print("ZZZ1");
      var appointmentData = await FirebaseFirestore.instance
          .collection('Appointment')
          .where('userId', isEqualTo: UserService().getUserId())
          .where('timeSlotId', isEqualTo: timeSlotId)
          .get();
      print("ZZZ2");

      //print('appointment length : ${appointmentData.docs.length}');
      var data = appointmentData.docs.elementAt(0).data();
      print("ZZZ3");

      data['appointmentId'] = appointmentData.docs.elementAt(0).reference.id;
      print("ZZZ4");
      data['amount'] = data['amount'].toDouble();
      print(data);
      Appointment appointment = Appointment.fromMap(data);
      print("ZZZ5");

      return appointment;
    } on Exception catch (e) {
      return Future.error(e.toString());
    }
  }

  Future confirmAppointment(TimeSlot timeSlot,String timeSlotId) async {
    try {
      print("XXX1");
      var appointment = await getAppointment(timeSlot,timeSlotId);
      print("XXX2");
      return setAppointmentToComplete(appointment);

    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<void> setAppointmentToComplete(Appointment appointment) async {
    await FirebaseFirestore.instance
        .collection("Appointment")
        .doc(appointment.appointmentId)
        .update({'status': 'success'});
  }
}
