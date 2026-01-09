import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/common_methods.dart';
import 'package:shiftzeal/common/common_widgets.dart';
import 'package:shiftzeal/constants/icons_constant.dart';
import 'package:shiftzeal/constants/string_constants.dart';

import 'admin_positions_controller.dart';

class AdminPositionsScreen extends StatefulWidget {
  const AdminPositionsScreen({super.key});

  @override
  State<AdminPositionsScreen> createState() => AdminPositionsScreenState();
}

class AdminPositionsScreenState extends State<AdminPositionsScreen> {
  @override
  void initState() {
    super.initState();
    var adminPositionsController =
        Provider.of<AdminPositionsController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminPositionsController>(
      builder: (context, controller, child) {
        return Scaffold(
          appBar: CommonWidgets.appBar(
              context: context,
              title: StringConstants.addPositions,
          ),
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
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.px, vertical: 20.px),
              child: Column(
                children: [
                  SizedBox(height: 20.px),
                  textField(
                      hintText: 'Position',
                      suffixIcon: CommonMethods.appIcons(
                          assetName: IconConstants.icNameLogo,
                          height: 20.px,
                          width: 20.px)),
                  SizedBox(height: 20.px),
                  textField(hintText: 'Default color',
                      suffixIcon: CommonMethods.appIcons(
                          assetName: IconConstants.icDefaultColor,
                          height: 20.px,
                          width: 20.px)),
                  SizedBox(height: 20.px),
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
      //readOnly: true,
      maxLines: maxLines,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xffF8F8F8),
        hintText: hintText,
        prefixIcon: suffixIcon,
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
