import 'dart:io';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shiftzeal/common/common_widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:file_picker/file_picker.dart';
import '../../apis/api_constants/api_key_constants.dart';
import '../../apis/api_methods/api_methods.dart';
import '../../apis/api_models/add_annoucement_model.dart';
import '../../apis/api_models/get_announcements_model.dart';
import '../../common/alert_dialog_view.dart';
import '../../common/image_pick_and_crop.dart';
import '../../common/navigation_methos.dart';
import '../../constants/string_constants.dart';

class AdminAnnouncementController extends ChangeNotifier {
  bool inAsyncCall = false;
  List<AnnouncementData> announcementList = [];
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  File? attachedFile;
  String? attachedFileName;

  int _selectedTabIndex = 0;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  int get selectedTabIndex => _selectedTabIndex;
  DateTime get focusedDay => _focusedDay;
  DateTime? get selectedDay => _selectedDay;

  Future<void> getUserAnnouncements({required BuildContext context}) async {
    inAsyncCall = true;
    notifyListeners();
    SharedPreferences sp = await SharedPreferences.getInstance();
    String userId = sp.getString(ApiKeyConstants.userId) ?? "0";
    try {
      final bodyParam = {
        ApiKeyConstants.userId: userId,
      };

      GetAnnouncementModel? announcementModel =
          await ApiMethods.getAnnouncementApi(
        context: context,
        bodyParams: bodyParam,
      );

      if (announcementModel != null &&
          announcementModel.status != null &&
          announcementModel.status != "0") {
        announcementList = announcementModel.data ?? [];
        print("hello announcementList: $announcementList");
      } else {
        // Handle no data or failure
      }
    } catch (e) {
      // Handle error
    } finally {
      inAsyncCall = false;
      notifyListeners();
    }
  }

  // Existing openPdf... (Implementation remains the same)
  void openPdf(String url) async {
    final Uri pdfUrl = Uri.parse(url);
    if (await canLaunchUrl(pdfUrl)) {
      await launchUrl(pdfUrl, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  // --- FILE SELECTION LOGIC (Implementation remains the same) ---
  void removeAttachedFile() {
    attachedFile = null;
    attachedFileName = null;
    notifyListeners();
  }

  Future<void> pickFile({required BuildContext context}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'], // Allow images and PDF
    );

    if (result != null && result.files.single.path != null) {
      attachedFile = File(result.files.single.path!);
      attachedFileName = result.files.single.name;
    }
    notifyListeners();
  }

  Future<void> pickCamera({required BuildContext context}) async {
    File? pickedImage = await ImagePickerAndCropper.pickImage(
      context: context,
      wantCropper: true,
      color: Theme.of(context).scaffoldBackgroundColor,
    );
    if (pickedImage != null) {
      attachedFile = pickedImage;
      attachedFileName = pickedImage.path.split('/').last;
    }
    notifyListeners();
  }

  Future<void> pickGallery({required BuildContext context}) async {
    File? pickedImage = await ImagePickerAndCropper.pickImage(
        context: context,
        wantCropper: true,
        color: Theme.of(context).scaffoldBackgroundColor,
        pickImageFromGallery: true);
    if (pickedImage != null) {
      attachedFile = pickedImage;
      attachedFileName = pickedImage.path.split('/').last;
    }
    notifyListeners();
  }

  void showAlertDialog({required BuildContext context}) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return MyAlertDialog(
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: cameraTextButtonView(context: context),
              onPressed: () => clickCameraTextButtonView(context: context),
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              child: galleryTextButtonView(context: context),
              onPressed: () => clickGalleryTextButtonView(context: context),
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              child: fileTextButtonView(context: context),
              onPressed: () {
                NavigationMethods.popMethod(context: context);
                pickFile(context: context);
              },
            ),
          ],
          title: selectImageTextView(context: context),
          content: contentTextView(context: context),
        );
      },
    );
  }

  Widget fileTextButtonView({required BuildContext context}) => Text(
        'Select Document/PDF',
        style: Theme.of(context)
            .textTheme
            .titleSmall
            ?.copyWith(fontSize: 14.px, color: Theme.of(context).primaryColor),
      );

  Widget selectImageTextView({required BuildContext context}) => Text(
        'Select Media/File',
        style: Theme.of(context)
            .textTheme
            .displayMedium
            ?.copyWith(fontSize: 18.px),
      );

  Widget contentTextView({required BuildContext context}) => Text(
        'Choose an image or a document from the options below.',
        style:
            Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 14.px),
      );

  Widget cameraTextButtonView({required BuildContext context}) => Text(
        StringConstants.camera,
        style: Theme.of(context)
            .textTheme
            .titleSmall
            ?.copyWith(fontSize: 14.px, color: Theme.of(context).primaryColor),
      );

  Widget galleryTextButtonView({required BuildContext context}) => Text(
        StringConstants.gallery,
        style: Theme.of(context)
            .textTheme
            .titleSmall
            ?.copyWith(fontSize: 14.px, color: Theme.of(context).primaryColor),
      );

  Future<void> clickCameraTextButtonView(
      {required BuildContext context}) async {
    pickCamera(context: context);
    NavigationMethods.popMethod(context: context);
  }

  Future<void> clickGalleryTextButtonView(
      {required BuildContext context}) async {
    pickGallery(context: context);
    NavigationMethods.popMethod(context: context);
  }
