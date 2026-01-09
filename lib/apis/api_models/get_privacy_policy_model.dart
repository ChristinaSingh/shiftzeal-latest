class GetPrivacyPolicyModel {
  bool? success;
  List<GetPrivacyPolicyData>? data;
  String? message;
  String? status;

  GetPrivacyPolicyModel({this.success, this.data, this.message, this.status});

  GetPrivacyPolicyModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <GetPrivacyPolicyData>[];
      json['data'].forEach((v) {
        data!.add(new GetPrivacyPolicyData.fromJson(v));
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

class GetPrivacyPolicyData {
  int? privacyPolicyId;
  String? privacyPolicyText;
  String? privacyPolicyCreatedAt;
  String? privacyPolicyUpdatedAt;
  Null? privacyPolicyDeletedAt;
  String? privacyPolicyAdminStatus;

  GetPrivacyPolicyData(
      {this.privacyPolicyId,
        this.privacyPolicyText,
        this.privacyPolicyCreatedAt,
        this.privacyPolicyUpdatedAt,
        this.privacyPolicyDeletedAt,
        this.privacyPolicyAdminStatus});

  GetPrivacyPolicyData.fromJson(Map<String, dynamic> json) {
    privacyPolicyId = json['privacy_policy_id'];
    privacyPolicyText = json['privacy_policy_text'];
    privacyPolicyCreatedAt = json['privacy_policy_created_at'];
    privacyPolicyUpdatedAt = json['privacy_policy_updated_at'];
    privacyPolicyDeletedAt = json['privacy_policy_deleted_at'];
    privacyPolicyAdminStatus = json['privacy_policy_admin_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['privacy_policy_id'] = this.privacyPolicyId;
    data['privacy_policy_text'] = this.privacyPolicyText;
    data['privacy_policy_created_at'] = this.privacyPolicyCreatedAt;
    data['privacy_policy_updated_at'] = this.privacyPolicyUpdatedAt;
    data['privacy_policy_deleted_at'] = this.privacyPolicyDeletedAt;
    data['privacy_policy_admin_status'] = this.privacyPolicyAdminStatus;
    return data;
  }
}
