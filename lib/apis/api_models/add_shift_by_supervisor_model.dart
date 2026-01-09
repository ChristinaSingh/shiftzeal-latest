class AddShiftModel {
  final String? status;
  final String? message;
  final int? shiftId;

  AddShiftModel({
    this.status,
    this.message,
    this.shiftId,
  });

  factory AddShiftModel.fromJson(Map<String, dynamic> json) {
    return AddShiftModel(
      status: json['status'],
      message: json['message'],
      shiftId: json['shift_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'shift_id': shiftId,
    };
  }
}
