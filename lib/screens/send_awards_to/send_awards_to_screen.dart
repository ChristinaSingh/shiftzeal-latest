import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/common_methods.dart';
import 'package:shiftzeal/common/common_widgets.dart';
import 'package:shiftzeal/constants/icons_constant.dart';
import 'package:shiftzeal/constants/image_constants.dart';

import '../../constants/string_constants.dart';
import '../shift_swap/shift_swap_screen.dart';
import 'send_awards_to_controller.dart';

class SendAwardsToScreen extends StatefulWidget {
  const SendAwardsToScreen({super.key});

  @override
  State<SendAwardsToScreen> createState() => SendAwardsToScreenState();
}

class SendAwardsToScreenState extends State<SendAwardsToScreen> {
  @override
  void initState() {
    super.initState();
    var sendAwardsToController =
        Provider.of<SendAwardsToController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SendAwardsToController>(
      builder: (context, controller, child) {
        return Scaffold(
          appBar: CommonWidgets.appBar(context: context),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.all(24.px),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CommonWidgets.commonElevatedButton(
                    context: context,
                    borderRadius: 15.px,
                    height: 60.px,
                    onPressed: () =>
                        controller.clickOnListTile3(context: context, index: 0),
                    text: StringConstants.sendAwards),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.px, vertical: 20.px),
              child: Column(
                children: [
                  Container(
                    height: 130.px,
                    width: 130.px,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.px)),
                    child: CommonWidgets.imageView(
                        image: 'https://randomuser.me/api/portraits/men/5.jpg'),
                  ),
                  SizedBox(height: 10.px),
                  Text(
                    'Emerson Flip',
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium
                        ?.copyWith(fontSize: 16.px),
                  ),
                  SizedBox(height: 10.px),
                  Text(
                    'SPS',
                    maxLines: 2,
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(fontSize: 12.px),
                  ),
                  SizedBox(height: 30.px),

                  SizedBox(
                    height: 280,
                    width: MediaQuery.sizeOf(context).width,
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      // padding: EdgeInsets.symmetric(horizontal: 16.px),
                      itemCount: award.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12.px,
                        mainAxisSpacing: 12.px,
                        childAspectRatio: 1.3,
                      ),
                      itemBuilder: (context, index) {
                        final shift = award[index];
                        final isSelected = controller.selectedValue == index;

                        return GestureDetector(
                          onTap: () => controller.clickOnListTile(
                              context: context, index: index),
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 200),
                            opacity: isSelected ? 1.0 : 0.4,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.px),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Stack(
                                children: [
                                  Container(
                                    width: 180,
                                    height: 130.px,
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? Theme.of(context)
                                              .colorScheme
                                              .secondary
                                          : Colors.white,
                                      // blue background
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Icon with checkmark

                                        index == 0
                                            ? CommonWidgets.appIcons(
                                                assetName: ImageConstants
                                                    .imageTheSolutionMakerAward,
                                                height: 30.px,
                                                width: 30.px)
                                            : index == 1
                                                ? CommonWidgets.appIcons(
                                                    assetName: ImageConstants
                                                        .imageHeartOfLionAward,
                                                    height: 30.px,
                                                    width: 30.px)
                                                : index == 2
                                                    ? CommonWidgets.appIcons(
                                                        assetName: IconConstants
                                                            .icPeopleMoney,
                                                        height: 30.px,
                                                        width: 30.px)
                                                    : CommonWidgets.appIcons(
                                                        assetName: IconConstants
                                                            .icPeopleStar,
                                                        height: 30.px,
                                                        width: 30.px),

                                        const SizedBox(height: 12),
                                        Text(
                                          shift.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.copyWith(
                                                color: isSelected
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (isSelected)
                                    Positioned(
                                      top: 12.px,
                                      right: 12.px,
                                      child: Icon(
                                        Icons.radio_button_checked,
                                        color: Theme.of(context).primaryColor,
                                        size: 20.px,
                                      ),
                                    )
                                  else
                                    Positioned(
                                      top: 12.px,
                                      right: 12.px,
                                      child: Icon(
                                        Icons.radio_button_unchecked,
                                        color: Colors.grey,
                                        size: 20.px,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 10.px),
                  // SizedBox(
                  //   height: 400.px,
                  //   child: GridView.builder(
                  //     // padding: EdgeInsets.symmetric(horizontal: 16.px),
                  //     itemCount: shiftList.length,
                  //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //       crossAxisCount: 2,
                  //       crossAxisSpacing: 12.px,
                  //       mainAxisSpacing: 12.px,
                  //       childAspectRatio: 0.80,
                  //     ),
                  //     itemBuilder: (context, index) {
                  //       final shift = shiftList[index];
                  //       final isSelected = controller.selectedValue == index;
                  //
                  //       return GestureDetector(
                  //         onTap: () => controller.clickOnListTile(
                  //             context: context, index: index),
                  //         child: AnimatedOpacity(
                  //           duration: const Duration(milliseconds: 200),
                  //           opacity: isSelected ? 1.0 : 0.4,
                  //           child: Container(
                  //             decoration: BoxDecoration(
                  //               color: Colors.white,
                  //               borderRadius: BorderRadius.circular(20.px),
                  //               boxShadow: [
                  //                 BoxShadow(
                  //                   color: Colors.black.withOpacity(0.05),
                  //                   blurRadius: 8,
                  //                   offset: const Offset(0, 4),
                  //                 ),
                  //               ],
                  //             ),
                  //             child: Stack(
                  //               children: [
                  //                 Padding(
                  //                   padding: EdgeInsets.all(12.px),
                  //                   child: Column(
                  //                     crossAxisAlignment:
                  //                     CrossAxisAlignment.center,
                  //                     children: [
                  //                       CircleAvatar(
                  //                         radius: 28.px,
                  //                         backgroundImage: NetworkImage(
                  //                             shift.profileImageUrl),
                  //                       ),
                  //                       SizedBox(height: 10.px),
                  //                       Row(
                  //                         mainAxisAlignment:
                  //                         MainAxisAlignment.center,
                  //                         children: [
                  //                           Text(
                  //                               shift.name,
                  //                               style: TextStyle(
                  //                                   fontWeight: FontWeight.w700,
                  //                                   fontSize: 16.px
                  //                               )
                  //                           ),
                  //                           SizedBox(width: 4.px),
                  //                           Text(
                  //                               shift.tag,
                  //                               style: TextStyle(
                  //                                   fontWeight: FontWeight.w700,
                  //                                   fontSize: 11.px,
                  //                                   color: Theme.of(context).colorScheme.secondary
                  //                               )
                  //                           ),
                  //                         ],
                  //                       ),
                  //                       SizedBox(height: 8.px),
                  //                       Text(
                  //                           "March 26, 2025  9:00 AM - 5:00 PM",
                  //                           textAlign: TextAlign.center,
                  //                           style: TextStyle(
                  //                               fontWeight: FontWeight.w400,
                  //                               fontSize: 10.px,
                  //                               color: Colors.grey
                  //                           )
                  //                       ),
                  //                       SizedBox(height: 8.px),
                  //                       Text(
                  //                           "123 Main Street, NY",
                  //                           textAlign: TextAlign.center,
                  //                           style: TextStyle(
                  //                               fontWeight: FontWeight.w400,
                  //                               fontSize: 10.px,
                  //                               color: Colors.grey
                  //                           )
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ),
                  //                 if (isSelected)
                  //                   Positioned(
                  //                     top: 12.px,
                  //                     right: 12.px,
                  //                     child: Icon(
                  //                       Icons.radio_button_checked,
                  //                       color: Colors.red,
                  //                       size: 20.px,
                  //                     ),
                  //                   )
                  //                 else
                  //                   Positioned(
                  //                     top: 12.px,
                  //                     right: 12.px,
                  //                     child: Icon(
                  //                       Icons.radio_button_unchecked,
                  //                       color: Colors.grey,
                  //                       size: 20.px,
                  //                     ),
                  //                   ),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                  SizedBox(height: 20.px),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Message',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(fontSize: 16.px),
                    ),
                  ),
                  SizedBox(height: 20.px),
                  textField(hintText: 'Type Here', maxLines: 4),
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

final award = [
  Award(
    name: 'Heart of Lion Award',
    tag: 'SPS',
    profileImageUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
  ),
  Award(
    name: 'The Solution Maker Award',
    tag: 'SPS',
    profileImageUrl: 'https://randomuser.me/api/portraits/women/2.jpg',
  ),
  Award(
    name: 'Well Done Award',
    tag: 'SPS',
    profileImageUrl: 'https://randomuser.me/api/portraits/women/2.jpg',
  ),
  Award(
    name: 'Employee of the Month',
    tag: 'SPS',
    profileImageUrl: 'https://randomuser.me/api/portraits/women/2.jpg',
  ),
  // Add more...
];

class Award {
  final String name;
  final String tag;
  final String profileImageUrl;

  Award({
    required this.name,
    required this.tag,
    required this.profileImageUrl,
  });
}
