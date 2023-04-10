class UserModel {
  String? uid;
  String? fullname;
  String? email;
  // String? profilepic;
  String? password;
  String? address;
  String? number;

  UserModel({this.uid, this.fullname, this.email, this.number, this.address, this.password,});

  UserModel.fromMap(Map<String, dynamic> map) {
    uid = map["uid"];
    fullname = map["fullname"];
    email = map["email"];
    password = map["password"];
    address = map["address"];
    number = map["number"];
    // profilepic = map["profilepic"];
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "fullname": fullname,
      "email": email,
      "password": password,
      "address": address,
      "number": number,
      // "profilepic": profilepic,
    };
  }
}
