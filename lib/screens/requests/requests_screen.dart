import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/common_widgets.dart';

import '../../common/common_methods.dart';
import '../../common/navigation_methos.dart';
import '../../constants/icons_constant.dart';
import '../../constants/image_constants.dart';
import '../../constants/string_constants.dart';
import 'requests_controller.dart';

class RequestsScreen extends StatefulWidget {
  const RequestsScreen({super.key});

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  @override
  void initState() {
    super.initState();
    var directoryController =
        Provider.of<RequestsController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RequestsController>(
      builder: (context, controller, child) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: Text(
                StringConstants.requests,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(fontSize: 20.px),
              ),
              centerTitle: true,
              actions: [
                GestureDetector(
                    onTap: () => controller.clickOnAddIcon(context: context),
                    child: CommonMethods.appIcons(
                        assetName: IconConstants.icAddSquare)),
                SizedBox(width: 24.px)
              ],
              leading: GestureDetector(
                onTap: () {
                  NavigationMethods.popMethod(context: context);
                },
                child: CommonMethods.appIcons(
                  assetName: IconConstants.icBack,
                  height: 34.px,
                  width: 34.px,
                ),
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(44.px),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.px),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(25.px)),
                    child: TabBar(
                      indicatorColor: Theme.of(context).primaryColor,
                      automaticIndicatorColorAdjustment: false,
                      indicatorSize: TabBarIndicatorSize.tab,
                      // onTap: (value) =>
                      //     controller.clickOnTap(value: value, context: context),
                      labelStyle: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                              fontSize: 12.px,
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).primaryColor),
                      unselectedLabelStyle: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(
                              fontSize: 12.px,
                              color: Colors.black.withOpacity(0.9),
                              fontWeight: FontWeight.w500),
                      dividerColor: Theme.of(context).colorScheme.surface,
                      padding: EdgeInsets.zero,
                      labelPadding: EdgeInsets.zero,
                      tabs: const [
                        Tab(text: 'New Request'),
                        Tab(text: 'Past Request'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            body: const TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                RequestsViewScreen(),
                OrgChartScreen(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class RequestsViewScreen extends StatefulWidget {
  const RequestsViewScreen({super.key});

  @override
  State<RequestsViewScreen> createState() => _RequestsViewScreenState();
}

class _RequestsViewScreenState extends State<RequestsViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<RequestsController>(builder: (context, controller, child) {
      return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 40.px, right: 20.px),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                  onTap: () => controller.clickOnAddIcon(context: context),
                  child: CommonMethods.appIcons(
                      assetName: IconConstants.icAdd,
                      color: Theme.of(context).colorScheme.secondary,
                      height: 60.px,
                      width: 60.px)),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.px, vertical: 20.px),
            child: false
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        ImageConstants.imageEmpty,
                        height: 280.px,
                      ),
                      SizedBox(
                        height: 20.px,
                      ),
                      Text(
                        "There are no current time off requests",
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(fontSize: 16.px),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      SizedBox(
                        height: 160.px,
                        width: MediaQuery.sizeOf(context).width,
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.listOfDate.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  controller.selectedValue = index;
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.all(8.px),
                                child: Container(
                                  width: 160.px,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(20.px),
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      border: controller.selectedValue != index
                                          ? Border.all(
                                              width: 1.px,
                                              color: Colors.black
                                                  .withOpacity(0.05))
                                          : Border.all(
                                              width: 2.px,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.05),
                                          spreadRadius: 2,
                                          blurRadius:
                                              10, // Increased blur radius
                                          offset: Offset(0, 4),
                                        )
                                      ]),
                                  child: Padding(
                                    padding: EdgeInsets.all(10.px),
                                    child: Column(
                                      children: [
                                        Text(
                                          controller.listOfDate[index]['title'],
                                          maxLines: 2,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium
                                              ?.copyWith(fontSize: 12.px),
                                        ),
                                        SizedBox(height: 10.px),
                                        Container(
                                          width: 14,
                                          height: 6,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4.px),
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .error),
                                        ),
                                        SizedBox(height: 8.px),
                                        Text(
                                          controller.listOfDate[index]
                                              ['number'],
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium
                                              ?.copyWith(
                                                  fontSize: 16.px,
                                                  fontWeight: FontWeight.w700),
                                        ),
                                        SizedBox(height: 8.px),
                                        Text(
                                          controller.listOfDate[index]['des'],
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium
                                              ?.copyWith(fontSize: 12.px),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20.px,
                      ),
                      controller.selectedValue == 0 ?
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Upcoming",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.copyWith(
                                        fontSize: 17.px,
                                        fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "View all (4)",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.copyWith(
                                        fontSize: 14.px,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context).primaryColor),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.px),
                          ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 8,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  onTap: () => controller.clickOnNewRequestItem(
                                      context: context),
                                  child: Container(
                                    width: 300,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 10.px, vertical: 10.px),
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 6,
                                          offset: Offset(0, 3),
                                        )
                                      ],
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Left Text Section
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: const [
                                              Text(
                                                'Unpaid time off',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              SizedBox(height: 4),
                                              Text(
                                                '19 Oct 2024–21 Oct 2024',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              SizedBox(height: 4),
                                              Text(
                                                '2 days',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // Right Status Pill
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 6),
                                          decoration: BoxDecoration(
                                            color: index == 0
                                                ? Colors.green
                                                : Color(0XFFFF9500),
                                            borderRadius: BorderRadius.circular(24),
                                          ),
                                          child: const Text(
                                            'Approved',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ));
                            },
                          ),
                        ],
                      )
                      :
                      Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 8,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  onTap: () => controller.clickOnNewRequestItem(
                                      context: context),
                                  child: Container(
                                    width: MediaQuery.sizeOf(context).width,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 10.px, vertical: 15.px),
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 6,
                                          offset: Offset(0, 3),
                                        )
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        // Profile image
                                        CircleAvatar(
                                          backgroundImage: AssetImage(IconConstants.icUserLogoPng), // Replace with your image path
                                          radius: 24,
                                        ),
                                        const SizedBox(width: 12),
                                        // Info Column
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                               Text(
                                                'SWAP',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.px,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              const SizedBox(height: 6),
                                               Text(
                                                'Sat, Aug 17, 4:00p ~ 12:00a',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14.px
                                                ),
                                              ),
                                              const SizedBox(height: 6),
                                               Text(
                                                'Lula L. as DSP at Egypt 2',
                                                 style: TextStyle(
                                                   color: Color(0XFF999999),
                                                   fontWeight: FontWeight.w400,
                                                   fontSize: 12,
                                                 ),
                                              ),
                                              const SizedBox(height: 6),
                                              Row(
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 8,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius: BorderRadius.circular(20),
                                                    ),
                                                    child: const Text(
                                                      'CANCELED',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                   Flexible(
                                                     child: Text(
                                                      'by Lula L. on Aug 14',
                                                      style: TextStyle(
                                                        color: Color(0XFF999999),
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 10,
                                                      ),
                                                                                                       ),
                                                   ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Icon(
                                          Icons.arrow_forward_ios,
                                          size: 16,
                                          color: Colors.black,
                                        )
                                      ],
                                    ),
                                  ));
                            },
                          ),
                        ],
                      ),

                    ],
                  ),
          ),
        ),
      );
    });
  }
}

