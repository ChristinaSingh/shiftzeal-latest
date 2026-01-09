import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../apis/api_constants/api_key_constants.dart';
import '../../apis/api_methods/api_methods.dart';
import '../../apis/api_models/get_user_uploader_model.dart';
import '../../apis/api_models/upload_user_documents_model.dart';
import '../../common/common_widgets.dart';

class DocumentController extends ChangeNotifier {
  List<String> documentTypes = [
    "Aadhaar Card",
    "PAN Card",
    "Driving License",
    "Passport",
    "Other"
  ];

  bool inAsyncCall = false;
  List<Map<String, dynamic>> uploadedDocs = [];
  // Each item: { "type": String, "file": File, "expiry": String?, "isUploading": bool }

  List<DocumentData> userDocuments = []; // API documents

  /// Open bottomsheet to choose doc type
  void openDocumentSelectionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: documentTypes.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: const Icon(Icons.description, color: Colors.black),
              title: Text(documentTypes[index],
                  style: const TextStyle(color: Colors.black)),
              onTap: () {
                Navigator.pop(context);
                pickDocumentFile(documentTypes[index]);
              },
            );
          },
        );
      },
    );
  }

  /// Pick file and add to local list
  Future<void> pickDocumentFile(String docType) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["pdf", "jpg", "jpeg", "png"],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      uploadedDocs.add({
        "type": docType,
        "file": file,
        "expiry": null,
        "isUploading": false,
      });
      notifyListeners();
    }
  }

  /// Set expiry date for local document
  void setExpiry(int index, String expiry) {
    uploadedDocs[index]["expiry"] = expiry;
    notifyListeners();
  }

  /// Remove local document
  void removeDoc(int index) {
    uploadedDocs.removeAt(index);
    notifyListeners();
  }

  /// Upload API call for a local document
  Future<void> uploadDocument(int index, BuildContext context) async {
    var doc = uploadedDocs[index];
    File file = doc["file"];
    String type = doc["type"];
    String? expiry = doc["expiry"];

    // Show uploading
    uploadedDocs[index]["isUploading"] = true;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString(ApiKeyConstants.userId);

    UploadUserDocumentModel? userModel = await ApiMethods.uploadUserDocument(
      documentFile: file,
      documentKey: ApiKeyConstants.document,
      context: context,
      bodyParams: {
        ApiKeyConstants.name: type,
        ApiKeyConstants.userId: userId ?? "",
        "expiry_date": expiry ?? "",
      },
    );

    uploadedDocs[index]["isUploading"] = false;

    if (userModel != null && userModel.status != null && userModel.status != "0") {
      CommonWidgets.showMyToastMessage(
          userModel.message ?? "Document uploaded successfully!");

      // Remove uploaded doc from local list
      uploadedDocs.removeAt(index);
      notifyListeners();

      // Fetch latest API documents
      await fetchUploadedDocuments(context: context);
    } else {
      CommonWidgets.showMyToastMessage(
          userModel?.message ?? "Failed to upload document.");
      notifyListeners();
    }
  }

  /// Fetch documents from API
  Future<void> fetchUploadedDocuments({required BuildContext context}) async {
    inAsyncCall = true;
    notifyListeners();

    SharedPreferences sp = await SharedPreferences.getInstance();
    String userId = sp.getString(ApiKeyConstants.userId) ?? "0";

    final body = {
      ApiKeyConstants.userId: userId,
    };

    final response = await ApiMethods.getUserUploadedDocuments(
      context: context,
      bodyParams: body,
    );

    if (response == null) {
      CommonWidgets.showMyToastMessage("No response from server");
      inAsyncCall = false;
      notifyListeners();
      return;
    }

    if (response.success == true && response.data != null) {
      userDocuments = response.data!;
      notifyListeners();
    } else {
      CommonWidgets.showMyToastMessage(
          response.message ?? "Failed to fetch documents");
    }

    inAsyncCall = false;
    notifyListeners();
  }
}
