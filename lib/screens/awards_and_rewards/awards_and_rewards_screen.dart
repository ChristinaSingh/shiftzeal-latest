import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/constants/image_constants.dart';
import 'package:shiftzeal/constants/string_constants.dart';

import '../../common/common_widgets.dart';
import 'awards_and_rewards_controller.dart';

class AwardsAndRewardsScreen extends StatefulWidget {
  const AwardsAndRewardsScreen({super.key});

  @override
  State<AwardsAndRewardsScreen> createState() => _AwardsAndRewardsScreenState();
}

class _AwardsAndRewardsScreenState extends State<AwardsAndRewardsScreen> {
  @override
  void initState() {
    super.initState();
    var awardsAndRewardsController =
        Provider.of<AwardsAndRewardsController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AwardsAndRewardsController>(
      builder: (context, controller, child) {
        return Scaffold(
          appBar: CommonWidgets.appBar(
            context: context,
            title: StringConstants.awardsAndRewards,
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20.px),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(24.px),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () =>
                            controller.clickOnSendAwards(context: context),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.px),
                              border: Border.all(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8.px),
                              child: Text(
                                StringConstants.sendAwards,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Image.asset(
                        ImageConstants.imageCongratulations,
                        height: 70.px,
                        width: 70.px,
                      ),
                      SizedBox(height: 10.px),
                      Text(
                        'Congratulations\nArchana Gautam!',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 10.px),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '28.00d',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(fontWeight: FontWeight.w700),
                                ),
                                SizedBox(height: 4.px),
                                Text(
                                  'Smiles Collected',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(fontSize: 12.px),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '28.00d',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(fontWeight: FontWeight.w700),
                                ),
                                SizedBox(height: 4.px),
                                Text(
                                  'Recognition Received',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(fontSize: 12.px),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '28.00d',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(fontWeight: FontWeight.w700),
                                ),
                                SizedBox(height: 4.px),
                                Text(
                                  'Recognition Awarded',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(fontSize: 12.px),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.px),
                    ],
                  ),
                ),
                Container(
                  height: 30.px,
                  width: MediaQuery.sizeOf(context).width,
                  alignment: AlignmentDirectional.centerStart,
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.px, vertical: 5.px),
                  color: Color(0XFFE0E6FF),
                  child: Text(
                    'Your Rewards - 4',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontSize: 14.px, fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(height: 20.px),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            ImageConstants.imageTheSolutionMakerAward,
                            height: 34.px,
                            width: 34.px,
                          ),
                          SizedBox(height: 20.px),
                          Text(
                            'The Solution Maker Award',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(fontSize: 12.px),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            ImageConstants.imageHeartOfLionAward,
                            height: 34.px,
                            width: 34.px,
                          ),
                          SizedBox(height: 20.px),
                          Text(
                            'Heart of Lion Award',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(fontSize: 12.px),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            ImageConstants.imageWellDone,
                            height: 34.px,
                            width: 34.px,
                          ),
                          SizedBox(height: 20.px),
                          Text(
                            'Well Done',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(fontSize: 12.px),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.px),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 30.px,
                      width: MediaQuery.sizeOf(context).width - 60,
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          )),
                      alignment: AlignmentDirectional.centerStart,
                      padding: EdgeInsets.symmetric(
                          horizontal: 24.px, vertical: 5.px),
                      child: Text(
                        StringConstants.latestActivity,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                                fontSize: 14.px,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.px),
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {},
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(24.px),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        '7 Aug 2019',
                                        maxLines: 2,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium
                                            ?.copyWith(fontSize: 10.px),
                                      ),
                                      SizedBox(height: 6.px),
                                      Text(
                                        'Well Done given to Archana Gautam by Nikhil Mishra',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium
                                            ?.copyWith(fontSize: 12.px),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 20.px),
                                Image.asset(
                                  ImageConstants.imageWellDone,
                                  height: 50.px,
                                  width: 50.px,
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Theme.of(context).colorScheme.surface,
                            thickness: .2,
                          )
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(height: 20.px),
              ],
            ),
          ),
        );
      },
    );
  }
}
