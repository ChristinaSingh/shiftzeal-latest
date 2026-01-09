import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../apis/api_methods/api_methods.dart';

import '../../apis/api_constants/api_url_constants.dart';
import '../../apis/api_constants/api_key_constants.dart';
import '../../common/common_widgets.dart';

class SendMessageController extends ChangeNotifier {
  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  bool isLoading = false;
  Future<void> clickOnSendMessageButton({required BuildContext context}) async {
    String subject = subjectController.text.trim();
    String message = messageController.text.trim();

    if (subject.isEmpty || message.isEmpty) {
      CommonWidgets.showMyToastMessage("Please fill all fields");
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      SharedPreferences sp = await SharedPreferences.getInstance();
      String userId = sp.getString(ApiKeyConstants.userId) ?? "0";

      final body = {
        "user_id": userId,
        "subject": subject,
        "message": message,
        "email_sender_id": "21", // fixed
      };

      final response = await ApiMethods.sendMailToAuthorityApi(
        context: context,
        bodyParams: body,
      );

      if (response != null && response.success == true) {
        CommonWidgets.showMyToastMessage(
            "Mail sent successfully");


        subjectController.clear();
        messageController.clear();
      } else {
        CommonWidgets.showMyToastMessage(
            response?.message ?? "Failed to send mail");
      }
    } catch (e) {
      CommonWidgets.showMyToastMessage("Error: $e");
    }

    isLoading = false;
    notifyListeners();
  }
}
