import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/common_methods.dart';
import 'package:shiftzeal/common/common_widgets.dart';
import 'package:shiftzeal/constants/icons_constant.dart';
import 'package:shiftzeal/constants/string_constants.dart';

import 'contact_information_controller.dart';

class ContactInformationScreen extends StatefulWidget {
  const ContactInformationScreen({super.key});

  @override
  State<ContactInformationScreen> createState() =>
      ContactInformationScreenState();
}

class ContactInformationScreenState extends State<ContactInformationScreen> {
  @override
  void initState() {
    super.initState();
    var contactInformationController =
        Provider.of<ContactInformationController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ContactInformationController>(
      builder: (context, controller, child) {
        return Scaffold(
          appBar: CommonWidgets.appBar(
              context: context, title: StringConstants.contactUs),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.px, vertical: 20.px),
              child: Column(
                children: [
                  SizedBox(height: 20.px),
                  Center(
                    child: CommonMethods.appIcons(
                      assetName: IconConstants.icSplashLogo,
                      height: 104.px,
                      width: 100.px,
                    ),
                  ),
                  SizedBox(height: 60.px),
                  GestureDetector(
                    onTap: () => controller.clickOnListTile(context: context),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 8.px),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.px),
                            color: Theme.of(context).scaffoldBackgroundColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                spreadRadius: 0,
                                blurRadius: 20, // Increased blur radius
                                offset: Offset(0, 4),
                              )
                            ]),
                        child: Padding(
                          padding: EdgeInsets.all(16.px),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CommonMethods.appIcons(
                                assetName: IconConstants.icContactUsProfile,
                                height: 34.px,
                                width: 34.px,
                              ),
                              SizedBox(width: 20.px),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      '3111 Builder Dr',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium
                                          ?.copyWith(fontSize: 16.px),
                                    ),
                                    SizedBox(height: 10.px),
                                    Text(
                                      'Madison, WI 53783',
                                      maxLines: 2,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium
                                          ?.copyWith(fontSize: 12.px),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => controller.clickOnListTile(context: context),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 8.px),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.px),
                            color: Theme.of(context).scaffoldBackgroundColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                spreadRadius: 0,
                                blurRadius: 20, // Increased blur radius
                                offset: Offset(0, 4),
                              )
                            ]),
                        child: Padding(
                          padding: EdgeInsets.all(16.px),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CommonMethods.appIcons(
                                assetName: IconConstants.icMobileFill,
                                height: 34.px,
                                width: 34.px,
                              ),
                              SizedBox(width: 20.px),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'Mobile Number',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium
                                          ?.copyWith(fontSize: 16.px),
                                    ),
                                    SizedBox(height: 10.px),
                                    Text(
                                      '(608) 555-1234',
                                      maxLines: 2,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium
                                          ?.copyWith(fontSize: 12.px),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => controller.clickOnListTile(context: context),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 8.px),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.px),
                            color: Theme.of(context).scaffoldBackgroundColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                spreadRadius: 0,
                                blurRadius: 20, // Increased blur radius
                                offset: Offset(0, 4),
                              )
                            ]),
                        child: Padding(
                          padding: EdgeInsets.all(16.px),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CommonMethods.appIcons(
                                assetName: IconConstants.icSmsFill,
                                height: 34.px,
                                width: 34.px,
                              ),
                              SizedBox(width: 20.px),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'Email Address',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium
                                          ?.copyWith(fontSize: 16.px),
                                    ),
                                    SizedBox(height: 10.px),
                                    Text(
                                      'abc@gmail.com',
                                      maxLines: 2,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium
                                          ?.copyWith(fontSize: 12.px),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => controller.clickOnSubmitATicketListTile(
                        context: context),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 8.px),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.px),
                            color: Theme.of(context).scaffoldBackgroundColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                spreadRadius: 0,
                                blurRadius: 20, // Increased blur radius
                                offset: Offset(0, 4),
                              )
                            ]),
                        child: Padding(
                          padding: EdgeInsets.all(16.px),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CommonMethods.appIcons(
                                assetName: IconConstants.icContactUsProfile,
                                height: 34.px,
                                width: 34.px,
                              ),
                              SizedBox(width: 20.px),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'Submit a ticket',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium
                                          ?.copyWith(fontSize: 16.px),
                                    ),
                                    SizedBox(height: 10.px),
                                    Text(
                                      'ticket',
                                      maxLines: 2,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium
                                          ?.copyWith(fontSize: 12.px),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => controller.clickOnListTile(context: context),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 8.px),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.px),
                            color: Theme.of(context).scaffoldBackgroundColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                spreadRadius: 0,
                                blurRadius: 20, // Increased blur radius
                                offset: Offset(0, 4),
                              )
                            ]),
                        child: Padding(
                          padding: EdgeInsets.all(16.px),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CommonMethods.appIcons(
                                assetName: IconConstants.icSWebsiteFill,
                                height: 34.px,
                                width: 34.px,
                              ),
                              SizedBox(width: 20.px),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'Website',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium
                                          ?.copyWith(fontSize: 16.px),
                                    ),
                                    SizedBox(height: 10.px),
                                    Text(
                                      'Visit my website',
                                      maxLines: 2,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium
                                          ?.copyWith(fontSize: 12.px),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
