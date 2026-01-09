import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/common_methods.dart';
import 'package:shiftzeal/constants/icons_constant.dart';
import 'package:shiftzeal/constants/string_constants.dart';

import '../../common/common_widgets.dart';
import 'history_controller.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();
    var historyController =
        Provider.of<HistoryController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HistoryController>(
      builder: (context, controller, child) {
        return Scaffold(
          appBar: CommonWidgets.appBar(
              context: context,
              title: StringConstants.history,
              actions: [
                InkWell(
                  onTap: () {
                    controller.clickOnSummarizeTime(context: context);
                  },
                  child: CommonMethods.appIcons(
                      assetName: IconConstants.icCalenderRed,
                      height: 24.px,
                      width: 24.px),
                ),
                SizedBox(
                  width: 20.px,
                )
              ]),
          // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          // floatingActionButton: Column(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     GestureDetector(
          //         onTap: () => controller.clickOnAddIcon(context: context),
          //         child: CommonMethods.appIcons(
          //             assetName: IconConstants.icAdd,
          //             height: 60.px,
          //             width: 60.px)),
          //   ],
          // ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.px),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20.px),
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
                          assetName: IconConstants.icSearch,
                          color: Theme.of(context).colorScheme.secondary),
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
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.px,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                  SizedBox(height: 20.px),
                  ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 8.px),
                        child: GestureDetector(
                          onTap: () =>
                              controller.clickOnListItem(context: context),
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    '1/26/2024, 2:36:22 PM',
                                    maxLines: 2,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(fontSize: 12.px),
                                  ),
                                  SizedBox(height: 8.px),
                                  Text(
                                    'Taylor Swift Named Apple...',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium
                                        ?.copyWith(fontSize: 18.px),
                                  ),
                                  SizedBox(height: 10.px),
                                  Text(
                                    'Lorem ipsum dolor sit amet consectetur. Tortor orci lacus eu porttitor sed facilisi. Purus vitae nunc.',
                                    maxLines: 2,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(fontSize: 14.px),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20.px),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
