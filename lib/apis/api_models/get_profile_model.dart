class GetProfileModel {
  bool? success;
  Data? data;
  String? message;
  String? notification;
  String? error;
  String? status;

  GetProfileModel(
      {this.success,
        this.data,
        this.message,
        this.notification,
        this.error,
        this.status});

  GetProfileModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? mobileNumber;
  String? dob;
  String? emailVerifiedAt;
  String? gender;
  String? status;
  String? position;
  String? age;
  String? type;
  String? otp;
  String? image;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? deviceToken;
  String? deviceType;
  String? deleteAt;
  String? otpTime;
  String? otpVerify;

  UserData(
      {this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.mobileNumber,
        this.dob,
        this.emailVerifiedAt,
        this.gender,
        this.status,
        this.position,
        this.age,
        this.type,
        this.otp,
        this.image,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.deviceToken,
        this.deviceType,
        this.deleteAt,
        this.otpTime,
        this.otpVerify});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    mobileNumber = json['mobile_number'];
    dob = json['dob'];
    emailVerifiedAt = json['email_verified_at'];
    gender = json['gender'];
    status = json['status'];
    position = json['position'];
    age = json['age'];
    type = json['type'];
    otp = json['otp'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    deviceToken = json['device_token'];
    deviceType = json['device_type'];
    deleteAt = json['delete_at'];
    otpTime = json['otp_time'];
    otpVerify = json['otp_verify'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['mobile_number'] = this.mobileNumber;
    data['dob'] = this.dob;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['gender'] = this.gender;
    data['status'] = this.status;
    data['position'] = this.position;
    data['age'] = this.age;
    data['type'] = this.type;
    data['otp'] = this.otp;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['device_token'] = this.deviceToken;
    data['device_type'] = this.deviceType;
    data['delete_at'] = this.deleteAt;
    data['otp_time'] = this.otpTime;
    data['otp_verify'] = this.otpVerify;
    return data;
  }
}
