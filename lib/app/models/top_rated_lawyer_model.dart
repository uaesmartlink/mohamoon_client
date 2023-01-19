class TopRatedLawyerModel {
  TopRatedLawyerModel({this.lawyerId, this.id});
  String? lawyerId;
  String? id;

  factory TopRatedLawyerModel.fromMap(Map<String, dynamic> data) {
    return TopRatedLawyerModel(lawyerId: data['lawyerId'], id: data['id']);
  }
}
