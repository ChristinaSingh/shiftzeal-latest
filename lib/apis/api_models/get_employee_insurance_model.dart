class GetEmployeeInsuranceModel {
  bool? success;
  List<InsuranceData>? data;
  String? message;
  dynamic notification;
  dynamic error;
  String? status;

  GetEmployeeInsuranceModel({
    this.success,
    this.data,
    this.message,
    this.notification,
    this.error,
    this.status,
  });

  factory GetEmployeeInsuranceModel.fromJson(Map<String, dynamic> json) {
    return GetEmployeeInsuranceModel(
      success: json['success'],
      data: json['data'] != null
          ? List<InsuranceData>.from(
          json['data'].map((v) => InsuranceData.fromJson(v)))
          : null,
      message: json['message'],
      notification: json['notification'],
      error: json['error'],
      status: json['status'],
    );
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

class InsuranceData {
  int? id;
  int? userId;
  String? memberName;
  String? groupId;
  String? groupName;
  String? effectiveDate;
  String? plan;
  String? rxBinPcn;
  String? dependents;
  String? createdAt;
  String? updatedAt;
  String? type;

  InsuranceData({
    this.id,
    this.userId,
    this.memberName,
    this.groupId,
    this.groupName,
    this.effectiveDate,
    this.plan,
    this.rxBinPcn,
    this.dependents,
    this.createdAt,
    this.updatedAt,
    this.type,
  });

  factory InsuranceData.fromJson(Map<String, dynamic> json) {
    return InsuranceData(
      id: json['id'],
      userId: json['user_id'],
      memberName: json['member_name'],
      groupId: json['group_id'],
      groupName: json['group_name'],
      effectiveDate: json['effective_date'],
      plan: json['plan'],
      rxBinPcn: json['rx_bin_pcn'],
      dependents: json['dependents'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'member_name': memberName,
      'group_id': groupId,
      'group_name': groupName,
      'effective_date': effectiveDate,
      'plan': plan,
      'rx_bin_pcn': rxBinPcn,
      'dependents': dependents,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'type': type,
    };
  }
}
