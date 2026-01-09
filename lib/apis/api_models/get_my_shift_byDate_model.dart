class GetMyShiftsByDataModel {
  bool? success;
  ShiftCategoriesData? data;
  String? message;
  String? notification;
  String? error;
  String? status;

  GetMyShiftsByDataModel({
    this.success,
    this.data,
    this.message,
    this.notification,
    this.error,
    this.status,
  });

  GetMyShiftsByDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? ShiftCategoriesData.fromJson(json['data']) : null;
    message = json['message'];
    notification = json['notification'];
    error = json['error'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['success'] = success;
    result['data'] = data?.toJson();
    result['message'] = message;
    result['notification'] = notification;
    result['error'] = error;
    result['status'] = status;
    return result;
  }
}

class ShiftCategoriesData {
  List<ShiftData>? myShifts;
  List<ShiftData>? onShiftNow;
  List<ShiftData>? onShiftLater;
  List<ShiftData>? openShifts;

  ShiftCategoriesData({
    this.myShifts,
    this.onShiftNow,
    this.onShiftLater,
    this.openShifts,
  });

  ShiftCategoriesData.fromJson(Map<String, dynamic> json) {
    myShifts = (json['my_shifts'] as List?)?.map((v) => ShiftData.fromJson(v)).toList();
    onShiftNow = (json['on_shift_now'] as List?)?.map((v) => ShiftData.fromJson(v)).toList();
    onShiftLater = (json['on_shift_later'] as List?)?.map((v) => ShiftData.fromJson(v)).toList();
    openShifts = (json['open_shifts'] as List?)?.map((v) => ShiftData.fromJson(v)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['my_shifts'] = myShifts?.map((v) => v.toJson()).toList();
    result['on_shift_now'] = onShiftNow?.map((v) => v.toJson()).toList();
    result['on_shift_later'] = onShiftLater?.map((v) => v.toJson()).toList();
    result['open_shifts'] = openShifts?.map((v) => v.toJson()).toList();
    return result;
  }
}

class ShiftData {
  int? id;
  int? userId;
  String? shiftDate;
  String? startTime;
  String? endTime;
  String? address;
  String? createdAt;
  String? updatedAt;
  String? adminId;
  String? image;
  int? assignId;
  String? status;

  ShiftData({
    this.id,
    this.userId,
    this.shiftDate,
    this.startTime,
    this.endTime,
    this.address,
    this.createdAt,
    this.updatedAt,
    this.adminId,
    this.image,
    this.assignId,
    this.status,
  });

  ShiftData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    shiftDate = json['shift_date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    address = json['address'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    adminId = json['admin_id'];
    image = json['image'];
    assignId = json['assign_id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['id'] = id;
    result['user_id'] = userId;
    result['shift_date'] = shiftDate;
    result['start_time'] = startTime;
    result['end_time'] = endTime;
    result['address'] = address;
    result['created_at'] = createdAt;
    result['updated_at'] = updatedAt;
    result['admin_id'] = adminId;
    result['image'] = image;
    result['assign_id'] = assignId;
    result['status'] = status;
    return result;
  }
}
