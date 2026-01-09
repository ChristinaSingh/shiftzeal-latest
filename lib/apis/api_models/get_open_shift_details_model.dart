class GetOpenShiftDetailsModel {
  bool? success;
  List<OpenShiftData>? data;
  String? message;
  dynamic notification;
  dynamic error;
  String? status;

  GetOpenShiftDetailsModel({
    this.success,
    this.data,
    this.message,
    this.notification,
    this.error,
    this.status,
  });

  factory GetOpenShiftDetailsModel.fromJson(Map<String, dynamic> json) {
    return GetOpenShiftDetailsModel(
      success: json['success'],
      data: (json['data'] as List?)?.map((e) => OpenShiftData.fromJson(e)).toList(),
      message: json['message'],
      notification: json['notification'],
      error: json['error'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'data': data?.map((e) => e.toJson()).toList(),
    'message': message,
    'notification': notification,
    'error': error,
    'status': status,
  };
}
class OpenShiftData {
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
  AdminDetails? adminDetails;

  OpenShiftData({
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

  factory OpenShiftData.fromJson(Map<String, dynamic> json) => OpenShiftData(
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
        ? AdminDetails.fromJson(json['admin_details'])
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
    'admin_details': adminDetails?.toJson(),
  };
}
class AdminDetails {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? countryCode;
  String? createdAt;
  String? updatedAt;
  String? code;
  String? profileImage;
  String? adminStatus;

  dynamic emailVerifiedAt;
  dynamic password;
  dynamic rememberToken;
  dynamic userName;
  dynamic country;
  dynamic lat;
  dynamic long;
  dynamic androidId;
  dynamic iosId;
  dynamic activeStatus;
  dynamic deleteStatus;
  dynamic deletedAt;

  AdminDetails({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.countryCode,
    this.createdAt,
    this.updatedAt,
    this.code,
    this.profileImage,
    this.adminStatus,
    this.emailVerifiedAt,
    this.password,
    this.rememberToken,
    this.userName,
    this.country,
    this.lat,
    this.long,
    this.androidId,
    this.iosId,
    this.activeStatus,
    this.deleteStatus,
    this.deletedAt,
  });

  factory AdminDetails.fromJson(Map<String, dynamic> json) => AdminDetails(
    id: json['id'],
    email: json['email'],
    firstName: json['first_name'],
    lastName: json['last_name'],
    phoneNumber: json['phone_number'],
    countryCode: json['country_code'],
    createdAt: json['created_at'],
    updatedAt: json['updated_at'],
    code: json['code'],
    profileImage: json['profile_image'],
    adminStatus: json['admin_status'],
    emailVerifiedAt: json['email_verified_at'],
    password: json['password'],
    rememberToken: json['remember_token'],
    userName: json['user_name'],
    country: json['country'],
    lat: json['lat'],
    long: json['long'],
    androidId: json['android_id'],
    iosId: json['ios_id'],
    activeStatus: json['active_status'],
    deleteStatus: json['delete_status'],
    deletedAt: json['deleted_at'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'first_name': firstName,
    'last_name': lastName,
    'phone_number': phoneNumber,
    'country_code': countryCode,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'code': code,
    'profile_image': profileImage,
    'admin_status': adminStatus,
    'email_verified_at': emailVerifiedAt,
    'password': password,
    'remember_token': rememberToken,
    'user_name': userName,
    'country': country,
    'lat': lat,
    'long': long,
    'android_id': androidId,
    'ios_id': iosId,
    'active_status': activeStatus,
    'delete_status': deleteStatus,
    'deleted_at': deletedAt,
  };
}
