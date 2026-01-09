class OrganizationRegistrationModel {
  bool? success;
  Data? data;
  String? message;
  String? notification;
  String? error;
  String? status;

  OrganizationRegistrationModel({
    this.success,
    this.data,
    this.message,
    this.notification,
    this.error,
    this.status,
  });

  factory OrganizationRegistrationModel.fromJson(Map<String, dynamic> json) {
    return OrganizationRegistrationModel(
      success: json['success'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
      message: json['message'],
      notification: json['notification'],
      error: json['error'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.toJson(),
      'message': message,
      'notification': notification,
      'error': error,
      'status': status,
    };
  }
}

class Data {
  UserData? userData;
  String? token;

  Data({this.userData, this.token});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      userData: json['user_data'] != null ? UserData.fromJson(json['user_data']) : null,
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_data': userData?.toJson(),
      'token': token,
    };
  }
}

class UserData {
  String? firstName;
  String? lastName;
  String? mobileNumber;
  String? email;
  String? organizationName;
  String? dateOfIncorporation;
  int? employeeCode;
  String? updatedAt;
  String? createdAt;
  int? id;

  UserData({
    this.firstName,
    this.lastName,
    this.mobileNumber,
    this.email,
    this.organizationName,
    this.dateOfIncorporation,
    this.employeeCode,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      firstName: json['first_name'],
      lastName: json['last_name'],
      mobileNumber: json['mobile_number'],
      email: json['email'],
      organizationName: json['organization_name'],
      dateOfIncorporation: json['date_of_incorporation'],
      employeeCode: json['employee_code'],
      updatedAt: json['updated_at'],
      createdAt: json['created_at'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'mobile_number': mobileNumber,
      'email': email,
      'organization_name': organizationName,
      'date_of_incorporation': dateOfIncorporation,
      'employee_code': employeeCode,
      'updated_at': updatedAt,
      'created_at': createdAt,
      'id': id,
    };
  }
}
