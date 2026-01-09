class GetAllUserDirectoryModel {
  bool? success;
  List<UserData>? data;
  String? message;
  dynamic notification;
  dynamic error;
  String? status;

  GetAllUserDirectoryModel({
    this.success,
    this.data,
    this.message,
    this.notification,
    this.error,
    this.status,
  });

  factory GetAllUserDirectoryModel.fromJson(Map<String, dynamic> json) {
    return GetAllUserDirectoryModel(
      success: json['success'],
      data: json['data'] != null
          ? List<UserData>.from(json['data'].map((v) => UserData.fromJson(v)))
          : null,
      message: json['message'],
      notification: json['notification'],
      error: json['error'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.map((v) => v.toJson()).toList(),
      'message': message,
      'notification': notification,
      'error': error,
      'status': status,
    };
  }
}

class UserData {
  int? id;
  String? type;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? mobileNumber;
  String? dob;
  String? emailVerifiedAt;
  String? gender;
  String? status;
  String? position;
  String? age;
  String? otp;
  String? image;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? rememberToken;
  String? deviceToken;
  String? deviceType;
  String? deleteAt;
  String? otpTime;
  String? otpVerify;
  String? employeeCode;
  String? otherEmployeeCode;

  UserData({
    this.id,
    this.type,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.mobileNumber,
    this.dob,
    this.emailVerifiedAt,
    this.gender,
    this.status,
    this.position,
    this.age,
    this.otp,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.rememberToken,
    this.deviceToken,
    this.deviceType,
    this.deleteAt,
    this.otpTime,
    this.otpVerify,
    this.employeeCode,
    this.otherEmployeeCode,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      type: json['type'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      password: json['password'],
      mobileNumber: json['mobile_number'],
      dob: json['dob'],
      emailVerifiedAt: json['email_verified_at']?.toString(),
      gender: json['gender'],
      status: json['status'],
      position: json['position'],
      age: json['age']?.toString(),
      otp: json['otp']?.toString(),
      image: json['image'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at']?.toString(),
      rememberToken: json['remember_token']?.toString(),
      deviceToken: json['device_token']?.toString(),
      deviceType: json['device_type'],
      deleteAt: json['delete_at']?.toString(),
      otpTime: json['otp_time']?.toString(),
      otpVerify: json['otp_verify'],
      employeeCode: json['employee_code'],
      otherEmployeeCode: json['other_employee_code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'password': password,
      'mobile_number': mobileNumber,
      'dob': dob,
      'email_verified_at': emailVerifiedAt,
      'gender': gender,
      'status': status,
      'position': position,
      'age': age,
      'otp': otp,
      'image': image,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
      'remember_token': rememberToken,
      'device_token': deviceToken,
      'device_type': deviceType,
      'delete_at': deleteAt,
      'otp_time': otpTime,
      'otp_verify': otpVerify,
      'employee_code': employeeCode,
      'other_employee_code': otherEmployeeCode,
    };
  }
}
