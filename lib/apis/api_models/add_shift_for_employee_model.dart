class AddNewShiftForEmployeeModel {
  bool? success;
  Data? data;
  String? message;
  dynamic notification;
  dynamic error;
  String? status;

  AddNewShiftForEmployeeModel({
    this.success,
    this.data,
    this.message,
    this.notification,
    this.error,
    this.status,
  });

  factory AddNewShiftForEmployeeModel.fromJson(Map<String, dynamic> json) {
    return AddNewShiftForEmployeeModel(
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
  int? id;
  int? userId;
  String? name;
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
  String? checkinAddress;
  double? checkinLat;
  double? checkinLon;
  double? lat;
  double? lon;
  String? amount;

  Data({
    this.id,
    this.userId,
    this.name,
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
    this.lat,
    this.lon,
    this.amount,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
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
      checkinLat: (json['checkin_lat'] != null) ? double.tryParse(json['checkin_lat'].toString()) : null,
      checkinLon: (json['checkin_lon'] != null) ? double.tryParse(json['checkin_lon'].toString()) : null,
      lat: (json['lat'] != null) ? double.tryParse(json['lat'].toString()) : null,
      lon: (json['lon'] != null) ? double.tryParse(json['lon'].toString()) : null,
      amount: json['amount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'name': name,
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
      'lat': lat,
      'lon': lon,
      'amount': amount,
    };
  }
}
