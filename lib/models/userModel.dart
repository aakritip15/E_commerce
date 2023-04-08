class UserModel {
  String? uid;
  String? fullName;
  String? email;
  String? address;
  String? number;

  UserModel({this.uid, this.fullName, this.email, this.address,this.number});

  UserModel.fromMap(Map<String, dynamic> map) {
    uid=
    map['uid'];
    fullName=
    map['fullName'];
    email=    map['email'];
    address=
    map['address'];
    number=
    map['number'];
  }
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'fullName': fullName,
      'email': email,
      'address': address,
      'number': number,
    };
  }
}
