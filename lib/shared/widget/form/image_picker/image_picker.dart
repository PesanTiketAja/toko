import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

const String _CLOUDINARY_CLOUD_NAME = "dotz74j1p";
const String _CLOUDINARY_API_KEY = "983354314759691";
const String _CLOUDINARY_UPLOAD_PRESET = "yogjjkoh";

class QImagePicker extends StatefulWidget {
  final String label;
  final String? value;
  final String? hint;
  final String? helper;
  final String? Function(String?)? validator;
  final Function(String) onChanged;
  final List<String> extensions;
  final bool enabled;

  QImagePicker({
    Key? key,
    required this.label,
    this.value,
    this.validator,
    this.hint,
    this.helper,
    required this.onChanged,
    this.extensions = const ["jpg", "png"],
    this.enabled = true,
  }) : super(key: key);

  @override
  State<QImagePicker> createState() => _QImagePickerState();
}

class _QImagePickerState extends State<QImagePicker> {
  String? imageUrl;
  bool loading = false;
  late TextEditingController controller;

  @override
  void initState() {
    imageUrl = widget.value;
    controller = TextEditingController(text: imageUrl ?? "");
    super.initState();
  }

  Future<String?> getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: widget.extensions,
      allowMultiple: false,
    );

    return result?.files.first.path;
  }

  Future<String?> getImage() async {
    XFile? image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 40,
    );

    return image?.path;
  }

  Future<String> uploadToCloudinary(String filePath) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(filePath, filename: "upload.jpg"),
      'upload_preset': _CLOUDINARY_UPLOAD_PRESET,
      'api_key': _CLOUDINARY_API_KEY,
    });

    var res = await Dio().post(
      'https://api.cloudinary.com/v1_1/$_CLOUDINARY_CLOUD_NAME/image/upload',
      data: formData,
    );

    return res.data["secure_url"];
  }

  Future<void> browseFile() async {
    if (loading) return;

    String? filePath;

    if (!kIsWeb && Platform.isWindows) {
      filePath = await getFile();
    } else {
      filePath = await getImage();
    }

    if (filePath == null) return;

    setState(() {
      loading = true;
    });

    try {
      imageUrl = await uploadToCloudinary(filePath);

      if (imageUrl != null) {
        widget.onChanged(imageUrl!);
        controller.text = imageUrl!;
      }
    } catch (e) {
      print("Error uploading image: $e");
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      margin: EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 96.0,
            width: 96.0,
            margin: EdgeInsets.only(
              top: 8.0,
            ),
            decoration: BoxDecoration(
              color: loading ? Colors.blueGrey[400] : null,
              image: loading
                  ? null
                  : DecorationImage(
                      image: NetworkImage(
                        imageUrl ?? "https://i.ibb.co/S32HNjD/no-image.jpg",
                      ),
                      fit: BoxFit.cover,
                    ),
              borderRadius: BorderRadius.all(
                Radius.circular(
                  16.0,
                ),
              ),
            ),
            child: Visibility(
              visible: loading == true,
              child: SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20.0,
                      height: 20.0,
                      child: CircularProgressIndicator(
                        color: Colors.orange,
                      ),
                    ),
                    SizedBox(
                      height: 6.0,
                    ),
                    Text(
                      "Uploading...",
                      style: TextStyle(
                        fontSize: 9.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: FormField<String>(
              initialValue: imageUrl,
              validator: (value) => widget.validator!(imageUrl),
              enabled: widget.enabled,
              builder: (FormFieldState<String> field) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: widget.label,
                          labelStyle: TextStyle(
                            color: Colors.blueGrey,
                          ),
                          helperText: widget.helper,
                          hintText: widget.hint,
                          errorText: field.errorText,
                        ),
                        onChanged: (value) {
                          widget.onChanged(value);
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 6.0,
                    ),
                    if (widget.enabled)
                      Container(
                        width: 50.0,
                        height: 46.0,
                        margin: const EdgeInsets.only(
                          right: 4.0,
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(0.0),
                            backgroundColor: Colors.grey[500],
                          ),
                          onPressed: () => browseFile(),
                          child: Icon(
                            Icons.file_upload,
                            size: 24.0,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
