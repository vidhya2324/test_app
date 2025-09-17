import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  final CollectionReference employeeCollection = FirebaseFirestore.instance
      .collection("employees");

  //Add new employees
  Future addUserDetails(Map<String, dynamic> userInfoMap) async {
    return await FirebaseFirestore.instance
        .collection("employees") // ✅ new collection
        .add(userInfoMap); // auto-generate ID
  }

  //Update existing employee
  Future updateUSerDetails(
    String docId,
    Map<String, dynamic> userInfoMap,
  ) async {
    return await employeeCollection.doc(docId).update(userInfoMap);
  }

  //Delete employee
  Future deleteUser(String docId) async {
    return await employeeCollection.doc(docId).delete();
  }

  //get employee list:
  Stream<QuerySnapshot> getEmployees(){
    return employeeCollection.snapshots();
  }
}
