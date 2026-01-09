class GetRunningShiftModel {
  bool? success;
  Data? data;
  String? message;
  dynamic notification;
  dynamic error;
  String? status;

  GetRunningShiftModel({
    this.success,
    this.data,
    this.message,
    this.notification,
    this.error,
    this.status,
  });

  factory GetRunningShiftModel.fromJson(Map<String, dynamic> json) {
    return GetRunningShiftModel(
      success: json['success'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
      message: json['message'],
      notification: json['notification'],
      error: json['error'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'data': data?.toJson(),
    'message': message,
    'notification': notification,
    'error': error,
    'status': status,
  };
}

class Data {
  RunningShift? runningShift;
  RunningShift? nextShift;

  Data({this.runningShift, this.nextShift});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    runningShift: json['running_shift'] != null
        ? RunningShift.fromJson(json['running_shift'])
        : null,
    nextShift: json['next_shift'] != null
        ? RunningShift.fromJson(json['next_shift'])
        : null,
  );

  Map<String, dynamic> toJson() => {
    'running_shift': runningShift?.toJson(),
    'next_shift': nextShift?.toJson(),
  };
}

class RunningShift {
  int? id;
  int? userId;
  String? shiftDate;
  String? startTime;
  String? endTime;
  String? address;
  String? position;
  String? status;
  String? adminId;
  String? checkInDate;
  String? checkOutDate;
  String? createdAt;
  String? updatedAt;
  String? cancelIds;
  dynamic checkinAddress;
  dynamic checkinLat;
  dynamic checkinLon;
  UserDetails? adminDetails; // ✅ Corrected name from userDetails to adminDetails

  RunningShift({
    this.id,
    this.userId,
    this.shiftDate,
    this.startTime,
    this.endTime,
    this.address,
    this.position,
    this.status,
    this.adminId,
    this.checkInDate,
    this.checkOutDate,
    this.createdAt,
    this.updatedAt,
    this.cancelIds,
    this.checkinAddress,
    this.checkinLat,
    this.checkinLon,
    this.adminDetails,
  });

  factory RunningShift.fromJson(Map<String, dynamic> json) => RunningShift(
    id: json['id'],
    userId: json['user_id'],
    shiftDate: json['shift_date'],
    startTime: json['start_time'],
    endTime: json['end_time'],
    address: json['address'],
    position: json['position'],
    status: json['status'],
    adminId: json['admin_id'],
    checkInDate: json['check_in_date'],
    checkOutDate: json['check_out_date'],
    createdAt: json['created_at'],
    updatedAt: json['updated_at'],
    cancelIds: json['cancel_ids'],
    checkinAddress: json['checkin_address'],
    checkinLat: json['checkin_lat'],
    checkinLon: json['checkin_lon'],
    adminDetails: json['admin_details'] != null
        ? UserDetails.fromJson(json['admin_details'])
        : null,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'shift_date': shiftDate,
    'start_time': startTime,
    'end_time': endTime,
    'address': address,
    'position': position,
    'status': status,
    'admin_id': adminId,
    'check_in_date': checkInDate,
    'check_out_date': checkOutDate,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'cancel_ids': cancelIds,
    'checkin_address': checkinAddress,
    'checkin_lat': checkinLat,
    'checkin_lon': checkinLon,
    'admin_details': adminDetails?.toJson(), // ✅ Corrected key
  };
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
  dynamic emailVerifiedAt;
  String? gender;
  String? status;
  String? position;
  dynamic age;
  dynamic otp;
  dynamic image;
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
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
    id: json['id'],
    type: json['type'],
    firstName: json['first_name'],
    lastName: json['last_name'],
    email: json['email'],
    password: json['password'],
    mobileNumber: json['mobile_number'],
    dob: json['dob'],
    emailVerifiedAt: json['email_verified_at'],
    gender: json['gender'],
    status: json['status'],
    position: json['position'],
    age: json['age'],
    otp: json['otp'],
    image: json['image'],
    createdAt: json['created_at'],
    updatedAt: json['updated_at'],
    deletedAt: json['deleted_at'],
    rememberToken: json['remember_token'],
    deviceToken: json['device_token'],
    deviceType: json['device_type'],
    deleteAt: json['delete_at'],
    otpTime: json['otp_time'],
    otpVerify: json['otp_verify'],
    employeeCode: json['employee_code'],
  );

  Map<String, dynamic> toJson() => {
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
  };
}
