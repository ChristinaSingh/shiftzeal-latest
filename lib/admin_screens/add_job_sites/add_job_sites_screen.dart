import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/common_methods.dart';
import 'package:shiftzeal/common/common_widgets.dart';
import 'package:shiftzeal/constants/icons_constant.dart';

import '../../constants/string_constants.dart';
import 'add_job_sites_controller.dart';

class AddJobSitesScreen extends StatefulWidget {
  const AddJobSitesScreen({super.key});

  @override
  State<AddJobSitesScreen> createState() => _AddJobSitesScreenState();
}

class _AddJobSitesScreenState extends State<AddJobSitesScreen> {
  @override
  void initState() {
    super.initState();
    var addJobSitesController =
        Provider.of<AddJobSitesController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddJobSitesController>(
      builder: (context, controller, child) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          // floatingActionButtonLocation:
          //     FloatingActionButtonLocation.centerDocked,
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
              context: context, title: StringConstants.addJobSite),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.px),
              child: Column(
                children: [
                  SizedBox(height: 20.px),
                  textField(
                      hintText: 'Name',
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
                  textField(hintText: 'Address',
                      suffixIcon: CommonMethods.appIcons(
                          assetName: IconConstants.icLocationJobSite,
                          height: 20.px,
                          width: 20.px)),
                  SizedBox(height: 20.px),
                  textField(hintText: 'All Schedules',
                      suffixIcon: CommonMethods.appIcons(
                          assetName: IconConstants.icCalendarJob,
                          height: 20.px,
                          width: 20.px)),
                  SizedBox(height: 20.px),
                  textField(hintText: 'Notes',
                      suffixIcon: CommonMethods.appIcons(
                          assetName: IconConstants.icNotSite,
                          height: 20.px,
                          width: 20.px)),
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
