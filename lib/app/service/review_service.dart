import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:client_mohamoon/app/models/lawyer_model.dart';
import 'package:client_mohamoon/app/models/review_model.dart';
import 'package:client_mohamoon/app/models/time_slot_model.dart';
import 'package:client_mohamoon/app/service/user_service.dart';

class ReviewService {
  Future saveReview(
      String review, int rating, TimeSlot timeSlot, User user) async {
    try {
      await FirebaseFirestore.instance
          .collection('Review')
          .doc(timeSlot.timeSlotId)
          .set({
        'review': review,
        'rating': rating,
        'timeSlotId': timeSlot.timeSlotId,
        'userId': UserService().currentUser!.uid,
        'lawyerId': timeSlot.lawyerid,
        'user': {
          'displayName': UserService().currentUser!.displayName,
          'photoUrl': UserService().getProfilePicture(),
        }
      });
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<ReviewModel>> getLawyerReview(
      {required Lawyer lawyer, int limit = 4}) async {
    try {
      var reviewRef = await FirebaseFirestore.instance
          .collection('Review')
          .where('lawyerId', isEqualTo: lawyer.lawyerId)
          .limit(limit)
          .get();
      List<ReviewModel> listReview = reviewRef.docs.map((doc) {
        var data = doc.data();
        data['reviewId'] = doc.reference.id;
        ReviewModel review = ReviewModel.fromMap(data);
        return review;
      }).toList();
      return listReview;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
