import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/constants/string_constants.dart';

import '../../common/common_methods.dart';
import '../../common/common_widgets.dart';
import '../../constants/icons_constant.dart';
import 'open_shift_request_details_basic_controller.dart';

class OpenShiftRequestDetailsBasicScreen extends StatefulWidget {
  const OpenShiftRequestDetailsBasicScreen({super.key});

  @override
  State<OpenShiftRequestDetailsBasicScreen> createState() =>
      _OpenShiftRequestDetailsScreenState();
}

class _OpenShiftRequestDetailsScreenState
    extends State<OpenShiftRequestDetailsBasicScreen> {
  @override
  void initState() {
    super.initState();
    var openShiftRequestDetailsController =
    Provider.of<OpenShiftRequestDetailsBasicController>(context,
        listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OpenShiftRequestDetailsBasicController>(
      builder: (context, controller, child) {
        return Scaffold(
          appBar: CommonWidgets.appBar(
            context: context,
            title: StringConstants.openShiftRequestsDetail,
          ),

          /*bottomNavigationBar: Padding(
            padding: EdgeInsets.all(20.px),
            child: CommonWidgets.commonElevatedButton(
                context: context,
                onPressed: () =>
                    controller.clickOnRequestShiftButton(context: context),
                text: StringConstants.requestShift),
          ),*/
          body: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 80),

                  // Shift Info Card
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
                            title: 'Wed, Aug 28, 2024',
                            trailing: '8:00 AM  4:00 PM',
                            trailingIcon: IconConstants.icClockBlackUnfill,
                          ),
                          const SizedBox(height: 12),
                          _infoRow(
                            icon: IconConstants.icShiftDetailsCalendar,
                            title: 'Avalon 2',
                            trailing: 'DSP',
                            trailingIcon: IconConstants.icPosition,
                          ),
                          const SizedBox(height: 12),
                          _infoRow(
                            icon: IconConstants.icShiftDetailsProfile,
                            title: 'Ronaldo Trump',
                            trailing: '',
                            trailingIcon: IconConstants.icShiftDetailsCalendar,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Buttons Section
                ],

                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 24.px),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //       SizedBox(height: 20.px),
                //       ListTile(
                //         contentPadding: EdgeInsets.zero,
                //         onTap: () => controller.clickOnTaskList(context: context),
                //         title: Text(
                //           'Task List',
                //           style: Theme.of(context)
                //               .textTheme
                //               .displayMedium
                //               ?.copyWith(fontSize: 12.px),
                //         ),
                //         leading: CommonMethods.appIcons(
                //           assetName: IconConstants.icClock,
                //           height: 34.px,
                //           width: 34.px,
                //         ),
                //         trailing: CommonMethods.appIcons(
                //           assetName: IconConstants.icNextArrow,
                //           width: 18.px,
                //           height: 10.px,
                //         ),
                //       ),
                //       SizedBox(height: 20.px),
                //       requests(
                //         onTap: () {},
                //         assetName: IconConstants.icCalendar,
                //         title: 'Wed, Aug 28, 2024',
                //       ),
                //       SizedBox(height: 20.px),
                //       requests(
                //         onTap: () {},
                //         assetName: IconConstants.icTime,
                //         title: '8:00 AM 4:00 PM',
                //       ),
                //       SizedBox(height: 20.px),
                //       requests(
                //         onTap: () {},
                //         assetName: IconConstants.icCalendar,
                //         title: 'Avalon 2',
                //       ),
                //       SizedBox(height: 20.px),
                //       requests(
                //         onTap: () {},
                //         assetName: IconConstants.icPosition,
                //         title: 'DSP',
                //       ),
                //       SizedBox(height: 20.px),
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         crossAxisAlignment: CrossAxisAlignment.center,
                //         children: [
                //           Container(
                //             decoration: BoxDecoration(
                //               color: Theme.of(context).primaryColor,
                //               borderRadius: BorderRadius.circular(75.px),
                //             ),
                //             child: CommonWidgets.imageView(
                //               width: 34.px,
                //               height: 34.px,
                //               borderRadius: BorderRadius.circular(17.px),
                //               image:
                //               'https://cdn.pixabay.com/photo/2024/04/12/15/46/beautiful-8692180_1280.png',
                //             ),
                //           ),
                //           SizedBox(width: 20.px),
                //           Expanded(
                //             child: Column(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Text(
                //                   'Ronaldo Trump',
                //                   style: Theme.of(context)
                //                       .textTheme
                //                       .displayMedium
                //                       ?.copyWith(fontSize: 12.px),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ],
                //       ),
                //       SizedBox(height: 60.px),
                //       CommonWidgets.commonElevatedButton(
                //           context: context,
                //           onPressed: () => controller.clickOnReportAbsenceButton(
                //               context: context),
                //           text: StringConstants.reportAbsence),
                //       SizedBox(height: 20.px),
                //       CommonWidgets.commonElevatedButton(
                //           context: context,
                //           onPressed: () =>
                //               controller.clickOnDailyReportButton(context: context),
                //           text: StringConstants.dailyReport),
                //       SizedBox(height: 20.px),
                //       CommonWidgets.commonElevatedButton(
                //           context: context,
                //           onPressed: () =>
                //               controller.clickOnShiftSwapButton(context: context),
                //           text: StringConstants.shiftSwap),
                //       SizedBox(height: 20.px),
                //     ],
                //   ),
                // ),
              )),
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
                color: Color(0XFF181D27)),
          ),
        ),
        if (trailing != null && trailing.isNotEmpty) ...[
          Text(
            trailing,
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0XFF181D27)),
          ),
          if (trailingIcon != null) ...[
            const SizedBox(width: 6),
            CommonMethods.appIcons(
                assetName: trailingIcon, height: 24.px, width: 24.px),
          ],
        ]
      ],
    );
  }

  Widget requests(
      {GestureTapCallback? onTap, required String title, String? assetName}) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (assetName != null)
            CommonMethods.appIcons(
              assetName: assetName,
            ),
          SizedBox(width: 20.px),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme
                      .of(context)
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
