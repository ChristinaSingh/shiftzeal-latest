import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/common_methods.dart';

import '../../common/common_widgets.dart';
import '../../constants/icons_constant.dart';

class ChangePlanScreen extends StatelessWidget {
  const ChangePlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              // Header with back arrow and title
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: CommonMethods.appIcons(
                          assetName: IconConstants.icBack,
                          height: 30.px,
                          width: 30.px),
                    ),
                    Spacer(),
                    const Text(
                      "Change Your Plan",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    SizedBox()
                  ],
                ),
              ),

              // Billing period
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Billing Period:",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // TabBar
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F2F2),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: TabBar(
                  labelColor: Colors.white,
                  unselectedLabelColor: Color(0xFF2D2D2D),
                  indicator: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(14)),
                  ),
                  labelStyle:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  tabs: [
                    Tab(text: '      Monthly       '),
                    Tab(text: '      Annually      '),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // TabBarView
              Expanded(
                child: TabBarView(
                  children: [
                    _PlanContent(),
                    // Monthly
                    _PlanContent2(),
                    // Annually (same data here, can be changed later)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PlanContent extends StatelessWidget {
  const _PlanContent();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Plan header
            Row(
              children: [
                const Expanded(
                  child: Text(
                    "Free",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text(
                    "SELECT PLAN",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              "\$0",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const Text(
              "(10 user limit)",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            Divider(
              height: 1,
              color: Colors.grey.withOpacity(0.5),
            ),
            const SizedBox(height: 10),
            const Text(
              "Time Tracking & Attendance not available",
              style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 16),
            const Text(
              "What you get in Free:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Features
            ...[
              "Up to 10 users",
              "Single location",
              "Free mobile app",
              "Schedule 7 days out",
              "Shift notifications and reminders",
              "Shift swapping",
              "OpenShifts",
              "Help Center"
            ].map((feature) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle, color: Colors.green),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          feature,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class _PlanContent2 extends StatelessWidget {
  const _PlanContent2();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Plan header
            Row(
              children: [
                const Expanded(
                  child: Text(
                    "Essentials",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text(
                    "SELECT PLAN",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              "\$3.00",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const Text(
              "user/month",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            Divider(
              height: 1,
              color: Colors.grey.withOpacity(0.5),
            ),
            const SizedBox(height: 10),
            const Text(
              "Time Tracking & Attendance not available",
              style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 16),
            const Text(
              "What you get in Free:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 24.px,
                    width: 40.px,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: CupertinoSwitch(
                        value: true,
                        activeColor: Theme.of(context).colorScheme.secondary,
                        onChanged: (bool value) {},
                      ),
                    ),
                  ),
                  SizedBox(width: 12.px,),
                  Text(
                    "Time Tracking & Attendance",
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontSize: 14.px,
                        fontWeight: FontWeight.w700,
                        color: Color(0XFF181D27)),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            // Features
            ...[
              "Unlimited users",
              "Auto Scheduling",
              "Multi-week scheduling",
              "Multi-location scheduling",
              "Capacity planning",
            ].map((feature) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle, color: Colors.green),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          feature,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