// ... (rest of the AdminAnnouncementController class) ...

  // --- CORRECTED ANNOUNCEMENT SUBMISSION LOGIC ---

  // 1. Public function called from the UI (e.g., a Submit button)
  Future<void> submitAnnouncement(BuildContext context) async {
    // Basic Validation
    if (titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Announcement Title is required.')),
      );
      return;
    }
    if (descriptionController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Announcement Description is required.')),
      );
      return;
    }

    // Call the internal API function and await its result
    bool success = await _callAddAnnouncementApi(context);

    // 3. Clear fields and close sheet ONLY on successful submission
    if (success) {
      titleController.clear();
      descriptionController.clear();
      removeAttachedFile();
      // Use Navigator.pop to close the modal/bottom sheet the form is in
      Navigator.pop(context);
    }
  }

  // 2. Private function to handle the actual API call (Renamed to be private)
  Future<bool> _callAddAnnouncementApi(BuildContext context) async {
    inAsyncCall = true;
    notifyListeners(); // Start loading indicator
    bool isSuccess = false;

    SharedPreferences sp = await SharedPreferences.getInstance();
    String userId = sp.getString(ApiKeyConstants.userId) ?? "0";

    if (userId == "0") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error: User not logged in.')),
      );
      inAsyncCall = false;
      notifyListeners();
      return false;
    }

    try {
      final bodyParam = {
        ApiKeyConstants.userId: userId,
        ApiKeyConstants.title: titleController.text.trim(),
        ApiKeyConstants.content: descriptionController.text.trim(),
      };

      AddAnnouncementModel? announcementModel =
          await ApiMethods.addAnnouncementApi(
        image: attachedFile,
        imageKey: ApiKeyConstants.image,
        context: context,
        bodyParams: bodyParam,
      );

      // Handle Response
      if (announcementModel?.status == "1") {
        isSuccess = true;
        CommonWidgets.showMyToastMessage("Announcement created successfully.");
        // Refresh the announcement list only on success
        await getUserAnnouncements(context: context);
      } else {
        // FAILURE MESSAGE: Status not 1
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(announcementModel?.message ??
                  'Failed to create announcement.')),
        );
      }
    } catch (e) {
      // Network or other unexpected error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text("An error occurred: ${e.toString()}. Please try again.")),
      );
    } finally {
      inAsyncCall = false;
      notifyListeners(); // Stop loading indicator
    }
    return isSuccess;
  }
}
