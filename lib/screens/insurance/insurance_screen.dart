import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/progress_bar.dart';
import '../../common/colors.dart';
import '../../common/common_methods.dart';
import '../../common/navigation_methos.dart';
import '../../constants/icons_constant.dart';
import 'insurance_controller.dart';

class InsuranceScreen extends StatefulWidget {
  const InsuranceScreen({super.key});

  @override
  State<InsuranceScreen> createState() => InsuranceScreenState();
}

class InsuranceScreenState extends State<InsuranceScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      var insuranceController =
      Provider.of<InsuranceController>(context, listen: false);

      /// Call both APIs (Medical + Other)
      insuranceController.fetchAllInsurance(context);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<InsuranceController>(
      builder: (context, controller, child) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              /*title: Text(
                StringConstants.setting,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(fontSize: 20.px),
              ),
              centerTitle: true,
              actions: [
                Text(
                  StringConstants.edit,
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontSize: 14.px,
                      color: Theme.of(context).colorScheme.secondary),
                ),
                SizedBox(width: 24.px)
              ],*/
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
                              color: Theme.of(context).primaryColor),
                      unselectedLabelStyle: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(
                              fontSize: 12.px, fontWeight: FontWeight.w700),
                      dividerColor: Theme.of(context).colorScheme.surface,
                      padding: EdgeInsets.zero,
                      labelPadding: EdgeInsets.zero,
                      tabs: const [
                        Tab(text: 'Medical'),

                        Tab(text: 'Other'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            body: ProgressBar(
              inAsyncCall: controller.inAsyncCall,
              child: const TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  MedicalScreen(),
                  OtherScreen()
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class MedicalScreen extends StatefulWidget {
  const MedicalScreen({super.key});

  @override
  State<MedicalScreen> createState() => MedicalScreenState();
}

class MedicalScreenState extends State<MedicalScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<InsuranceController>(builder: (context, controller, child) {
      final insurance = controller.medicalInsuranceList.isNotEmpty
          ? controller.medicalInsuranceList.first
          : null;

      return Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.px, vertical: 20.px),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                insurance?.memberName ?? 'N/A',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: 20.px,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 20.px),

              /// Row 1: Member Name + Group Name
              Row(
                children: [
                  Expanded(
                    child: _buildInfoTile(
                      context,
                      title: "MEMBER NAME",
                      value: insurance?.memberName ?? 'N/A',
                      alignEnd: false,
                    ),
                  ),
                  Expanded(
                    child: _buildInfoTile(
                      context,
                      title: "GROUP NAME",
                      value: insurance?.groupName ?? 'N/A',
                      alignEnd: true,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25.px),

              /// Row 2: Group Id + Effective Date
              Row(
                children: [
                  Expanded(
                    child: _buildInfoTile(
                      context,
                      title: "GROUP ID",
                      value: insurance?.groupId ?? 'N/A',
                      alignEnd: false,
                    ),
                  ),
                  Expanded(
                    child: _buildInfoTile(
                      context,
                      title: "EFFECTIVE DATE",
                      value: insurance?.effectiveDate ?? 'N/A',
                      alignEnd: true,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25.px),

              /// Row 3: Plan + RX BIN/PCN
              Row(
                children: [
                  Expanded(
                    child: _buildInfoTile(
                      context,
                      title: "PLAN",
                      value: insurance?.plan ?? 'N/A',
                      alignEnd: false,
                    ),
                  ),
                  Expanded(
                    child: _buildInfoTile(
                      context,
                      title: "RX BIN/PCN",
                      value: insurance?.rxBinPcn ?? 'N/A',
                      alignEnd: true,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25.px),

              /// Row 4: Dependents + Type
              Row(
                children: [
                  Expanded(
                    child: _buildInfoTile(
                      context,
                      title: "DEPENDENTS",
                      value: insurance?.dependents ?? 'N/A',
                      alignEnd: false,
                    ),
                  ),
                  Expanded(
                    child: _buildInfoTile(
                      context,
                      title: "TYPE",
                      value: insurance?.type ?? 'N/A',
                      alignEnd: true,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  /// Reusable info tile widget
  Widget _buildInfoTile(BuildContext context,
      {required String title, required String value, bool alignEnd = false}) {
    return Container(
      height: 52.px,
      padding: EdgeInsets.symmetric(horizontal: 10.px),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Row(
        mainAxisAlignment:
        alignEnd ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment:
        alignEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          if (!alignEnd)
            Container(height: 52.px, width: 5.px, color: Color(0XFF00897B)),
          SizedBox(width: 10.px),
          Column(
            mainAxisAlignment:
            alignEnd ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment:
            alignEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontSize: 14.px,
                    fontWeight: FontWeight.w600,
                    color: AppLightColors().secondary2),
              ),
              Text(
                value,
                maxLines: 2,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontSize: 12.px,
                  color: Color(0XFF424242),
                ),
              ),
            ],
          ),
          SizedBox(width: 10.px),
          if (alignEnd)
            Container(height: 52.px, width: 5.px, color: Color(0XFF00897B)),
        ],
      ),
    );
  }

}



class OtherScreen extends StatefulWidget {
  const OtherScreen({super.key});

  @override
  State<OtherScreen> createState() => _OtherScreenState();
}

class _OtherScreenState extends State<OtherScreen> {
  @override

  Widget build(BuildContext context) {
    return Consumer<InsuranceController>(builder: (context, controller, child) {
      final insurance = controller.otherInsuranceList.isNotEmpty
          ? controller.otherInsuranceList.first
          : null;

      return Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.px, vertical: 20.px),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                insurance?.memberName ?? 'N/A',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: 20.px,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 20.px),

              /// Row 1: Member Name + Group Name
              Row(
                children: [
                  Expanded(
                    child: _buildInfoTile(
                      context,
                      title: "MEMBER NAME",
                      value: insurance?.memberName ?? 'N/A',
                      alignEnd: false,
                    ),
                  ),
                  Expanded(
                    child: _buildInfoTile(
                      context,
                      title: "GROUP NAME",
                      value: insurance?.groupName ?? 'N/A',
                      alignEnd: true,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25.px),

              /// Row 2: Group Id + Effective Date
              Row(
                children: [
                  Expanded(
                    child: _buildInfoTile(
                      context,
                      title: "GROUP ID",
                      value: insurance?.groupId ?? 'N/A',
                      alignEnd: false,
                    ),
                  ),
                  Expanded(
                    child: _buildInfoTile(
                      context,
                      title: "EFFECTIVE DATE",
                      value: insurance?.effectiveDate ?? 'N/A',
                      alignEnd: true,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25.px),

              /// Row 3: Plan + RX BIN/PCN
              Row(
                children: [
                  Expanded(
                    child: _buildInfoTile(
                      context,
                      title: "PLAN",
                      value: insurance?.plan ?? 'N/A',
                      alignEnd: false,
                    ),
                  ),
                  Expanded(
                    child: _buildInfoTile(
                      context,
                      title: "RX BIN/PCN",
                      value: insurance?.rxBinPcn ?? 'N/A',
                      alignEnd: true,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25.px),

              /// Row 4: Dependents + Type
              Row(
                children: [
                  Expanded(
                    child: _buildInfoTile(
                      context,
                      title: "DEPENDENTS",
                      value: insurance?.dependents ?? 'N/A',
                      alignEnd: false,
                    ),
                  ),
                  Expanded(
                    child: _buildInfoTile(
                      context,
                      title: "TYPE",
                      value: insurance?.type ?? 'N/A',
                      alignEnd: true,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
  Widget _buildInfoTile(BuildContext context,
      {required String title, required String value, bool alignEnd = false}) {
    return Container(
      height: 52.px,
      padding: EdgeInsets.symmetric(horizontal: 10.px),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Row(
        mainAxisAlignment:
        alignEnd ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment:
        alignEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          if (!alignEnd)
            Container(height: 52.px, width: 5.px, color: Color(0XFF00897B)),
          SizedBox(width: 10.px),
          Column(
            mainAxisAlignment:
            alignEnd ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment:
            alignEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontSize: 14.px,
                    fontWeight: FontWeight.w600,
                    color: AppLightColors().secondary2),
              ),
              Text(
                value,
                maxLines: 2,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontSize: 12.px,
                  color: Color(0XFF424242),
                ),
              ),
            ],
          ),
          SizedBox(width: 10.px),
          if (alignEnd)
            Container(height: 52.px, width: 5.px, color: Color(0XFF00897B)),
        ],
      ),
    );
  }
}
