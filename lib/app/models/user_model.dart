class UserModel {
  UserModel({this.fullName,this.phone,this.gender,this.age,this.displayName, this.photoUrl,this.balance, this.userId, this.lawyerId});
  String? fullName;
  String? phone;
  String? gender;
  String? age ;
  String? displayName;
  String? photoUrl;
  double? balance;
  String? userId;
  String? lawyerId;

  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    return UserModel(
        fullName: jsonData['fullName'],
        phone: jsonData['phone'],
        gender: jsonData['gender'],
        age: jsonData['age'],
        displayName: jsonData['displayName'],
        photoUrl: jsonData['photoUrl'],
        balance: double.parse(jsonData['balance'].toString()),
        userId: jsonData['userId'],
        lawyerId: jsonData['lawyerId']);
  }
}
