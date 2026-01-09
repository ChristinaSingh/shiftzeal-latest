import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/common_methods.dart';
import 'package:shiftzeal/common/common_widgets.dart';
import 'package:shiftzeal/constants/icons_constant.dart';
import 'package:shiftzeal/constants/image_constants.dart';

import '../../common/navigation_methos.dart';
import '../plans/change_plan_screen.dart';

class FreeTrialScreen extends StatelessWidget {
  const FreeTrialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Back Arrow and Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: CommonMethods.appIcons(
                        assetName: IconConstants.icBack,
                        height: 30.px,
                        width: 30.px),
                  ),
                  const Spacer(),
                  const Text(
                    "Free Trial",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(width: 28), // To balance the arrow space
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Trial Info
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "You have 14 days left on your free trial!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                "Keep your schedule—find out how in the Help Center",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Illustration
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Image.asset(
                ImageConstants.imageFreeTrial, // Update path if needed
                fit: BoxFit.contain,
              ),
            ),

            const Spacer(),

            // Upgrade Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  minimumSize: const Size(double.infinity, 55),
                ),
                onPressed: () {
                  NavigationMethods.pushMethod(
                      context: context, widget: ChangePlanScreen());
                },
                child: const Text(
                  "Upgrade Today",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
