import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/progress_bar.dart';
import 'package:shiftzeal/constants/string_constants.dart';

import '../../common/common_methods.dart';
import '../../common/common_widgets.dart';
import '../../constants/icons_constant.dart';
import 'shift_details_controller.dart';

class ShiftDetailsScreen extends StatefulWidget {
  const ShiftDetailsScreen({super.key, required this.shiftId});
  final String shiftId;

  @override
  State<ShiftDetailsScreen> createState() => _ShiftDetailsScreenState();
}

class _ShiftDetailsScreenState extends State<ShiftDetailsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var myShiftController =
      Provider.of<ShiftDetailsController>(context, listen: false);
      myShiftController.initMethod(context, widget.shiftId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ShiftDetailsController>(
      builder: (context, controller, child) {
        return Scaffold(
          appBar: CommonWidgets.appBar(
            context: context,
            title: StringConstants.shiftDetails,
          ),
          body: ProgressBar(
            inAsyncCall: controller.inAsyncCall,
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  GestureDetector(
                    onTap: () => controller.clickOnTaskList(context: context),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color:
                                Theme.of(context).scaffoldBackgroundColor,
                                shape: BoxShape.circle,
                              ),
                              child: CommonWidgets.appIcons(
                                assetName:
                                IconConstants.icProfileSiftDetails,
                                height: 40.px,
                                width: 40.px,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Text(
                                'Task List',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 16,
                              color: Colors.black38,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          _infoRow(
                            icon: IconConstants.icShiftDetailsCalendar,
                            title: controller.shiftDetailsById?.shiftDate ?? "",
                            trailing:
                            '${controller.shiftDetailsById?.startTime ?? ''} – ${controller.shiftDetailsById?.endTime ?? ''}',
                            trailingIcon: IconConstants.icClockBlackUnfill,
                          ),
                          const SizedBox(height: 12),
                          _infoRow(
                            icon: IconConstants.icLocationJobSite,
                            title: controller.shiftDetailsById?.address ?? "",
                            trailing: controller.shiftDetailsById?.userDetails?.position ?? "",
                            trailingIcon: IconConstants.icPosition,
                          ),
                          const SizedBox(height: 12),
                          _infoRow(
                            icon: IconConstants.icShiftDetailsProfile,
                            title:
                            '${controller.shiftDetailsById?.userDetails?.firstName ?? ''} ${controller.shiftDetailsById?.userDetails?.lastName ?? ''}',
                            trailing: '',
                            trailingIcon: IconConstants.icShiftDetailsCalendar,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Spacer(),

                  GestureDetector(
                    onTap: () => controller.clickOnReportAbsenceButton(context: context),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(20.px),
                            width: double.infinity,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Color(0xff1E3A8A),
                              borderRadius: BorderRadius.all(Radius.circular(16.px)),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "Report Absence",
                                  style: TextStyle(
                                    fontSize: 14.px,
                                    fontWeight: FontWeight.w700,
                                    color: Theme.of(context).scaffoldBackgroundColor,
                                  ),
                                ),
                                Spacer(),
                                CommonMethods.appIcons(
                                  assetName: IconConstants.icDocs,
                                  height: 20.px,
                                  width: 20.px,
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),

                          Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 60.px,
                                  child: OutlinedButton.icon(
                                    iconAlignment: IconAlignment.end,
                                    onPressed: () => controller.clickOnDailyReportButton(context: context),
                                    icon: Icon(
                                      Icons.bar_chart,
                                      color: Color(0xFF059669),
                                      size: 24.px,
                                    ),
                                    label: Text(
                                      'Daily Report',
                                      style: TextStyle(
                                        fontSize: 13.px,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF019874),
                                      ),
                                    ),
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(
                                        color: Color(0xFF019874),
                                        width: 2.px,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: SizedBox(
                                  height: 60.px,
                                  child: OutlinedButton.icon(
                                    iconAlignment: IconAlignment.end,
                                    onPressed: () => controller.clickOnShiftSwapButton(context: context),
                                    icon: Icon(
                                      Icons.swap_vert,
                                      color: Color(0xFF6D28D9),
                                      size: 24.px,
                                    ),
                                    label: Text(
                                      'Shift Swap',
                                      style: TextStyle(
                                        fontSize: 13.px,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF6D28D9),
                                      ),
                                    ),
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(
                                        color: Color(0xFF6D28D9),
                                        width: 2.px,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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

  Widget _infoRow({
    required String icon,
    required String title,
    String? trailing,
    required String trailingIcon,
  }) {
    return Row(
      children: [
        CommonMethods.appIcons(assetName: icon, height: 24.px, width: 24.px),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0XFF181D27),
            ),
          ),
        ),
        if (trailing != null && trailing.isNotEmpty) ...[
          Text(
            trailing,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0XFF181D27),
            ),
          ),
          const SizedBox(width: 6),
          CommonMethods.appIcons(
            assetName: trailingIcon,
            height: 24.px,
            width: 24.px,
          ),
        ],
      ],
    );
  }

  Widget requests({
    GestureTapCallback? onTap,
    required String title,
    String? assetName,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (assetName != null)
            CommonMethods.appIcons(assetName: assetName),
          SizedBox(width: 20.px),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium
                      ?.copyWith(fontSize: 12.px),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}