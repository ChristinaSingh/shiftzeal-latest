import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common/common_widgets.dart';
import '../../constants/string_constants.dart';

class AccountSetupScreen extends StatefulWidget {
  const AccountSetupScreen({super.key});

  @override
  State<AccountSetupScreen> createState() => _AccountSetupScreenState();
}

class _AccountSetupScreenState extends State<AccountSetupScreen> {
  final List<String> options = [
    "Save time building the schedule",
    "Track employee hours and availability easier",
    "Get better shift coverage",
    "Communicate with the team more easily",
    "Manage PTO and time-off requests",
    "Streamline payroll",
    "Manage labor costs with improved",
  ];

  final Set<int> selectedIndexes = {0}; // Initially selecting first

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(24.px),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CommonWidgets.commonElevatedButton(
                context: context,
                borderRadius: 15.px,
                height: 60.px,
                onPressed: () {

                },
                text: "Continue"),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.px),
          child: Column(
            children: [
              const SizedBox(height: 24),
              const Text(
                "Account Setup",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              const Text(
                "What do you want When I Work to help you with?",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  "Get personalized how-to guides to help you make the most of your account based on your goals. Select as many as you like.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Colors.grey,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: options.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 14),
                  itemBuilder: (context, index) {
                    final selected = selectedIndexes.contains(index);
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (selected) {
                            selectedIndexes.remove(index);
                          } else {
                            selectedIndexes.add(index);
                          }
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                        decoration: BoxDecoration(
                          color: selected ?  Theme.of(context).colorScheme.secondary : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            )
                          ],
                          border: Border.all(
                            color: selected ? Theme.of(context).colorScheme.secondary : Colors.grey.shade200,
                            width: 1.2,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.arrow_circle_right_outlined,
                              color: selected ? Colors.white : Theme.of(context).colorScheme.secondary,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                options[index],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: selected ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
