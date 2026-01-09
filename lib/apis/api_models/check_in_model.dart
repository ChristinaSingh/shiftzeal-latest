class CheckInModel {
  bool? success;
  Data? data;
  String? message;
  dynamic notification;
  dynamic error;
  String? status;

  CheckInModel({
    this.success,
    this.data,
    this.message,
    this.notification,
    this.error,
    this.status,
  });

  CheckInModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
    notification = json['notification'];
    error = json['error'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['success'] = success;
    if (data != null) {
      json['data'] = data!.toJson();
    }
    json['message'] = message;
    json['notification'] = notification;
    json['error'] = error;
    json['status'] = status;
    return json;
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
  String? checkinLat;
  String? checkinLon;
  dynamic lat;
  dynamic lon;

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
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    shiftDate = json['shift_date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    address = json['address'];
    position = json['position'];
    status = json['status'];
    adminId = json['admin_id'];
    checkInDate = json['check_in_date'];
    checkOutDate = json['check_out_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    cancelIds = json['cancel_ids'];
    checkinAddress = json['checkin_address'];
    checkinLat = json['checkin_lat'];
    checkinLon = json['checkin_lon'];
    lat = json['lat'];
    lon = json['lon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['id'] = id;
    json['user_id'] = userId;
    json['name'] = name;
    json['shift_date'] = shiftDate;
    json['start_time'] = startTime;
    json['end_time'] = endTime;
    json['address'] = address;
    json['position'] = position;
    json['status'] = status;
    json['admin_id'] = adminId;
    json['check_in_date'] = checkInDate;
    json['check_out_date'] = checkOutDate;
    json['created_at'] = createdAt;
    json['updated_at'] = updatedAt;
    json['cancel_ids'] = cancelIds;
    json['checkin_address'] = checkinAddress;
    json['checkin_lat'] = checkinLat;
    json['checkin_lon'] = checkinLon;
    json['lat'] = lat;
    json['lon'] = lon;
    return json;
  }
}
