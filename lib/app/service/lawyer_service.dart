import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:client_mohamoon/app/models/lawyer_category_model.dart';
import 'package:client_mohamoon/app/models/lawyer_model.dart';
import 'package:client_mohamoon/app/models/time_slot_model.dart';
import 'package:client_mohamoon/app/models/country_model.dart';

class LawyerService {
  //Added by N
  //Get list of all lawyer schedule base on time slot
  Future<List<TimeSlot>> getAllLawyerTimeSlotNow() async {
    try {
      //List<TimeSlot> listTimeslot = [];
      QuerySnapshot lawyerScheduleRef = await FirebaseFirestore.instance
          .collection('LawyerTimeslot')
          .where('available', isEqualTo: true)
          .get();
      var listTimeslot = lawyerScheduleRef.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        data['timeSlotId'] = doc.reference.id;
        TimeSlot timeSlot = TimeSlot.fromJson(data);
        return timeSlot;
      }).toList();
      if (lawyerScheduleRef.docs.isEmpty) return [];
      return listTimeslot;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  //Get list of Lawyer schedule base on lawyer id
  Future<List<TimeSlot>> getLawyerTimeSlot(Lawyer lawyer) async {
    try {
      print('lawyer id : ${lawyer.lawyerId!}');
      List<TimeSlot> listTimeslot = [];
      QuerySnapshot lawyerScheduleRef = await FirebaseFirestore.instance
          .collection('LawyerTimeslot')
          .where('lawyerId', isEqualTo: lawyer.lawyerId)
          .where('timeSlot', isGreaterThanOrEqualTo: DateTime.now())
          .orderBy('timeSlot')
          .get();
      for (var doc in lawyerScheduleRef.docs) {
        var data = doc.data() as Map<String, dynamic>;
        data['timeSlotId'] = doc.reference.id;
        TimeSlot timeSlot = TimeSlot.fromJson(data);
        if (timeSlot.available == true) {
          listTimeslot.add(timeSlot);
        }
      }
      /* var listTimeslot = lawyerScheduleRef.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        data['timeSlotId'] = doc.reference.id;
        TimeSlot timeSlot = TimeSlot.fromJson(data);
        if(timeSlot.available != true){

        }
        return timeSlot;
      }).toList();*/
      print('length : ${listTimeslot.length}');
      if (lawyerScheduleRef.docs.isEmpty) return [];
      return listTimeslot;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

// Get lawyer and all its property
  Future<Lawyer> getLawyerDetail(String lawyerId) async {
    var lawyerSnapshot = await FirebaseFirestore.instance
        .collection('Lawyers')
        .doc(lawyerId)
        .get();
    Lawyer lawyer =
    Lawyer.fromJson(lawyerSnapshot.data() as Map<String, dynamic>);
    lawyer.lawyerId = lawyerId;
    return lawyer;
  }

  Future<List<Lawyer>> getOnlineLawyers() async {
    print("Hello");
    List<Lawyer> list = [];
    var listLawyerQuery = await FirebaseFirestore.instance
        .collection('Lawyers')
        .where('isOnline', isEqualTo: true)
        .where('accountStatus', isEqualTo: 'active' )
        .get();

    listLawyerQuery.docs.map((doc) {
      var data = doc.data();
      data['lawyerId'] = doc.reference.id;
      Lawyer lawyer = Lawyer.fromJson(data);
      print(lawyer.lawyerName);
      list.add(lawyer);
    }).toList();

    return list;
  }

  Future<Lawyer> getLawyerById(String id) async{

    try{
      var lawyer = await FirebaseFirestore.instance
          .collection('Lawyers')
          .where('lawyerId', isEqualTo: id)
          .get();
      //print('doc element${user.docs.length}');
      if (lawyer.docs.isEmpty) return Lawyer();
      return lawyer.docs.elementAt(0) as Lawyer;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
  Future<List<Lawyer>> getListLawyerByCategory(
      LawyerCategory lawyerCategory, Country country) async {
    try {
      List<Lawyer> listLawyer = [];
      var listLawyerQuery;
      if (lawyerCategory.categoryName == "All Lawyers") {
        listLawyerQuery = await FirebaseFirestore.instance
            .collection('Lawyers')
            .where('accountStatus', isEqualTo: 'active')
            .get();
      } else {
        listLawyerQuery = await FirebaseFirestore.instance
            .collection('Lawyers')
            .where('lawyerCountry', isEqualTo: country.countryName)
            .where('accountStatus', isEqualTo: 'active')
            .where('categories', arrayContains: lawyerCategory.categoryName)
            .get();
      }
      if (listLawyerQuery.docs.isEmpty) return [];
      listLawyerQuery.docs.map((doc) {
        var data = doc.data();
        data['lawyerId'] = doc.reference.id;

        Lawyer lawyer = Lawyer.fromJson(data);
        listLawyer.add(lawyer);
      }).toList();
      //print('list lawyer : $list');
      return listLawyer;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<Lawyer>> getTopRatedLawyer({int limit = 10}) async {
    try {
      var topRatedLawyer = await FirebaseFirestore.instance
          .collection('TopRatedLawyer')
          .limit(limit)
          .get();
      List<String> listIdTopRatedLawyer = topRatedLawyer.docs.map((doc) {
        String myList =
        (doc.data()['lawyerId'] as String).replaceAll(RegExp(r"\s+"), "");
        return myList;
      }).toList();

      //print('list top rated : $listIdTopRatedLawyer');
      if (listIdTopRatedLawyer.isEmpty) return [];
      var lawyerRef = await FirebaseFirestore.instance
          .collection('Lawyers')
          .where(FieldPath.documentId, whereIn: listIdTopRatedLawyer)
          .get();
      //print('length : ${lawyerRef.docs.length}');
      List<Lawyer> listTopRatedLawyer = lawyerRef.docs.map((doc) {
        var data = doc.data();
        data['lawyerId'] = doc.reference.id;
        Lawyer lawyer = Lawyer.fromJson(data);
        return lawyer;
      }).toList();
      return listTopRatedLawyer;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<Lawyer>> searchLawyer(String lawyerName) async {
    try {
      //print('lawyer name : $lawyerName');
      var lawyerRef =
      await FirebaseFirestore.instance.collection('Lawyers').get();
      List<Lawyer> listLawyer = [];
      lawyerRef.docs.forEach((element) {
        var data = element.data();
        data['lawyerId'] = element.reference.id;
        Lawyer lawyer = Lawyer.fromJson(data);
        listLawyer.add(lawyer);
        print(lawyer.lawyerName);
        print(lawyerName.isEmpty);
        if (!lawyerName.isEmpty) {
          if (!lawyer.lawyerName!
              .toLowerCase()
              .contains(lawyerName.toLowerCase())) listLawyer.remove(lawyer);
        }
      });
      listLawyer.removeWhere((element) => element.accountStatus != 'active');
      return listLawyer;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<String> getUserId(Lawyer lawyer) async {
    try {
      var user = await FirebaseFirestore.instance
          .collection('Users')
          .where('lawyerId', isEqualTo: lawyer.lawyerId)
          .get();
      //print('doc element${user.docs.length}');
      if (user.docs.isEmpty) return '';
      return user.docs.elementAt(0).id;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
