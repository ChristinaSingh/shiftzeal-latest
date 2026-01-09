import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/common_methods.dart';
import 'package:shiftzeal/constants/icons_constant.dart';
import 'package:shiftzeal/constants/string_constants.dart';

import '../../common/common_widgets.dart';
import 'create_your_employer_controller.dart';

class CreateYourEmployerScreen extends StatefulWidget {
  const CreateYourEmployerScreen({super.key});

  @override
  State<CreateYourEmployerScreen> createState() =>
      _CreateYourEmployerScreenState();
}

class _CreateYourEmployerScreenState extends State<CreateYourEmployerScreen> {
  @override
  void initState() {
    super.initState();
    var createYourEmployerController =
        Provider.of<CreateYourEmployerController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateYourEmployerController>(
      builder: (context, controller, child) {
        return Scaffold(
          appBar: CommonWidgets.appBar(
            context: context,
            title: StringConstants.createANewEmployer,
          ),
          bottomSheet: Container(
            height: 100.px,
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Padding(
              padding: EdgeInsets.all(24.px),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CommonWidgets.commonElevatedButton(
                      context: context,
                      borderRadius: 15,
                      onPressed: () => controller.clickOnCreateEmployerButton(
                          context: context),
                      text: StringConstants.createEmployer),
                ],
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.px),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20.px),
                  textField(hintText: StringConstants.employerName),
                  SizedBox(height: 20.px),
                  textField(hintText: StringConstants.address),
                  SizedBox(height: 20.px),
                  textField(hintText: StringConstants.numberOfUsers),
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
      fillColor: Color(0xffF8F8F8),
      hintText: hintText,
      suffixIcon: suffixIcon,
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
      hintStyle:
          Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 14.px),
    );
  }

  Widget textField(
      {required String hintText, Widget? suffixIcon, int? maxLines}) {
    return TextField(
      //onTap: () => controller.clickOnSearchBar(context: context),
      //readOnly: true,
      style:
          Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 14.px),
      maxLines: maxLines,
      decoration: decorationForFields(
        hintText: hintText,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
