import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shiftzeal/screens/pdf_viewer/pdf_viewer_screen.dart';
import '../../common/common_widgets.dart';
import '../../constants/string_constants.dart';
import 'document_controller.dart';

class DocumentScreen extends StatefulWidget {
  const DocumentScreen({super.key});

  @override
  State<DocumentScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DocumentController>(context, listen: false)
          .fetchUploadedDocuments(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DocumentController>(
      builder: (context, controller, child) {
        final combinedDocs = [
          ...controller.uploadedDocs.map((doc) => {
                "type": doc["type"],
                "file": doc["file"],
                "isLocal": true,
                "isUploading": doc["isUploading"] ?? false,
              }),
          ...controller.userDocuments.map((doc) => {
                "type": doc.name ?? "Unknown",
                "url": doc.document ?? "",
                "isLocal": false,
              }),
        ];

        return Scaffold(
          appBar: CommonWidgets.appBar(
              context: context, title: StringConstants.documents),
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color(0xffE60001),
            shape: const CircleBorder(),
            onPressed: () {
              controller.openDocumentSelectionSheet(context);
            },
            child: const Icon(Icons.file_copy_outlined,
                color: Colors.white, size: 20),
          ),
          body: combinedDocs.isEmpty
              ? const Center(
                  child: Text(
                  "No documents uploaded yet",
                  style: TextStyle(color: Colors.grey),
                ))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: combinedDocs.length,
                  itemBuilder: (context, index) {
                    var doc = combinedDocs[index];
                    if (doc["isLocal"]) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: LocalDocumentCard(
                          docType: doc["type"],
                          file: doc["file"],
                          onSubmit: () {
                            controller.uploadDocument(index, context);
                          },
                          onRemove: () {
                            controller.removeDoc(index);
                          },
                          isUploading: doc["isUploading"],
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: ApiDocumentCard(
                          docType: doc["type"],
                          documentUrl: doc["url"],
                        ),
                      );
                    }
                  },
                ),
        );
      },
    );
  }
}

// ------------------- Local Document Card -------------------
class LocalDocumentCard extends StatelessWidget {
  final String docType;
  final File file;
  final VoidCallback onSubmit;
  final VoidCallback onRemove;
  final bool isUploading;

  const LocalDocumentCard({
    super.key,
    required this.docType,
    required this.file,
    required this.onSubmit,
    required this.onRemove,
    this.isUploading = false,
  });

  @override
  Widget build(BuildContext context) {
    bool isPdf = file.path.endsWith(".pdf");

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: isPdf ? const Color(0xffE60001) : Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: isPdf
                ? const Icon(Icons.picture_as_pdf,
                    color: Colors.white, size: 40)
                : ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(file, fit: BoxFit.cover),
                  ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(docType,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                if (isUploading)
                  const AnimatedUploadingText()
                else
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: onSubmit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text("Upload"),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: onRemove,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text("Remove"),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ------------------- API Document Card -------------------
class ApiDocumentCard extends StatelessWidget {
  final String docType;
  final String documentUrl;

  const ApiDocumentCard({
    super.key,
    required this.docType,
    required this.documentUrl,
  });

  @override
  Widget build(BuildContext context) {
    bool isPdf = documentUrl.endsWith(".pdf");

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: isPdf ? const Color(0xffE60001) : Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: isPdf
                ? GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => PdfViewerScreen(),));
              },
                  child: const Icon(Icons.picture_as_pdf,
                      color: Colors.white, size: 40),
                )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CommonWidgets.imageView(image: documentUrl),
                  ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(docType,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

class AnimatedUploadingText extends StatefulWidget {
  const AnimatedUploadingText({super.key});

  @override
  State<AnimatedUploadingText> createState() => _AnimatedUploadingTextState();
}

class _AnimatedUploadingTextState extends State<AnimatedUploadingText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  int dotCount = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500))
      ..addListener(() {
        setState(() {
          dotCount = (_controller.value * 3).ceil();
        });
      })
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String dots = "." * dotCount;
    return Text(
      "Uploading$dots",
      style: const TextStyle(
          color: Colors.grey, fontWeight: FontWeight.normal, fontSize: 14),
    );
  }
}
