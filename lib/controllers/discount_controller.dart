import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DiscountController with ChangeNotifier{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isDiscountActive=false;
  void getDiscountStatus() async {
    try {
      DocumentSnapshot snapshot = await _firestore.collection('settings').doc('discountStatus').get();

      Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
print(data?['isActive']);
      if (data != null) {
        isDiscountActive=data['isActive'];
        notifyListeners();
      } else {
        isDiscountActive=false;
        notifyListeners();
      }
    } catch (e) {
      print('Error fetching discount status: $e');
    }
  }
}
