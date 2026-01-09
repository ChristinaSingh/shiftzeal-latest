class SignUpModel {
  bool? success;
  Data? data;
  String? message;
  String? notification;
  String? error;
  String? status;

  SignUpModel(
      {this.success,
        this.data,
        this.message,
        this.notification,
        this.error,
        this.status});

  SignUpModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    notification = json['notification'];
    error = json['error'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    data['notification'] = this.notification;
    data['error'] = this.error;
    data['status'] = this.status;
    return data;
  }
}

class Data {
  String? token;
  UserData? userData;

  Data({this.token, this.userData});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    userData = json['user_data'] != null
        ? new UserData.fromJson(json['user_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.userData != null) {
      data['user_data'] = this.userData!.toJson();
    }
    return data;
  }
}

class UserData {
  String? firstName;
  String? lastName;
  String? mobileNumber;
  String? email;
  String? gender;
  String? dob;
  String? position;
  String? type;
  String? updatedAt;
  String? createdAt;
  int? id;

  UserData(
      {this.firstName,
        this.lastName,
        this.mobileNumber,
        this.email,
        this.gender,
        this.dob,
        this.position,
        this.type,
        this.updatedAt,
        this.createdAt,
        this.id});

  UserData.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    mobileNumber = json['mobile_number'];
    email = json['email'];
    gender = json['gender'];
    dob = json['dob'];
    position = json['position'];
    type = json['type'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['mobile_number'] = this.mobileNumber;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['position'] = this.position;
    data['type'] = this.type;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
