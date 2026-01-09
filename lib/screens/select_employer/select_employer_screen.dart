import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/common_methods.dart';
import 'package:shiftzeal/common/common_widgets.dart';
import 'package:shiftzeal/constants/icons_constant.dart';
import 'package:shiftzeal/constants/string_constants.dart';

import 'select_employer_controller.dart';

class SelectEmployerScreen extends StatefulWidget {
  const SelectEmployerScreen({super.key});

  @override
  State<SelectEmployerScreen> createState() => SelectEmployerScreenState();
}

class SelectEmployerScreenState extends State<SelectEmployerScreen> {
  @override
  void initState() {
    super.initState();
    var selectEmployerController =
        Provider.of<SelectEmployerController>(context, listen: false);
  }

  bool isJoinSelected = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectEmployerController>(
      builder: (context, controller, child) {
        return Scaffold(
          appBar: CommonWidgets.appBar(
              context: context, title: StringConstants.selectEmployer),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.px),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 40.px),
                  Center(
                    child: Text(
                      StringConstants.lookingForAnotherEmployer,
                      softWrap: false,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14.px,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(height: 55.px),
                  Row(
                    children: [
                      Expanded(
                        child: buildOption(
                          title: "Join a Registered Employer",
                          icon: IconConstants.icJoinEmployer,
                          isSelected: isJoinSelected,
                          onTap: () {
                            setState(() => isJoinSelected = true);
                            if (isJoinSelected) {
                              controller.clickOnJoinARegisteredEmployer(
                                  context: context);
                            } else {
                              controller.clickOnCreateANewEmployer(
                                  context: context);
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: buildOption(
                          title: "Create a New Employer",
                          icon: IconConstants.icAddEmployer,
                          isSelected: !isJoinSelected,
                          onTap: () {
                            setState(() => isJoinSelected = false);
                            if (isJoinSelected) {
                              controller.clickOnJoinARegisteredEmployer(
                                  context: context);
                            } else {
                              controller.clickOnCreateANewEmployer(
                                  context: context);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50.px),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 24.px),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: [
                  //       GestureDetector(
                  //         onTap: () => controller
                  //             .clickOnJoinARegisteredEmployer(context: context),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.start,
                  //           crossAxisAlignment: CrossAxisAlignment.center,
                  //           children: [
                  //             CommonMethods.appIcons(
                  //               assetName: IconConstants.icRegisteredEmployer,
                  //               height: 34.px,
                  //               width: 34.px,
                  //             ),
                  //             SizedBox(width: 20.px),
                  //             Expanded(
                  //               child: Text(
                  //                 StringConstants.joinARegisteredEmployer,
                  //                 style: Theme.of(context)
                  //                     .textTheme
                  //                     .displayMedium
                  //                     ?.copyWith(fontSize: 16.px),
                  //               ),
                  //             ),
                  //             CommonMethods.appIcons(
                  //               assetName: IconConstants.icNextArrow,
                  //               width: 18.px,
                  //               height: 10.px,
                  //             )
                  //           ],
                  //         ),
                  //       ),
                  //       SizedBox(height: 14.px),
                  //       Divider(
                  //         color: Theme.of(context)
                  //             .colorScheme
                  //             .surface
                  //             .withOpacity(.4.px),
                  //         height: .2.px,
                  //       ),
                  //       SizedBox(height: 20.px),
                  //       GestureDetector(
                  //         onTap: () => controller.clickOnCreateANewEmployer(
                  //             context: context),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.start,
                  //           crossAxisAlignment: CrossAxisAlignment.center,
                  //           children: [
                  //             CommonMethods.appIcons(
                  //               assetName: IconConstants.icNewEmployer,
                  //               height: 34.px,
                  //               width: 34.px,
                  //             ),
                  //             SizedBox(width: 20.px),
                  //             Expanded(
                  //               child: Text(
                  //                 StringConstants.createANewEmployer,
                  //                 style: Theme.of(context)
                  //                     .textTheme
                  //                     .displayMedium
                  //                     ?.copyWith(fontSize: 16.px),
                  //               ),
                  //             ),
                  //             CommonMethods.appIcons(
                  //               assetName: IconConstants.icNextArrow,
                  //               width: 18.px,
                  //               height: 10.px,
                  //             )
                  //           ],
                  //         ),
                  //       ),
                  //       SizedBox(height: 14.px),
                  //       Divider(
                  //         color: Theme.of(context)
                  //             .colorScheme
                  //             .surface
                  //             .withOpacity(.4.px),
                  //         height: .2.px,
                  //       ),
                  //       SizedBox(height: 14.px),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(height: 20.px),
                  // CommonWidgets.lightBlueColorContainerText(
                  //   title: 'MY EMPLOYER',
                  //   context: context,
                  // ),
                  // SizedBox(height: 38.px),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 24.px),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: [
                  //       GestureDetector(
                  //         onTap: () => controller
                  //             .clickOnJoinARegisteredEmployer(context: context),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.start,
                  //           crossAxisAlignment: CrossAxisAlignment.center,
                  //           children: [
                  //             CommonMethods.appIcons(
                  //               assetName: IconConstants.icRegisteredEmployer,
                  //               height: 34.px,
                  //               width: 34.px,
                  //             ),
                  //             SizedBox(width: 20.px),
                  //             Expanded(
                  //               child: Column(
                  //                 crossAxisAlignment: CrossAxisAlignment.start,
                  //                 children: [
                  //                   Text(
                  //                     'Hope Community Support Service',
                  //                     style: Theme.of(context)
                  //                         .textTheme
                  //                         .displayMedium
                  //                         ?.copyWith(fontSize: 16.px),
                  //                   ),
                  //                   SizedBox(height: 8.px),
                  //                   Text(
                  //                     'Employee',
                  //                     style: Theme.of(context)
                  //                         .textTheme
                  //                         .titleSmall
                  //                         ?.copyWith(fontSize: 12.px),
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //             CommonMethods.appIcons(
                  //               assetName: IconConstants.icNextArrow,
                  //               width: 18.px,
                  //               height: 10.px,
                  //             )
                  //           ],
                  //         ),
                  //       ),
                  //       SizedBox(height: 14.px),
                  //       Divider(
                  //         color: Theme.of(context)
                  //             .colorScheme
                  //             .surface
                  //             .withOpacity(.4.px),
                  //         height: .2.px,
                  //       ),
                  //       SizedBox(height: 14.px),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildOption({
    required String title,
    required String icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.onPrimary
              : const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).colorScheme.secondary
                : Colors.transparent,
            width: 2,
          ),
          boxShadow: isSelected
              ? [BoxShadow(color: Colors.blue.withOpacity(0.2), blurRadius: 10)]
              : [],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CommonMethods.appIcons(
                assetName: icon, height: 49.px, width: 49.px),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15.px,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
