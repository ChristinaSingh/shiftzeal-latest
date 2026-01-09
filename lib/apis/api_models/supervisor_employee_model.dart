class SupervisorEmployeeModel {
  bool? success;
  List<EmployeesData>? data;
  String? message;
  dynamic notification;
  dynamic error;
  String? status;

  SupervisorEmployeeModel({
    this.success,
    this.data,
    this.message,
    this.notification,
    this.error,
    this.status,
  });

  SupervisorEmployeeModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(EmployeesData.fromJson(v));
      });
    }
    message = json['message'];
    notification = json['notification'];
    error = json['error'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data!.map((v) => v.toJson()).toList();
    }
    map['message'] = message;
    map['notification'] = notification;
    map['error'] = error;
    map['status'] = status;
    return map;
  }
}

class EmployeesData {
  int? id;
  String? type;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? mobileNumber;
  String? dob;
  dynamic emailVerifiedAt;
  String? gender;
  String? status;
  String? position;
  dynamic age;
  dynamic otp;
  String? image;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  dynamic rememberToken;
  dynamic deviceToken;
  String? deviceType;
  dynamic deleteAt;
  dynamic otpTime;
  dynamic otpVerify;
  String? employeeCode;
  dynamic otherEmployeeCode;
  dynamic organizationName;
  dynamic dateOfIncorporation;
  String? supervisorId;

  EmployeesData({
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
    this.organizationName,
    this.dateOfIncorporation,
    this.supervisorId,
  });

  EmployeesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    password = json['password'];
    mobileNumber = json['mobile_number'];
    dob = json['dob'];
    emailVerifiedAt = json['email_verified_at'];
    gender = json['gender'];
    status = json['status'];
    position = json['position'];
    age = json['age'];
    otp = json['otp'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    rememberToken = json['remember_token'];
    deviceToken = json['device_token'];
    deviceType = json['device_type'];
    deleteAt = json['delete_at'];
    otpTime = json['otp_time'];
    otpVerify = json['otp_verify'];
    employeeCode = json['employee_code'];
    otherEmployeeCode = json['other_employee_code'];
    organizationName = json['organization_name'];
    dateOfIncorporation = json['date_of_incorporation'];
    supervisorId = json['supervisor_id'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['type'] = type;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['email'] = email;
    map['password'] = password;
    map['mobile_number'] = mobileNumber;
    map['dob'] = dob;
    map['email_verified_at'] = emailVerifiedAt;
    map['gender'] = gender;
    map['status'] = status;
    map['position'] = position;
    map['age'] = age;
    map['otp'] = otp;
    map['image'] = image;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
    map['remember_token'] = rememberToken;
    map['device_token'] = deviceToken;
    map['device_type'] = deviceType;
    map['delete_at'] = deleteAt;
    map['otp_time'] = otpTime;
    map['otp_verify'] = otpVerify;
    map['employee_code'] = employeeCode;
    map['other_employee_code'] = otherEmployeeCode;
    map['organization_name'] = organizationName;
    map['date_of_incorporation'] = dateOfIncorporation;
    map['supervisor_id'] = supervisorId;
    return map;
  }
}
