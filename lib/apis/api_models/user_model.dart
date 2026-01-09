class UserModel {
  bool? success;
  Data? data;
  String? message;
  String? status;

  UserModel(
      {this.success,
        this.data,
        this.message,
        this.status});

  UserModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}

class Data {
  String? token;
  int? userId;
  UserData? userData;

  Data({this.token, this.userId, this.userData});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    userId = json['user_id'];
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
  String? countryCode;
  String? mobileNumber;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  String? address;
  String? deletedAt;
  String? deviceToken;
  String? deviceType;
  String? otp;
  String? otpTime;
  String? image;
  String? adminStatus;
  String? profileStatus;
  String? dob;
  String? gender;
  String? token;


  UserData(
      {this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.countryCode,
        this.mobileNumber,
        this.emailVerifiedAt,
        this.createdAt,
        this.updatedAt,
        this.address,
        this.deletedAt,
        this.deviceToken,
        this.deviceType,
        this.otp,
        this.otpTime,
        this.image,
        this.adminStatus,
        this.profileStatus,
        this.dob,
        this.gender});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    countryCode = json['country_code'];
    mobileNumber = json['mobile_number'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    address = json['address'];
    deletedAt = json['deleted_at'];
    deviceToken = json['device_token'];
    deviceType = json['device_type'];
    otp = json['otp'];
    otpTime = json['otp_time'];
    image = json['image'];
    adminStatus = json['admin_status'];
    profileStatus = json['profile_status'];
    dob = json['dob'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['country_code'] = this.countryCode;
    data['mobile_number'] = this.mobileNumber;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['address'] = this.address;
    data['deleted_at'] = this.deletedAt;
    data['device_token'] = this.deviceToken;
    data['device_type'] = this.deviceType;
    data['otp'] = this.otp;
    data['otp_time'] = this.otpTime;
    data['image'] = this.image;
    data['admin_status'] = this.adminStatus;
    data['profile_status'] = this.profileStatus;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    return data;
  }
}
