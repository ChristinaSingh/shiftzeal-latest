import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/common_methods.dart';
import 'package:shiftzeal/common/common_widgets.dart';
import 'package:shiftzeal/constants/icons_constant.dart';

import '../../common/navigation_methos.dart';
import '../../constants/string_constants.dart';
import 'publish_shifts_controller.dart';

class PublishShiftsScreen extends StatefulWidget {
  const PublishShiftsScreen({super.key});

  @override
  State<PublishShiftsScreen> createState() => _PublishShiftsScreenState();
}

class _PublishShiftsScreenState extends State<PublishShiftsScreen> {
  @override
  void initState() {
    super.initState();
    var publishShiftsController =
        Provider.of<PublishShiftsController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PublishShiftsController>(
      builder: (context, controller, child) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Padding(
            padding: EdgeInsets.all(24.px),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PublishToggle()
              ],
            ),
          ),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 0,
              automaticallyImplyLeading: false,
              flexibleSpace: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.px),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          NavigationMethods.popMethod(context: context);
                        },
                        child: CommonMethods.appIcons(
                          assetName: IconConstants.icBack,
                          height: 34.px,
                          width: 34.px,
                        ),
                      ),
                      Spacer(),
                      Text(
                        StringConstants.publishShifts,
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(fontSize: 20.px),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: (){
                          controller.clickOnAddShiftScreen(context: context);
                        },
                        child: CommonMethods.appIcons(
                          assetName: IconConstants.icAddSquare,
                          height: 34.px,
                          width: 34.px,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                CommonWidgets.lightBlueColorContainerText(
                    title: StringConstants.publishShiftsFor,color: Theme.of(context).colorScheme.secondary, context: context,fontSize: 14),
                SizedBox(
                  height: 24.px,
                ),



                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.px),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.px),
                      Text(
                        StringConstants.allUsers,
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(fontSize: 17.px),
                      ),
                      SizedBox(height: 20.px),
                      Row(
                        children: [
                          Expanded(
                              child: textField(
                                  hintText: 'User',
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      controller.clickOnAddUserButton(
                                          context: context);
                                    },
                                    child: CommonMethods.appIcons(
                                        assetName: IconConstants.icAddSquare),
                                  ))),
                          SizedBox(width: 20.px),
                          Expanded(
                            child: textField(
                                hintText: 'Position',
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    controller.clickOnAddPositionButton(
                                        context: context);
                                  },
                                  child: CommonMethods.appIcons(
                                      assetName: IconConstants.icAddSquare),
                                )),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.px),
                    ],
                  ),
                ),
                Container(
                  height:52.px,
                  padding: EdgeInsets.symmetric(horizontal: 20.px),
                  decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor),
                  child: Row(
                    children: [
                      Container(
                        height: 52.px,
                        width: 5.px,
                        color: Color(0XFF00897B),
                      ),
                      SizedBox(
                        width: 5.px,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Date',
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(fontSize: 13.px),
                          ),
                          Text(
                            'Sunday, August 25, 2024',
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(fontSize: 13.px),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.px,
                ),
                Container(
                  height:52.px,
                  padding: EdgeInsets.symmetric(horizontal: 20.px),
                  decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor),
                  child: Row(
                    children: [
                      Container(
                        height: 52.px,
                        width: 5.px,
                        color: Color(0XFF00897B),
                      ),
                      SizedBox(
                        width: 5.px,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'to Date',
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(fontSize: 13.px),
                          ),
                          Text(
                            'Sunday, August 25, 2024',
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(fontSize: 13.px),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
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
      readOnly: true,
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

class PublishToggle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PublishShiftsController>(context);
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Publish & Notify Button
          GestureDetector(
            onTap: () => provider.togglePublish(true),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              decoration: BoxDecoration(
                color: provider.isPublished ? Colors.white : Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                "Publish & Notify",
                style: TextStyle(
                  color: provider.isPublished ? Theme.of(context).primaryColor : Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Un-Publish Button
          GestureDetector(
            onTap: () => provider.togglePublish(false),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: provider.isPublished ? Theme.of(context).primaryColor : Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                "Un-Publish",
                style: TextStyle(
                  color: provider.isPublished ? Colors.white : Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


