class GetAnnouncementModel {
  final bool? success;
  final List<AnnouncementData>? data;
  final String? message;
  final dynamic notification;
  final dynamic error;
  final String? status;

  GetAnnouncementModel({
    this.success,
    this.data,
    this.message,
    this.notification,
    this.error,
    this.status,
  });

  factory GetAnnouncementModel.fromJson(Map<String, dynamic> json) {
    return GetAnnouncementModel(
      success: json['success'],
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => AnnouncementData.fromJson(e))
          .toList(),
      message: json['message'],
      notification: json['notification'],
      error: json['error'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.map((e) => e.toJson()).toList(),
      'message': message,
      'notification': notification,
      'error': error,
      'status': status,
    };
  }
}
class AnnouncementData {
  final int? id;
  final String? title;
  final String? content;
  final String? image;
  final String? createdAt;
  final String? updatedAt;
  final int? userId;
  final AdminDetails? adminDetails;

  AnnouncementData({
    this.id,
    this.title,
    this.content,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.adminDetails,
  });

  factory AnnouncementData.fromJson(Map<String, dynamic> json) {
    return AnnouncementData(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      image: json['image'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      userId: json['user_id'],
      adminDetails: json['admin_details'] != null
          ? AdminDetails.fromJson(json['admin_details'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'image': image,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'user_id': userId,
      'admin_details': adminDetails?.toJson(),
    };
  }
}
class AdminDetails {
  final int? id;
  final String? type;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;
  final String? mobileNumber;
  final String? dob;
  final String? gender;
  final String? status;
  final String? position;
  final String? image;
  final String? createdAt;
  final String? updatedAt;
  final String? deviceType;
  final String? employeeCode;

  final dynamic emailVerifiedAt;
  final dynamic age;
  final dynamic otp;
  final dynamic deletedAt;
  final dynamic rememberToken;
  final dynamic deviceToken;
  final dynamic deleteAt;
  final dynamic otpTime;
  final dynamic otpVerify;

  AdminDetails({
    this.id,
    this.type,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.mobileNumber,
    this.dob,
    this.gender,
    this.status,
    this.position,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.deviceType,
    this.employeeCode,
    this.emailVerifiedAt,
    this.age,
    this.otp,
    this.deletedAt,
    this.rememberToken,
    this.deviceToken,
    this.deleteAt,
    this.otpTime,
    this.otpVerify,
  });

  factory AdminDetails.fromJson(Map<String, dynamic> json) {
    return AdminDetails(
      id: json['id'],
      type: json['type'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      password: json['password'],
      mobileNumber: json['mobile_number'],
      dob: json['dob'],
      gender: json['gender'],
      status: json['status'],
      position: json['position'],
      image: json['image'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deviceType: json['device_type'],
      employeeCode: json['employee_code'],
      emailVerifiedAt: json['email_verified_at'],
      age: json['age'],
      otp: json['otp'],
      deletedAt: json['deleted_at'],
      rememberToken: json['remember_token'],
      deviceToken: json['device_token'],
      deleteAt: json['delete_at'],
      otpTime: json['otp_time'],
      otpVerify: json['otp_verify'],
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
      'gender': gender,
      'status': status,
      'position': position,
      'image': image,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'device_type': deviceType,
      'employee_code': employeeCode,
      'email_verified_at': emailVerifiedAt,
      'age': age,
      'otp': otp,
      'deleted_at': deletedAt,
      'remember_token': rememberToken,
      'device_token': deviceToken,
      'delete_at': deleteAt,
      'otp_time': otpTime,
      'otp_verify': otpVerify,
    };
  }
}
