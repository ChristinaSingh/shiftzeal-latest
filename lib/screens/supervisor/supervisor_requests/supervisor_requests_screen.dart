import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../common/common_widgets.dart';
import '../../../common/progress_bar.dart';
import 'supervisor_requests_controller.dart';

class SupervisorRequestsScreen extends StatelessWidget {
  const SupervisorRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;

    return ChangeNotifierProvider(
      create: (_) => SupervisorRequestsController(),
      child: Consumer<SupervisorRequestsController>(
        builder: (context, controller, child) {
          return Scaffold(
            backgroundColor: const Color(0xFFF5F6FA),
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.5,
              title: Text("Requests",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.px,
                      fontWeight: FontWeight.bold)),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: ProgressBar(
              inAsyncCall: controller.inAsyncCall,
              child: Column(
                children: [
                  // --- Matches Shift Reports Filter Style ---
                  _buildFilterSection(controller, primary),

                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.all(16.px),
                      itemCount: controller.requests.length,
                      itemBuilder: (context, index) => _buildRequestCard(
                          context, controller, controller.requests[index], primary),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFilterSection(SupervisorRequestsController controller, Color primary) {
    return Container(
      height: 60.px,
      width: double.infinity,
      color: Colors.white,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.px, vertical: 10.px),
        itemCount: controller.filters.length,
        itemBuilder: (context, index) {
          final filter = controller.filters[index];
          bool isSelected = controller.selectedFilter == filter;
          return Padding(
            padding: EdgeInsets.only(right: 10.px),
            child: ChoiceChip(
              label: Text(filter),
              selected: isSelected,
              onSelected: (val) => controller.setFilter(filter),
              selectedColor: primary,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontSize: 13.px,
              ),
              backgroundColor: Colors.grey.shade100,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.px)),
              // Removing default shadow/border for cleaner look
              side: BorderSide(
                color: isSelected ? primary : Colors.transparent,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRequestCard(BuildContext context, SupervisorRequestsController controller, Map<String, dynamic> request, Color primary) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.px),
      padding: EdgeInsets.all(16.px),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.px),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CommonWidgets.imageView(
                image: "https://ui-avatars.com/api/?name=${request['name']}&background=random",
                height: 45.px,
                width: 45.px,
                borderRadius: BorderRadius.circular(25.px),
              ),
              SizedBox(width: 12.px),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(request['name'],
                        style: TextStyle(fontSize: 16.px, fontWeight: FontWeight.bold)),
                    SizedBox(height: 2.px),
                    Text(request['date'],
                        style: TextStyle(fontSize: 13.px, color: Colors.grey)),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.px, vertical: 4.px),
                decoration: BoxDecoration(
                    color: primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.px)),
                child: Text(request['type'],
                    style: TextStyle(
                        color: primary,
                        fontSize: 11.px,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          Divider(height: 24.px),
          Row(
            children: [
              Icon(Icons.access_time, size: 16.px, color: Colors.grey),
              SizedBox(width: 6.px),
              Text(request['shift'],
                  style: TextStyle(fontSize: 13.px, color: Colors.black87)),
            ],
          ),
          SizedBox(height: 12.px),
          Text("Reason",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.px,
                  color: Colors.black54)),
          SizedBox(height: 4.px),
          Text(request['reason'],
              style: TextStyle(color: Colors.black87, fontSize: 13.px, height: 1.4)),
          SizedBox(height: 20.px),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => controller.handleAction(
                      requestId: request['id'], isApprove: false, context: context),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.px)),
                    padding: EdgeInsets.symmetric(vertical: 12.px),
                  ),
                  child: const Text("Reject", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(width: 12.px),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => controller.handleAction(
                      requestId: request['id'], isApprove: true, context: context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.px)),
                    padding: EdgeInsets.symmetric(vertical: 12.px),
                    elevation: 0,
                  ),
                  child: const Text("Approve",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}