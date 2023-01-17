import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:client_mohamoon/app/models/order_model.dart';
import 'package:client_mohamoon/app/models/time_slot_model.dart';
import 'package:client_mohamoon/app/service/user_service.dart';

class OrderService {
  Future<Order> getSuccessOrder(TimeSlot timeSlot) async {
    try {
      var orderSnapshot = await FirebaseFirestore.instance
          .collection('Order')
          .where('timeSlotId', isEqualTo: timeSlot.timeSlotId)
          .where('status', isEqualTo: 'payment_success')
          .limit(1)
          .get();
      var data = orderSnapshot.docs.elementAt(0).data();
      data['orderId'] = orderSnapshot.docs.elementAt(0).reference.id;
      Order order = Order.fromMap(data);
      return order;
    } on FirebaseException catch (e) {
      return Future.error(e.message!);
    }
  }

  Future<Order> getOrder(TimeSlot timeSlot,String timeSlotId) async {
    try {
      print("ZZZ1");
      var orderData = await FirebaseFirestore.instance
          .collection('Order')
          .where('userId', isEqualTo: UserService().getUserId())
          .where('timeSlotId', isEqualTo: timeSlotId)
          .get();
      print("ZZZ2");

      //print('order length : ${orderData.docs.length}');
      var data = orderData.docs.elementAt(0).data();
      print("ZZZ3");

      data['orderId'] = orderData.docs.elementAt(0).reference.id;
      print("ZZZ4");
      data['amount'] = data['amount'].toDouble();
      print(data);
      Order order = Order.fromMap(data);
      print("ZZZ5");

      return order;
    } on Exception catch (e) {
      return Future.error(e.toString());
    }
  }

  Future confirmOrder(TimeSlot timeSlot,String timeSlotId) async {
    try {
      print("XXX1");
      var order = await getOrder(timeSlot,timeSlotId);
      print("XXX2");
      return setOrderToComplete(order);

    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<void> setOrderToComplete(Order order) async {
    await FirebaseFirestore.instance
        .collection("Order")
        .doc(order.orderId)
        .update({'status': 'success'});
  }
}
