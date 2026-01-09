import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/progress_bar.dart';
// Import necessary utility files (assuming they exist in your project structure)
import '../../common/common_widgets.dart';
import '../../constants/string_constants.dart';
import 'announcements_admin_controller.dart';

// NOTE: I am assuming your controller and common classes are set up correctly.

class AdminAnnouncementScreen extends StatefulWidget {
  const AdminAnnouncementScreen({super.key});
  @override
  State<AdminAnnouncementScreen> createState() =>
      AdminAnnouncementScreenState();
}

class AdminAnnouncementScreenState extends State<AdminAnnouncementScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var adminController =
          Provider.of<AdminAnnouncementController>(context, listen: false);
      adminController.getUserAnnouncements(context: context);
    });
  }

  // --- NEW FUNCTION TO SHOW BOTTOM SHEET ---
  void _showAddAnnouncementSheet(BuildContext context) {
    final controller =
        Provider.of<AdminAnnouncementController>(context, listen: false);
    controller.titleController.clear();
    controller.descriptionController.clear();
    controller.removeAttachedFile();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: const _AddAnnouncementBottomSheet(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminAnnouncementController>(
      builder: (context, controller, child) {
        return ProgressBar(
          inAsyncCall: controller.inAsyncCall,
          child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            floatingActionButton: Padding(
              padding: EdgeInsets.only(bottom: 75.px),
              child: FloatingActionButton(
                onPressed: () {
                  _showAddAnnouncementSheet(context);
                },
                backgroundColor: const Color(0xFFE60001),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.px),
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
            appBar: AppBar(
              surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: Text(
                StringConstants.announcement,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(fontSize: 20.px),
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 120.px),
                child: controller.announcementList.isEmpty
                    ? Center(
                        child: Text(
                        "No announcements available",
                        style: TextStyle(color: Colors.grey.withOpacity(0.5)),
                      ))
                    : ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.announcementList.length,
                        itemBuilder: (context, index) {
                          final announcement =
                              controller.announcementList[index];
                          final admin = announcement.adminDetails;
                          final isPdf = (announcement.image ?? "")
                              .toLowerCase()
                              .endsWith(".pdf");
                          final hasMedia =
                              (announcement.image ?? "").isNotEmpty;

                          return Padding(
                            padding: EdgeInsets.only(
                                bottom: 15.px, left: 15.px, right: 15.px),
                            child: Container(
                              // 1. Enhanced Container Styling (Card-like appearance)
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12.px),
                                  border: Border.all(
                                      width: 1.px,
                                      color: Colors.grey.withOpacity(0.5))),
                              child: Padding(
                                padding: EdgeInsets.all(16.px),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // --- 1. ADMIN HEADER (Avatar and Timestamp) ---
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        // Admin Avatar
                                        CommonWidgets.imageView(
                                          image: admin?.image ?? "",
                                          borderRadius:
                                              BorderRadius.circular(24.px),
                                          height: 48.px,
                                          width: 48.px,
                                        ),
                                        SizedBox(width: 15.px),
                                        // Admin Name & Title
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${admin?.firstName ?? ""} ${admin?.lastName ?? ""}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium
                                                    ?.copyWith(
                                                        fontSize: 15.px,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Colors.black),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              SizedBox(height: 2.px),
                                              Text(
                                                'Administrator', // Assuming role based on AdminController
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                      fontSize: 11.px,
                                                      color: const Color(
                                                          0XFF999999),
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // Timestamp
                                        Text(
                                          announcement.createdAt != null
                                              ? DateFormat('MMM d, h:mm a')
                                                  .format(
                                                  DateTime.parse(
                                                      announcement.createdAt!),
                                                )
                                              : '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                fontSize: 10.px,
                                                color: const Color(0XFF999999),
                                              ),
                                        ),
                                      ],
                                    ),

                                    SizedBox(height: 15.px),
                                    const Divider(
                                        height: 1,
                                        thickness: 0.5,
                                        color: Color(0xFFEEEEEE)),
                                    SizedBox(height: 15.px),

                                    // --- 2. TITLE ---
                                    Text(
                                      announcement.title ?? 'No Title',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.copyWith(
                                            fontSize: 18.px,
                                            fontWeight: FontWeight.bold,
                                            // Use a color that stands out
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                    ),

                                    SizedBox(height: 10.px),

                                    // --- 3. CONTENT (Description) ---
                                    Text(
                                      announcement.content ?? '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            fontSize: 14.px,
                                            color: const Color(0XFF555555),
                                            fontWeight: FontWeight.w400,
                                          ),
                                    ),

                                    // --- 4. MEDIA/FILE ATTACHMENT ---
                                    if (hasMedia) ...[
                                      SizedBox(height: 15.px),
                                      isPdf
                                          ? GestureDetector(
                                              onTap: () => controller
                                                  .openPdf(announcement.image!),
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10.px,
                                                    horizontal: 15.px),
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary
                                                      .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.px),
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    // Replace Image.asset with an icon for better styling
                                                    Icon(Icons.picture_as_pdf,
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        size: 24.px),
                                                    SizedBox(width: 10.px),
                                                    Text(
                                                      'View Attached Document (PDF)',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelLarge
                                                          ?.copyWith(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10.px),
                                              child: CommonWidgets.imageView(
                                                // Fixed height for better visual consistency
                                                height: 180.px,
                                                image: announcement.image!,
                                                fit: BoxFit
                                                    .cover, // Ensure image covers the space
                                                defaultNetworkImage:
                                                    "https://dummyimage.com/600x400/cccccc/000000&text=No+Image",
                                              ),
                                            ),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      )),
          ),
        );
      },
    );
  }
}

