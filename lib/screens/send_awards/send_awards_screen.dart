import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/common_methods.dart';
import 'package:shiftzeal/common/common_widgets.dart';
import 'package:shiftzeal/constants/icons_constant.dart';
import 'package:shiftzeal/constants/string_constants.dart';

import 'send_awards_controller.dart';

class SendAwardsScreen extends StatefulWidget {
  const SendAwardsScreen({super.key});

  @override
  State<SendAwardsScreen> createState() => SendAwardsScreenState();
}

class SendAwardsScreenState extends State<SendAwardsScreen> {
  @override
  void initState() {
    super.initState();
    var sendAwardsController =
        Provider.of<SendAwardsController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SendAwardsController>(
      builder: (context, controller, child) {
        return Scaffold(
          appBar: CommonWidgets.appBar(
              context: context, title: StringConstants.sendAwards),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.px, vertical: 20.px),
              child: Column(
                children: [
                  TextField(
                    onTap: () => controller.clickOnSearchBar(context: context),
                    readOnly: false,
                    controller: controller.searchController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Theme.of(context)
                          .colorScheme
                          .onPrimary
                          .withOpacity(.2),
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
                  SizedBox(height: 30.px),
                  ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () =>
                            controller.clickOnListTile(context: context),
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 8.px),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.px),
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
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
                                  CommonWidgets.appIcons(
                                    assetName: IconConstants.icUserLogoPng,
                                    width: 50.px,
                                    height: 50.px,
                                  ),
                                  SizedBox(width: 20.px),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
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
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 40.px,
                                    width: 80.px,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.px),
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                                    child: Center(
                                      child: Text(
                                        'View',
                                        maxLines: 2,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium
                                            ?.copyWith(
                                                fontSize: 12.px,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
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



