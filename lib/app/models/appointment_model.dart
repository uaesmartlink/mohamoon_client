class Appointment {
  Appointment(
      {this.appointmentId, this.status, this.currency, this.amount, this.timeSlotId});
  String? appointmentId;
  String? status;
  String? currency;
  double? amount;
  String? timeSlotId;
  static const String _appointmentId = 'appointmentId';
  static const String _status = 'status';
  static const String _currency = 'currency';
  static const String _amount = 'amount';
  static const String _timeSlotId = 'timeSlotId';
  factory Appointment.fromMap(Map<String, dynamic> map) {

    return Appointment(
        appointmentId: map[_appointmentId],
        status: map[_status],
        currency: map[_currency],
        amount: map[_amount],
        timeSlotId: map[_timeSlotId]);
  }
}