// --- NEW WIDGET FOR BOTTOM SHEET CONTENT ---

class _AddAnnouncementBottomSheet extends StatelessWidget {
  const _AddAnnouncementBottomSheet();

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminAnnouncementController>(
      builder: (context, controller, child) {
        return Container(
          padding: EdgeInsets.all(24.px),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.px),
              topRight: Radius.circular(25.px),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Create New Announcement',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontSize: 18.px,
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.px),
              // --- TITLE TEXT FIELD ---
              CommonWidgets.normalTextFieldForLoginSignUP(
                context: context,
                controller: controller.titleController,
                labelText: "Enter title",
                maxLines: 1,
                labelStyle: const TextStyle(color: Colors.black54),
              ),
              SizedBox(height: 20.px),

              // --- DESCRIPTION TEXT FIELD ---
              CommonWidgets.normalTextFieldForLoginSignUP(
                context: context,
                controller: controller.descriptionController,
                labelText: "Enter Description",
                maxLines: 6,
                labelStyle: const TextStyle(color: Colors.black54),
              ),
              SizedBox(height: 20.px),

              // --- ATTACH FILE BUTTON ---
              ElevatedButton.icon(
                onPressed: () {
                  controller.showAlertDialog(context: context);
                },
                icon: const Icon(Icons.attach_file),
                label: const Text('Attach File (Image/PDF/Document)'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15.px),
                ),
              ),
              SizedBox(height: 10.px),

              // --- DISPLAY SELECTED FILE NAME ---
              if (controller.attachedFile != null)
                Padding(
                  padding: EdgeInsets.only(bottom: 10.px),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'File Selected: ${controller.attachedFileName ?? 'Unknown File'}',
                          style: Theme.of(context).textTheme.labelMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      GestureDetector(
                        onTap: controller.removeAttachedFile,
                        child: const Icon(
                          Icons.close,
                          color: Colors.red,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              // ------------------------------------

              SizedBox(height: 5.px),
              CommonWidgets.commonCustumeButton(
                onPressed: () {
                  controller.submitAnnouncement(context);
                },
                borderRadius: 15.px,
                buttonColor: Theme.of(context).primaryColor,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.px),
                  child: Text(
                    "Submit Announcement",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                  ),
                ),
                showLoading: controller.inAsyncCall,
                context: context,
              ),
              SizedBox(height: 10.px),
            ],
          ),
        );
      },
    );
  }
}
