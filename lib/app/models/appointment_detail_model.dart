class AppointmentDetailModel {
  final String itemId;
  final String itemName;
  final String time;
  final String duration;
  final String price;
  AppointmentDetailModel(
      {required this.itemId,
      required this.itemName,
      required this.time,
      required this.duration,
      required this.price});
}