class OrgChartScreen extends StatefulWidget {
  const OrgChartScreen({super.key});

  @override
  State<OrgChartScreen> createState() => _OrgChartScreenState();
}

class _OrgChartScreenState extends State<OrgChartScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<RequestsController>(builder: (context, controller, child) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.px, vertical: 20.px),
            child:  Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () => controller.clickOnNewRequestItem(
                            context: context),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width,
                          margin: EdgeInsets.symmetric(
                              horizontal: 10.px, vertical: 15.px),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                offset: Offset(0, 3),
                              )
                            ],
                          ),
                          child: Row(
                            children: [
                              // Profile image
                              CircleAvatar(
                                backgroundImage: AssetImage(IconConstants.icUserLogoPng), // Replace with your image path
                                radius: 24,
                              ),
                              const SizedBox(width: 12),
                              // Info Column
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'SWAP',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.px,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      'Sat, Aug 17, 4:00p ~ 12:00a',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.px
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      'Lula L. as DSP at Egypt 2',
                                      style: TextStyle(
                                        color: Color(0XFF999999),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 5,
                                            horizontal: 8,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: const Text(
                                            'CANCELED',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Flexible(
                                          child: Text(
                                            'by Lula L. on Aug 14',
                                            style: TextStyle(
                                              color: Color(0XFF999999),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: Colors.black,
                              )
                            ],
                          ),
                        ));
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
