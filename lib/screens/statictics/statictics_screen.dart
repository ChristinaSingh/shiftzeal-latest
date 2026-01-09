import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/common_methods.dart';
import 'package:shiftzeal/common/common_widgets.dart';
import 'package:shiftzeal/constants/icons_constant.dart';

import '../../common/navigation_methos.dart';
import '../summarize/summarize_screen.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {'icon': Icons.shopping_cart, 'title': 'Groceries'},
      {'icon': Icons.today, 'title': 'Today'},
      {'icon': Icons.directions_bus, 'title': 'Travel'},
      {'icon': Icons.sports_tennis, 'title': 'Tennis Stuff'},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: CommonMethods.appIcons(
                        assetName: IconConstants.icBack,
                        height: 30.px,
                        width: 30.px),
                  ),
                  const SizedBox(width: 16),
                  const Text("Statistics",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularPercentIndicator(
                    radius: 48.0,
                    lineWidth: 10.0,
                    percent: 0.58,
                    animation: true,
                    animationDuration: 800,
                    center: const Text("58%",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    progressColor: Theme.of(context).colorScheme.secondary,
                    backgroundColor: Colors.orange.shade100,
                    circularStrokeCap: CircularStrokeCap.round,
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Overall Progress",
                          style: TextStyle(
                              fontSize: 16.px, fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text("21 checked items",
                          style:
                              TextStyle(color: Colors.grey, fontSize: 14.px)),
                      Text("10 unchecked items",
                          style:
                              TextStyle(color: Colors.grey, fontSize: 14.px)),
                      SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text("Please provide more details on",
                            style: TextStyle(
                                color: Colors.white, fontSize: 10.px)),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.separated(
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Icon(items[index]['icon'] as IconData,
                              color: Theme.of(context).primaryColor),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(items[index]['title'] as String,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 4),
                                Text(
                                    "Make it happen  7 checked out of 10 items",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 14.px)),
                              ],
                            ),
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              CircularPercentIndicator(
                                radius: 28.0,
                                lineWidth: 6.0,
                                percent: 0.85,
                                animation: true,
                                animationDuration: 800,
                                progressColor:
                                    Theme.of(context).colorScheme.secondary,
                                backgroundColor: Colors.orange.shade100,
                                circularStrokeCap: CircularStrokeCap.round,
                                center: const Text("85%",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold)),
                              ),
                              if (index == 1)
                                Positioned(
                                  top: 5,
                                  right: -3,
                                  child: CircleAvatar(
                                    radius: 8,
                                    backgroundColor:
                                        Theme.of(context).colorScheme.secondary,
                                    child: Icon(Icons.check,
                                        size: 12, color: Colors.white),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  onPressed: () {
                    NavigationMethods.pushMethod(
                        context: context, widget: SummarizeScreen());
                  },
                  child: Text("Submit New Report",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).scaffoldBackgroundColor)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
