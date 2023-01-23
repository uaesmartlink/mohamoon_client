import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:client_mohamoon/app/models/country_model.dart';

class CountryService {
  FirebaseFirestore? _instance;

  final List<Country> _country = [];

  List<Country> get getCountries => _country;

  Future<List<Country>> getListCountry() async {
    print("Hi");
    _instance = FirebaseFirestore.instance;
    CollectionReference country =
    _instance!.collection('Country');

    QuerySnapshot snapshot = await country.get();

    final allData = snapshot.docs.map((doc) {
      var data = doc.data() as Map<String, dynamic>;
      data['countryId'] = doc.reference.id;
      return data;
    });
    print(allData);
    for (var coun in allData) {
      Country doc = Country.fromJson(coun);
      _country.add(doc);
    }
    print("Hello");
    print(_country);
    return _country;
  }
}
