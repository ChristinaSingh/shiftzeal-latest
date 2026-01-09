import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/common_methods.dart';
import 'package:shiftzeal/common/common_widgets.dart';
import 'package:shiftzeal/constants/icons_constant.dart';

import '../../constants/string_constants.dart';
import 'add_user_controller.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  @override
  void initState() {
    super.initState();
    var addUserController =
        Provider.of<AddUserController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddUserController>(
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
              context: context, title: StringConstants.addUser),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.px),
              child: Column(
                children: [
                  SizedBox(height: 10.px),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(75.px),
                    child: CommonWidgets.appIcons(
                        assetName: IconConstants.icUserLogoPng,
                        height: 100.px,
                        width: 100.px),
                  ),
                  SizedBox(height: 20.px),
                  Text(
                    'Add Photo',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontSize: 16.px,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  SizedBox(height: 20.px),
                  textField(hintText: 'First Name'),
                  SizedBox(height: 20.px),
                  textField(hintText: 'Last Name'),
                  SizedBox(height: 20.px),
                  textField(hintText: 'Phone'),
                  SizedBox(height: 20.px),
                  textField(hintText: 'Email'),
                  SizedBox(height: 20.px),
                  textField(hintText: 'Employee ID'),
                  SizedBox(height: 20.px),
                  textField(hintText: 'Role'),
                  SizedBox(height: 20.px),
                  textField(hintText: 'Max Hours/Week'),
                  SizedBox(height: 20.px),
                  textField(hintText: 'Timezone'),
                  SizedBox(height: 20.px),
                  textField(hintText: 'Note'),
                  SizedBox(height: 20.px),
                  Row(
                    children: [
                      Expanded(
                          child: textField(
                              hintText: 'User',
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  controller.clickAddUserIcon(context: context);
                                },
                                child: CommonMethods.appIcons(
                                    assetName: IconConstants.icAddSquare,
                                    color: Color(0XFF292D32)),
                              ))),
                      SizedBox(width: 10.px),
                      Expanded(
                          child: textField(
                              hintText: 'Position',
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  controller.clickAddPositionIcon(
                                      context: context);
                                },
                                child: CommonMethods.appIcons(
                                    assetName: IconConstants.icAddSquare,
                                    color: Color(0XFF292D32)),
                              ))),
                    ],
                  ),
                  SizedBox(height: 150.px),
                ],
              ),
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
      readOnly: false,
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
            ?.copyWith(fontSize: 14.px, color: Color(0XFF292D32)),
      ),
    );
  }
}
