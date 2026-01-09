import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/common_widgets.dart';

import '../../common/common_methods.dart';
import '../../constants/icons_constant.dart';
import '../../constants/string_constants.dart';
import 'admin_send_message_controller.dart';

class AdminSendMessageScreen extends StatefulWidget {
  const AdminSendMessageScreen({super.key});

  @override
  State<AdminSendMessageScreen> createState() => _AdminSendMessageScreenState();
}

class _AdminSendMessageScreenState extends State<AdminSendMessageScreen> {
  @override
  void initState() {
    super.initState();
    var adminSendMessageController =
        Provider.of<AdminSendMessageController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminSendMessageController>(
      builder: (context, controller, child) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          bottomSheet: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            height: 100.px,
            child: Padding(
              padding: EdgeInsets.all(24.px),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CommonWidgets.commonElevatedButton(
                      context: context,
                      borderRadius: 15,
                      onPressed: () =>
                          controller.clickOnSaveButton(context: context),
                      text: StringConstants.add),
                ],
              ),
            ),
          ),
          appBar: CommonWidgets.appBar(
              context: context, title: StringConstants.sendMessage),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20.px,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 30.px,
                    ),
                    Text(
                      "SEND MESSAGE TO:",
                      style: TextStyle(
                        fontSize: 14.px,
                        fontWeight: FontWeight.w700,
                        color: Color(0XFF999999),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.px,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.px),
                  child: Column(
                    children: [
                      SizedBox(height: 10.px),
                      Row(
                        children: [
                          Expanded(
                              child: textField(
                                  hintText: 'User',
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      controller.clickOnAddUserButton(
                                          context: context);
                                    },
                                    child: CommonMethods.appIcons(
                                        assetName: IconConstants.icAddSquare,
                                        color: Color(0XFF292D32)),
                                  ))),
                          SizedBox(width: 20.px),
                          Expanded(
                            child: textField(
                                hintText: 'Position',
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    controller.clickOnAddPositionButton(
                                        context: context);
                                  },
                                  child: CommonMethods.appIcons(
                                      assetName: IconConstants.icAddSquare,
                                      color: Color(0XFF292D32)),
                                )),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.px),
                      SizedBox(height: 10.px),
                      textField(hintText: 'Subject'),
                      SizedBox(height: 10.px),
                      textField(hintText: 'Message'),
                      SizedBox(height: 150.px),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget textField(
      {required String hintText, Widget? suffixIcon, int? maxLines}) {
    return TextField(
      //onTap: () => controller.clickOnSearchBar(context: context),
      //readOnly: true,
      maxLines: maxLines,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xffF8F8F8),
        hintText: hintText,
        suffixIcon: suffixIcon,
        //contentPadding: EdgeInsets.symmetric(horizontal: 10.px),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(15.px),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(15.px),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(15.px),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(15.px),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(15.px),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(15.px),
        ),
        hintStyle: Theme.of(context)
            .textTheme
            .headlineMedium
            ?.copyWith(fontSize: 14.px),
      ),
    );
  }
}
