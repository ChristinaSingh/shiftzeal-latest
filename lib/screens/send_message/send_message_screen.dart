import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/common_methods.dart';
import 'package:shiftzeal/constants/icons_constant.dart';
import 'package:shiftzeal/constants/string_constants.dart';
import '../../common/common_widgets.dart';
import '../../common/navigation_methos.dart';
import '../send_message_user/send_message_user_screen.dart';
import 'send_message_controller.dart';

class SendMessageScreen extends StatefulWidget {
  const SendMessageScreen({super.key});

  @override
  State<SendMessageScreen> createState() => _SendMessageScreenState();
}

class _SendMessageScreenState extends State<SendMessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SendMessageController>(
      builder: (context, controller, child) {
        return Scaffold(
          appBar: CommonWidgets.appBar(
            context: context,
            title: StringConstants.sendMessage,
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.all(24.px),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CommonWidgets.commonCustumeButton(
                  onPressed: () async {
                    controller.clickOnSendMessageButton(context: context);
                  },
                  borderRadius: 15.px,
                  buttonColor: Theme.of(context).primaryColor,
                  child: Text(
                    StringConstants.sendMessage,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  showLoading: controller.isLoading,
                  context: context,
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.px),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20.px),

                  /// Select Manager/Supervisor
                  InkWell(
                    onTap: () {
                      NavigationMethods.pushMethod(
                        context: context,
                        widget: SendMessageUserScreen(),
                      );
                    },
                    child: textField(
                      hintText: StringConstants.managerSupervisor,
                      readOnly: true,
                      suffixIcon: CommonMethods.appIcons(
                        assetName: IconConstants.icAddSquare,
                      ),
                    ),
                  ),

                  SizedBox(height: 20.px),

                  /// Subject
                  textField(
                    hintText: StringConstants.subject,
                    controller: controller.subjectController,
                  ),

                  SizedBox(height: 20.px),

                  /// Message
                  textField(
                    hintText: StringConstants.message,
                    controller: controller.messageController,
                    maxLines: 10,
                  ),

                  SizedBox(height: 20.px),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  decorationForFields({required String hintText, Widget? suffixIcon}) {
    return InputDecoration(
      filled: true,
      fillColor: const Color(0xffF8F8F8),
      hintText: hintText,
      suffixIcon: suffixIcon,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(15.px),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(15.px),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(15.px),
      ),
      hintStyle: Theme.of(context)
          .textTheme
          .titleSmall
          ?.copyWith(fontSize: 14.px, color: Colors.black),
    );
  }

  Widget textField({
    required String hintText,
    TextEditingController? controller,
    Widget? suffixIcon,
    int? maxLines,
    bool? readOnly,
  }) {
    return TextField(
      controller: controller,
      readOnly: readOnly ?? false,
      style:
          Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 14.px),
      maxLines: maxLines ?? 1,
      decoration: decorationForFields(
        hintText: hintText,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
