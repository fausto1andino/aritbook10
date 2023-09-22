import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer' as dev;

import '../models/user_data.model.dart';

class UserServices {
  createUser(UserData user) {
    var db = FirebaseFirestore.instance;
    dev.log(user.toFirestore().toString());
    db.collection('users').add(user.toFirestore());
  }

  createNewUser(
      String email, String name, String phoneNumber, String password) {}

  getUser(String id) async {
    UserData? user;
    var db = FirebaseFirestore.instance;
    final userRef = db.collection("users");
    final query = userRef.where("id", isEqualTo: id);
    final result = await query.get();

    if (result.docs.isNotEmpty) {
      user = UserData.fromDocument(result.docs.first);
      dev.log("User: $user");
    } else {
      user = null;
    }

    return user;
  }

  Future<bool> updateUser(UserData user) async {
    try {
      var db = FirebaseFirestore.instance;
      var id = user.id;
      var searchdb =
          await db.collection('users').where('id', isEqualTo: id).get();
      var userID = searchdb.docs.first.id;
      db.collection('users').doc(userID).update(user.toFirestore());
      return true;
    } on Exception catch (e) {
      dev.log(e.toString());
      return false;
    }
  }

  updateUserPhoneNumber(String id, String phoneNumber) async {
    dev.log("Update user phone number");

    var phonePrefix = phoneNumber.substring(0, 4);
    phoneNumber = phoneNumber.substring(4);
    dev.log(phonePrefix.toString());
    dev.log(phoneNumber.toString());
    var db = FirebaseFirestore.instance;
    var searchdb =
        await db.collection('users').where('id', isEqualTo: id).get();
    var userID = searchdb.docs.first.id;
    db
        .collection('users')
        .doc(userID)
        .update({"phoneNumber": phoneNumber, "phonePrefix": phonePrefix});
  }
}
