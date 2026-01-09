import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/common_widgets.dart';
import 'package:shiftzeal/constants/string_constants.dart';
import 'package:shiftzeal/screens/performance/performance_controller.dart';

class PerformanceScreen extends StatefulWidget {
  const PerformanceScreen({super.key});

  @override
  State<PerformanceScreen> createState() => PerformanceScreenState();
}

class PerformanceScreenState extends State<PerformanceScreen>
    with TickerProviderStateMixin {
  late AnimationController ratingController;
  late Animation<double> ratingAnimation;

  double percent = 4.94 / 5;

  @override
  void initState() {
    super.initState();
    var performanceController =
        Provider.of<PerformanceController>(context, listen: false);
    ratingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    ratingAnimation = Tween<double>(begin: 0, end: 4.94).animate(
      CurvedAnimation(parent: ratingController, curve: Curves.easeOut),
    );
    ratingController.forward();
  }

  @override
  void dispose() {
    ratingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PerformanceController>(
      builder: (context, controller, child) {
        return Scaffold(
          appBar: CommonWidgets.appBar(
              context: context, title: StringConstants.performance),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Center(
                      child: CircularPercentIndicator(
                        radius: 120,
                        lineWidth: 20,
                        animation: true,
                        percent: percent,
                        circularStrokeCap: CircularStrokeCap.round,
                        backgroundColor: Colors.pink.shade100,
                        progressColor: Colors.red.shade700,
                        center: AnimatedBuilder(
                          animation: ratingController,
                          builder: (context, child) => Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Excellent",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 16)),
                              Text(
                                ratingAnimation.value.toStringAsFixed(2),
                                style: const TextStyle(
                                    fontSize: 32, fontWeight: FontWeight.bold),
                              ),
                              const Text("Shop & deliver",
                                  style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    const Center(
                      child: Text(
                        "Member feedback",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Center(
                      child: Text(
                        "Of your last 50 rated orders, 25 members have left you feedback. "
                        "You've received 34 compliments and 8 growth opportunities.",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey, fontSize: 14.px),
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      height: 100,
                      child: PieChart(
                        PieChartData(
                          sectionsSpace: 3,
                          centerSpaceRadius: 30,
                          sections: [
                            PieChartSectionData(
                                showTitle: false,
                                value: 34,
                                color: Colors.blue,
                                radius: 30),
                            PieChartSectionData(
                                showTitle: false,
                                value: 8,
                                color: Colors.red,
                                radius: 30),
                            PieChartSectionData(
                                showTitle: false,
                                value: 25,
                                color: Colors.orange,
                                radius: 30),
                            PieChartSectionData(
                                showTitle: false,
                                value: 5,
                                color: Colors.green,
                                radius: 30),
                            PieChartSectionData(
                                showTitle: false,
                                value: 4,
                                color: Colors.purple,
                                radius: 30),
                            PieChartSectionData(
                                showTitle: false,
                                value: 3,
                                color: Colors.indigo,
                                radius: 30),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _feedbackBox(
                            "34", "Compliments", Colors.yellow.shade700),
                        _feedbackBox(
                            "08", "Growth\nopportunities", Colors.cyan),
                        _feedbackBox("25", "No feedback", Colors.orange),
                      ],
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget _feedbackBox(String count, String label, Color color) {
  return Container(
    width: 100,
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(18),
    ),
    child: Column(
      children: [
        Text(
          count,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
        ),
      ],
    ),
  );
}
