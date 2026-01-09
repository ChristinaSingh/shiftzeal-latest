class AllShiftsModel {
  bool? success;
  List<ShiftData>? data;
  String? message;
  dynamic notification;
  dynamic error;
  String? status;

  AllShiftsModel({
    this.success,
    this.data,
    this.message,
    this.notification,
    this.error,
    this.status,
  });

  AllShiftsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <ShiftData>[];
      json['data'].forEach((v) {
        data!.add(ShiftData.fromJson(v));
      });
    }
    message = json['message'];
    notification = json['notification'];
    error = json['error'];
    status = json['status'];
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

class ShiftData {
  int? id;
  String? adminId;
  int? userId;
  String? score;
  String? shiftDate;
  String? startTime;
  String? endTime;
  String? address;
  String? position;
  String? amount;
  String? status;
  String? checkInDate;
  String? checkOutDate;
  String? cancelIds;
  String? checkinLat;
  String? checkinLon;
  String? checkinAddress;
  String? lat;
  String? lon;
  String? createdAt;
  String? updatedAt;
  String? name;
  UserDetails? userDetails;

  ShiftData({
    this.id,
    this.adminId,
    this.userId,
    this.shiftDate,
    this.startTime,
    this.endTime,
    this.address,
    this.position,
    this.amount,
    this.status,
    this.checkInDate,
    this.score,
    this.checkOutDate,
    this.cancelIds,
    this.checkinLat,
    this.checkinLon,
    this.checkinAddress,
    this.lat,
    this.lon,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.userDetails,
  });

  ShiftData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    adminId = json['admin_id'];
    userId = json['user_id'];
    shiftDate = json['shift_date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    address = json['address'];
    position = json['position'];
    amount = json['amount'];
    status = json['status'];
    checkInDate = json['check_in_date'];
    checkOutDate = json['check_out_date'];
    cancelIds = json['cancel_ids'];
    checkinLat = json['checkin_lat'];
    checkinLon = json['checkin_lon'];
    checkinAddress = json['checkin_address'];
    lat = json['lat'];
    score = json['score'];
    lon = json['lon'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    userDetails = json['user_details'] != null
        ? UserDetails.fromJson(json['user_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'admin_id': adminId,
      'user_id': userId,
      'shift_date': shiftDate,
      'start_time': startTime,
      'end_time': endTime,
      'address': address,
      'position': position,
      'amount': amount,
      'status': status,
      'check_in_date': checkInDate,
      'check_out_date': checkOutDate,
      'cancel_ids': cancelIds,
      'checkin_lat': checkinLat,
      'checkin_lon': checkinLon,
      'checkin_address': checkinAddress,
      'lat': lat,
      'lon': lon,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'name': name,
      'score': score,
      'user_details': userDetails?.toJson(),
    };
  }
}

class UserDetails {
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
  String? organizationName;
  String? dateOfIncorporation;

  UserDetails({
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
  });

  UserDetails.fromJson(Map<String, dynamic> json) {
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
    age = json['age']?.toString();
    otp = json['otp']?.toString();
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
      'organization_name': organizationName,
      'date_of_incorporation': dateOfIncorporation,
    };
  }
}
