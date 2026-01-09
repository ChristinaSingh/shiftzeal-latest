class GetTermsAndConditionsModel {
  bool? success;
  List<GetTermsAndConditionsData>? data;
  String? message;
  String? status;

  GetTermsAndConditionsModel(
      {this.success, this.data, this.message, this.status});

  GetTermsAndConditionsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <GetTermsAndConditionsData>[];
      json['data'].forEach((v) {
        data!.add(new GetTermsAndConditionsData.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}

class GetTermsAndConditionsData {
  int? tacId;
  String? tacText;
  String? tacCreatedAt;
  String? tacUpdatedAt;
  Null? tacDeletedAt;
  String? tacAdminStatus;

  GetTermsAndConditionsData(
      {this.tacId,
        this.tacText,
        this.tacCreatedAt,
        this.tacUpdatedAt,
        this.tacDeletedAt,
        this.tacAdminStatus});

  GetTermsAndConditionsData.fromJson(Map<String, dynamic> json) {
    tacId = json['tac_id'];
    tacText = json['tac_text'];
    tacCreatedAt = json['tac_created_at'];
    tacUpdatedAt = json['tac_updated_at'];
    tacDeletedAt = json['tac_deleted_at'];
    tacAdminStatus = json['tac_admin_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tac_id'] = this.tacId;
    data['tac_text'] = this.tacText;
    data['tac_created_at'] = this.tacCreatedAt;
    data['tac_updated_at'] = this.tacUpdatedAt;
    data['tac_deleted_at'] = this.tacDeletedAt;
    data['tac_admin_status'] = this.tacAdminStatus;
    return data;
  }
}
