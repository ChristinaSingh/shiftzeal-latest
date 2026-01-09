class GetOpenShiftAcceptRejectModel {
  final bool? success;
  final ShiftData? data;
  final String? message;
  final dynamic notification;
  final dynamic error;
  final String? status;

  GetOpenShiftAcceptRejectModel({
    this.success,
    this.data,
    this.message,
    this.notification,
    this.error,
    this.status,
  });

  factory GetOpenShiftAcceptRejectModel.fromJson(Map<String, dynamic> json) {
    return GetOpenShiftAcceptRejectModel(
      success: json['success'],
      data: json['data'] != null ? ShiftData.fromJson(json['data']) : null,
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

class ShiftData {
  final int? id;
  final int? userId;
  final String? shiftDate;
  final String? startTime;
  final String? endTime;
  final String? address;
  final String? position;
  final String? status;
  final String? adminId;
  final String? checkInDate;
  final String? checkOutDate;
  final String? createdAt;
  final String? updatedAt;
  final String? cancelIds;
  final dynamic checkinAddress;
  final dynamic checkinLat;
  final dynamic checkinLon;

  ShiftData({
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
  });

  factory ShiftData.fromJson(Map<String, dynamic> json) {
    return ShiftData(
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
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
    };
  }
}
