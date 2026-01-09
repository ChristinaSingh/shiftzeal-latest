import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/common_methods.dart';
import 'package:shiftzeal/common/common_widgets.dart';
import 'package:shiftzeal/constants/icons_constant.dart';
import 'package:shiftzeal/constants/string_constants.dart';
import 'package:shiftzeal/screens/send_message_user/send_message_user_controller.dart';
import 'package:shiftzeal/screens/shift_swap/shift_swap_screen.dart';

import 'send_message_user_controller.dart';

class SendMessageUserScreen extends StatefulWidget {
  const SendMessageUserScreen({super.key});

  @override
  State<SendMessageUserScreen> createState() => SendMessageUserScreenState();
}

class SendMessageUserScreenState extends State<SendMessageUserScreen> {
  @override
  void initState() {
    super.initState();
    var sendMessageUserController =
        Provider.of<SendMessageUserController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SendMessageUserController>(
      builder: (context, controller, child) {
        return Scaffold(
          appBar: CommonWidgets.appBar(
              context: context, title: StringConstants.sendMessage),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Padding(
            padding: EdgeInsets.all(24.px),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CommonWidgets.commonElevatedButton(
                    borderRadius: 15.px,
                    context: context,
                    onPressed: () =>
                        controller.clickOnChangeShiftButton(context: context),
                    text: StringConstants.sendMessage),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.px, vertical: 20.px),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      onTap: () =>
                          controller.clickOnSearchBar(context: context),
                      readOnly: true,
                      controller: controller.searchController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Theme.of(context).scaffoldBackgroundColor,
                        hintText: StringConstants.search,
                        prefixIcon: CommonMethods.appIcons(
                            assetName: IconConstants.icSearch),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10.px),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(24.px),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(24.px),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(24.px),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(24.px),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(24.px),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(24.px),
                        ),
                        hintStyle: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.px),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height,
                    width: MediaQuery.sizeOf(context).width,
                    child: GridView.builder(
                      // padding: EdgeInsets.symmetric(horizontal: 16.px),
                      itemCount: shiftList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12.px,
                        mainAxisSpacing: 12.px,
                        childAspectRatio: 0.80,
                      ),
                      itemBuilder: (context, index) {
                        final shift = shiftList[index];
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
                                  Padding(
                                    padding: EdgeInsets.all(12.px),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 60,
                                          width: 60,
                                          padding: EdgeInsets.all(6.px),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                          ),
                                          child: Center(
                                            child: Text(shift.profileImageUrl,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    color: Theme.of(context)
                                                        .scaffoldBackgroundColor,
                                                    fontSize: 14.px)),
                                          ),
                                        ),
                                        SizedBox(height: 10.px),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(shift.name,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 16.px)),
                                          ],
                                        ),
                                        SizedBox(height: 8.px),
                                      ],
                                    ),
                                  ),
                                  if (isSelected)
                                    Positioned(
                                      top: 12.px,
                                      right: 12.px,
                                      child: Icon(
                                        Icons.radio_button_checked,
                                        color: Colors.red,
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

final shiftList = [
  ShiftModel(
    name: 'Lydia',
    tag: 'SPS',
    profileImageUrl: 'Ly',
  ),
  ShiftModel(
    name: 'Greta',
    tag: 'SPS',
    profileImageUrl: 'Gr',
  ),
  ShiftModel(
    name: 'Greta',
    tag: 'SPS',
    profileImageUrl: 'Gr',
  ),
  ShiftModel(
    name: 'Greta',
    tag: 'SPS',
    profileImageUrl: 'Gr',
  ),
  ShiftModel(
    name: 'Greta',
    tag: 'SPS',
    profileImageUrl: 'Gr',
  ),
  ShiftModel(
    name: 'Greta',
    tag: 'SPS',
    profileImageUrl: 'Gr',
  ),
  // Add more...
];

class ShiftModel {
  final String name;
  final String tag;
  final String profileImageUrl;

  ShiftModel({
    required this.name,
    required this.tag,
    required this.profileImageUrl,
  });
}
