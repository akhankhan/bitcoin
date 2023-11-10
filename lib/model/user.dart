class UserModel {
  String? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? lastName;
  bool? isEmailVerfied;
  String? pic;
  bool? isPinCode;
  String? pinCode;
  bool? isDocumentSend;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.lastName,
    this.isEmailVerfied,
    this.pic,
    this.pinCode,
    this.isPinCode,
    this.isDocumentSend,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      lastName: json['lastName'],
      pic: json['imageUrl'] ?? '',
      isDocumentSend: json['isDocumetSend'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'lastName': lastName,
      'isEmailVerfied': isEmailVerfied,
      'imageUrl': pic,
      'pinCode': '',
      'isPinCode': false,
    };
  }
}
