import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class QCameraPicker extends StatefulWidget {
  final String label;
  final String? value;
  final String? hint;
  final String? helper;
  final String? Function(String?)? validator;
  final bool obscure;
  final Function(String) onChanged;
  final String? provider;

  QCameraPicker({
    Key? key,
    required this.label,
    this.value,
    this.validator,
    this.hint,
    this.helper,
    required this.onChanged,
    this.obscure = false,
    this.provider = "cloudinary",
  }) : super(key: key);

  @override
  State<QCameraPicker> createState() => _QCameraPickerState();
}

class _QCameraPickerState extends State<QCameraPicker> {
  String? imageUrl;
  bool loading = false;
  late TextEditingController controller;

  @override
  void initState() {
    imageUrl = widget.value;
    controller = TextEditingController(text: widget.value ?? "-");
    super.initState();
  }

  Future<String?> getFileMultiplePlatform() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["png", "jpg"],
      allowMultiple: false,
    );
    if (result == null) return null;
    return result.files.first.path;
  }

  Future<String?> getFileAndroidIosAndWeb() async {
    XFile? image = await ImagePicker().pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
      imageQuality: 40,
    );
    String? filePath = image?.path;
    if (filePath == null) return null;

    final File file = File(filePath);
    final bytes = await file.readAsBytes();
    return base64Encode(bytes);
  }

  Future<String?> uploadFile(String filePath) async {
    return widget.provider == "cloudinary"
        ? await uploadToCloudinary(filePath)
        : await uploadToImgBB(filePath);
  }

  Future<String> uploadToImgBB(String filePath) async {
    final formData = FormData.fromMap({
      'image': MultipartFile.fromBytes(
        File(filePath).readAsBytesSync(),
        filename: "upload.jpg",
      ),
    });

    var res = await Dio().post(
      'https://api.imgbb.com/1/upload?key=b55ef3fd02b80ab180f284e479acd7c4',
      data: formData,
    );

    var data = res.data["data"];
    var url = data["url"];
    widget.onChanged(url);
    return url;
  }

  Future<String> uploadToCloudinary(String filePath) async {
    String cloudName = "dotz74j1p";
    String apiKey = "983354314759691";

    final formData = FormData.fromMap({
      'file': MultipartFile.fromBytes(
        File(filePath).readAsBytesSync(),
        filename: "upload.jpg",
      ),
      'upload_preset': 'yogjjkoh',
      'api_key': apiKey,
    });

    var res = await Dio().post(
      'https://api.cloudinary.com/v1_1/$cloudName/image/upload',
      data: formData,
    );

    String url = res.data["secure_url"];
    return url;
  }

  browsePhoto() async {
    if (loading) return;

    String? base64Image;
    loading = true;
    setState(() {});

    if (!kIsWeb && Platform.isWindows) {
      base64Image = await getFileMultiplePlatform();
    } else {
      base64Image = await getFileAndroidIosAndWeb();
    }
    if (base64Image == null) return;

    imageUrl = "$base64Image";
    loading = false;

    if (imageUrl != null) {
      widget.onChanged(imageUrl!);
      controller.text = imageUrl!;
    }
    setState(() {});
  }

  String? get currentValue {
    return imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    var image = _getImageProvider();

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
            margin: EdgeInsets.only(top: 8.0),
            decoration: BoxDecoration(
              color: loading ? Colors.blueGrey[900] : null,
              image: loading
                  ? null
                  : DecorationImage(
                      image: image,
                      fit: BoxFit.cover,
                    ),
              borderRadius: BorderRadius.all(
                Radius.circular(16.0),
              ),
            ),
            child: _getLoadingIndicator(),
          ),
          SizedBox(width: 20.0),
          Expanded(
            child: TextFormField(
              controller: controller,
              obscureText: widget.obscure,
              readOnly: true,
              decoration: _getInputDecoration(),
              onChanged: (value) {
                widget.onChanged(value);
              },
            ),
          ),
        ],
      ),
    );
  }

  ImageProvider _getImageProvider() {
    if (imageUrl != null && imageUrl!.startsWith("http")) {
      return NetworkImage(imageUrl ?? "https://i.ibb.co/S32HNjD/no-image.jpg");
    } else if (imageUrl == null) {
      return NetworkImage("https://i.ibb.co/S32HNjD/no-image.jpg");
    } else {
      return MemoryImage(base64Decode(imageUrl!));
    }
  }

  Widget? _getLoadingIndicator() {
    if (loading) {
      return Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.6),
            ),
          ),
          Center(
            child: CircularProgressIndicator(),
          ),
        ],
      );
    }
    return null;
  }

  InputDecoration _getInputDecoration() {
    return InputDecoration(
      labelText: widget.label,
      labelStyle: TextStyle(
        color: Colors.blueGrey,
      ),
      suffixIcon: Transform.scale(
        scale: 0.8,
        child: SizedBox(
          width: 80.0,
          child: ElevatedButton(
            style: Theme.of(context).elevatedButtonTheme.style,
            onPressed: () => browsePhoto(),
            child: Text(
              "Browse",
              style: TextStyle(fontSize: 12.0),
            ),
          ),
        ),
      ),
      helperText: widget.helper,
      hintText: widget.hint,
    );
  }
}
