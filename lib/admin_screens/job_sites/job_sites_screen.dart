import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/common_methods.dart';
import 'package:shiftzeal/common/common_widgets.dart';
import 'package:shiftzeal/constants/icons_constant.dart';
import 'package:shiftzeal/constants/string_constants.dart';

import 'job_sites_controller.dart';

class JobSitesScreen extends StatefulWidget {
  const JobSitesScreen({super.key});

  @override
  State<JobSitesScreen> createState() => JobSitesScreenState();
}

class JobSitesScreenState extends State<JobSitesScreen> {
  @override
  void initState() {
    super.initState();
    var jobSitesController =
        Provider.of<JobSitesController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<JobSitesController>(
      builder: (context, controller, child) {
        return Scaffold(
          appBar: CommonWidgets.appBar(
              context: context,
              title: StringConstants.jobSites,
              actions: [
                GestureDetector(onTap: () => controller.clickOnAdd(context: context),child: CommonMethods.appIcons(assetName: IconConstants.icAddSquare)),
                SizedBox(
                  width: 24.px,
                )
              ]),
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
                    context: context,
                    borderRadius: 15,
                    onPressed: () =>
                        controller.clickOnSaveButton(context: context),
                    text: StringConstants.add),
              ],
            ),
          ),
          body: RolesGridApp(),
        );
      },
    );
  }
}


class RolesGridApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RolesGridScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RolesGridScreen extends StatelessWidget {
  final List<String> roles = [
    "Dsp",
    "Supervisor",
    "Manager",
    "Director",
    "CEO",
    "General Manager",
    "Front Desk",
    "RN",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: roles.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 3 cards in a row
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1, // makes square cards
          ),
          itemBuilder: (context, index) {
            return RoleCard(title: roles[index]);
          },
        ),
      ),
    );
  }
}

class RoleCard extends StatelessWidget {
  final String title;

  RoleCard({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          SizedBox(height: 12),
          CommonMethods.appIcons(
              assetName: IconConstants.icBackForDashboard,
              height: 24.px,
              width: 24.px),
        ],
      ),
    );
  }
}

