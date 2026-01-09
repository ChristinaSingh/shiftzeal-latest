import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/common_widgets.dart';

import '../../common/common_methods.dart';
import '../../constants/icons_constant.dart';
import '../../constants/string_constants.dart';
import 'annotation_controller.dart';

class AnnotationScreen extends StatefulWidget {
  const AnnotationScreen({super.key});

  @override
  State<AnnotationScreen> createState() => _AnnotationScreenState();
}

class _AnnotationScreenState extends State<AnnotationScreen> {
  @override
  void initState() {
    super.initState();
    var annotationController =
        Provider.of<AnnotationController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AnnotationController>(
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
              context: context, title: StringConstants.addAnnotation),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.px),
              child: Column(
                children: [
                  SizedBox(height: 30.px),
                  textField(
                      hintText: 'Date',
                      suffixIcon: CommonMethods.appIcons(
                          assetName: IconConstants.icCalendarJob,
                          height: 20.px,
                          width: 20.px)),
                  SizedBox(height: 30.px),
                  textField(
                      hintText: 'To Date',
                      suffixIcon: CommonMethods.appIcons(
                          assetName: IconConstants.icCalendarJob,
                          height: 20.px,
                          width: 20.px)),
                  SizedBox(height: 30.px),
                  textField(hintText: 'Title'),
                  SizedBox(height: 30.px),
                  textField(hintText: 'Message'),
                  SizedBox(height: 30.px),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Announcement",
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(fontSize: 14.px),
                      ),
                      SizedBox(
                        height: 24.px,
                        width: 40.px,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: CupertinoSwitch(
                            value: true,
                            activeColor:
                                Theme.of(context).colorScheme.secondary,
                            onChanged: (bool value) {},
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.px),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Business Closed",
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(fontSize: 14.px),
                      ),
                      SizedBox(
                        height: 24.px,
                        width: 40.px,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: CupertinoSwitch(
                            value: true,
                            activeColor:
                                Theme.of(context).colorScheme.secondary,
                            onChanged: (bool value) {},
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.px),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "No Time Off",
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(fontSize: 14.px),
                      ),
                      SizedBox(
                        height: 24.px,
                        width: 40.px,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: CupertinoSwitch(
                            value: true,
                            activeColor:
                                Theme.of(context).colorScheme.secondary,
                            onChanged: (bool value) {},
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.px),
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
