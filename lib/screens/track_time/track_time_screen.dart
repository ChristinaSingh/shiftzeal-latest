import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/common_widgets.dart';
import 'package:shiftzeal/constants/icons_constant.dart';
import 'package:shiftzeal/constants/string_constants.dart';
import 'package:shiftzeal/screens/track_time/track_time_controller.dart';

import '../../common/common_methods.dart';

class TrackTimeScreen extends StatefulWidget {
  const TrackTimeScreen({super.key});

  @override
  State<TrackTimeScreen> createState() => TrackTimeScreenState();
}

class TrackTimeScreenState extends State<TrackTimeScreen> {
  @override
  void initState() {
    super.initState();
    var trackTimeController =
        Provider.of<TrackTimeController>(context, listen: false);
  }

  int selectedYear = DateTime.now().year;

  final List<Map<String, dynamic>> leaveData = [
    {'date': '21/05/2024', 'type': 'Annual Leave', 'value': 1.0},
    {'date': '22/05/2024', 'type': 'Annual Leave', 'value': 1.0},
    {'date': '23/05/2024', 'type': 'Annual Leave', 'value': 1.0},
    {'date': '24/05/2024', 'type': 'Annual Leave', 'value': 1.0},
    {'date': '25/05/2024', 'type': 'Annual Leave', 'value': 1.0},
    {'date': '26/05/2024', 'type': 'Annual Leave', 'value': 1.0},
    {'date': '27/05/2024', 'type': 'Annual Leave', 'value': 1.0},
    {'date': '28/05/2024', 'type': 'Annual Leave', 'value': 1.0},
    {'date': '29/05/2024', 'type': 'Annual Leave', 'value': 1.0},
    {'date': '30/05/2024', 'type': 'Annual Leave', 'value': 1.0},
    {'date': '21/05/2025', 'type': 'Annual Leave', 'value': 1.0},
    {'date': '22/05/2025', 'type': 'Annual Leave', 'value': 1.0},
    {'date': '23/05/2025', 'type': 'Annual Leave', 'value': 1.0},
    {'date': '24/05/2025', 'type': 'Annual Leave', 'value': 1.0},
    {'date': '25/05/2025', 'type': 'Annual Leave', 'value': 1.0},
    {'date': '26/05/2025', 'type': 'Annual Leave', 'value': 1.0},
    {'date': '27/05/2025', 'type': 'Annual Leave', 'value': 1.0},
    {'date': '28/05/2025', 'type': 'Annual Leave', 'value': 1.0},
    {'date': '29/05/2025', 'type': 'Annual Leave', 'value': 1.0},
    {'date': '30/05/2025', 'type': 'Annual Leave', 'value': 1.0},
  ];

  void changeYear(int offset) {
    setState(() {
      selectedYear += offset;
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredData = leaveData.where((entry) {
      final parts = entry['date'].split('/');
      if (parts.length == 3) {
        final year = int.tryParse(parts[2]);
        return year == selectedYear;
      }
      return false;
    }).toList();

    return Consumer<TrackTimeController>(
      builder: (context, controller, child) {
        print("filteredData : ${filteredData}");

        return Scaffold(
          appBar: CommonWidgets.appBar(
              context: context, title: StringConstants.trackTime),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.px),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: CommonMethods.appIcons(
                          assetName: IconConstants.icArrowLeftBlack,
                          height: 24.px,
                          width: 24.px),
                      onPressed: () => changeYear(-1),
                    ),
                    Spacer(),
                    Text('${selectedYear}',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Spacer(),
                    IconButton(
                      icon: CommonMethods.appIcons(
                          assetName: IconConstants.icArrowRightBlack,
                          height: 24.px,
                          width: 24.px),
                      onPressed: () => changeYear(1),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.px,
                ),
                Container(
                  height: 40.px,
                  padding: EdgeInsets.all(8.px),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30.px),
                          bottomRight: Radius.circular(30.px))),
                  child: Text(
                    'Holiday taken so far (01-jan-23 to 31-dec-23)',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 14.px),
                  ),
                ),
                SizedBox(
                  height: 20.px,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildLeaveStat(
                          context, '28.00 d', 'ALLOWANCE', Colors.red),
                      SizedBox(width: 50), // Spacing
                      _buildLeaveStat(context, '24.00 d', 'TAKEN',
                          Theme.of(context).primaryColor),
                      SizedBox(width: 50),
                      _buildLeaveStat(context, '4.00 d', 'REMAINING',
                          Theme.of(context).primaryColor),
                    ],
                  ),
                ),
                const Divider(thickness: 1),
                Expanded(
                  // height: 300,
                  child: filteredData.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: filteredData.length,
                          itemBuilder: (context, index) {
                            final item = filteredData[index];
                            return InkWell(
                              onTap: ()=> controller.clickOnTile(context: context, index: index,index2: index),
                              child: ListTile(
                                leading: Text(
                                  item['date'],
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.px,
                                      fontWeight: FontWeight.w600),
                                ),
                                title: Text(
                                  item['type'],
                                  style: TextStyle(color: Colors.black),
                                ),
                                // subtitle: Text(item['type'],style: TextStyle(color: Colors.black),),
                                trailing: Text(
                                  item['value'].toStringAsFixed(2),
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            );
                          },
                        )
                      : Center(),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLeaveStat(
      BuildContext context, String value, String label, Color color) {
    return Column(
     // mainAxisSize: MainAxisSize.min,
      children: [
        Text(value,
            style: TextStyle(
                color: color, fontSize: 14.px, fontWeight: FontWeight.w700)),
        Text(label,
            style: TextStyle(
                color: Colors.black,
                fontSize: 12.px,
                fontWeight: FontWeight.w700)),
        SizedBox(height: 8.px),
        Container(
          height: 3.px,
          width: label.length * 10, // dynamically adjusts based on label length
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    );
  }

  Widget tableTitle({required String title}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .displayMedium
              ?.copyWith(fontSize: 16.px),
        ),
      ),
    );
  }

  Widget tableDataTitle({required String title, double? fontSize}) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.px),
        child: Text(
          textAlign: TextAlign.center,
          title,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
              fontSize: fontSize ?? 18.px, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }

  cardWidget({
    required String title,
    required String subTitle,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(10.px)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: 14.px, color: Theme.of(context).primaryColor),
            ),
            SizedBox(height: 6.px),
            Text(
              subTitle,
              maxLines: 1,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontSize: 12.px),
            ),
          ],
        ),
      ),
    );
  }
}
