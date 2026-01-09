import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shiftzeal/constants/icons_constant.dart';
import 'package:shiftzeal/constants/image_constants.dart';
import 'package:shiftzeal/screens/chat_detail/chat_detail_screen.dart';
import '../../apis/api_constants/api_key_constants.dart';
import '../../apis/api_methods/api_methods.dart';
import '../../apis/api_models/get_all_users_list_model.dart';
import '../../apis/api_models/get_last_message_list_model.dart';
import '../../common/navigation_methos.dart';
import '../../common/common_widgets.dart';
import '../chat_detail/chat_detail_controller.dart';

class ChatController extends ChangeNotifier {
  TextEditingController searchController = TextEditingController();

  bool inAsyncCall = false;
  List<UserData> allUsersList = [];
  List<LastMessageData> lastMessages = [];

  Timer? _timer; // timer reference

  Future<void> fetchAllUsers({required BuildContext context}) async {
    inAsyncCall = true;
    notifyListeners();
    SharedPreferences sp = await SharedPreferences.getInstance();
    String userId = sp.getString(ApiKeyConstants.userId) ?? "0";

    final body = {
      ApiKeyConstants.userId: userId,
    };

    final response = await ApiMethods.getAllUsersApi(
      context: context,
      bodyParams: body,
    );

    inAsyncCall = false;
    notifyListeners();

    if (response == null) {
      CommonWidgets.showMyToastMessage("No response from server");
      return;
    }

    if (response.success == true && response.data != null) {
      allUsersList = response.data!;
      notifyListeners();
    } else {
      CommonWidgets.showMyToastMessage(response.message ?? "Error occurred");
    }
  }

  Future<void> fetchLastMessages({required BuildContext context}) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String userId = sp.getString(ApiKeyConstants.userId) ?? "0";

    final body = {
      ApiKeyConstants.userId: userId,
    };

    final response = await ApiMethods.getLastMessagesApi(
      context: context,
      bodyParams: body,
    );

    if (response == null) {
      CommonWidgets.showMyToastMessage("No response from server");
      return;
    }

    if (response.success == true && response.data != null) {
      lastMessages = response.data!;
      notifyListeners();
    } else {
      CommonWidgets.showMyToastMessage(response.message ?? "Error occurred");
    }
  }

  /// Start polling last messages every 5 seconds
  void startLastMessagesPolling(BuildContext context) {
    _timer?.cancel(); // agar pehle se timer chal raha h to cancel
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      fetchLastMessages(context: context);
    });
  }

  /// Stop polling (jab screen dispose ho jaye)
  void stopLastMessagesPolling() {
    _timer?.cancel();
  }

  /// On clicking search bar
  void clickOnSearchBar({required BuildContext context}) {}

  /// On clicking a chat user
  void clickOnListTile({
    required BuildContext context,
    required UserData user,
    required String receiverId,
    required String receiverName,
  }) {
    final controller =
        Provider.of<ChatDetailController>(context, listen: false);
    controller.chatHistory.clear();
    controller.notifyListeners();
    NavigationMethods.pushMethod(
      context: context,
      widget: ChatDetailScreen(
        senderId: user.id?.toString() ?? '',
        userName: "${user.firstName ?? ''} ${user.lastName ?? ''}",
        receiverId: receiverId,
        receiverName: receiverName,
      ),
    );
  }
}
