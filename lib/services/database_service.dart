import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {


  


  Future<String?> addUser({
    required String name,
    required String email,
    required String number,
    required String address,
  }) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      // Call the user's CollectionReference to add a new user
      await users.doc(email).set({
        'name': name,
        'number': number,
        'address': address,
      });
      print('success');
      return 'success';
    } catch (e) {
      return 'Error adding user';
    }
  }

  Future<Map<String, dynamic>?> getUser({required String email}) async {
    try {
      DocumentSnapshot users = await FirebaseFirestore.instance.collection('users').doc(email).get();
      final data = users.data() as Map<String, dynamic>;
      final name = data['name'];
      final address = data['address'];
      final number = data['number'];
      return {
        'name': name,
        'address':address,
        'number':number,
      };
    } catch (e) {
      return null;
    }
  }
}
