import 'dart:developer';
import 'dart:io' show Platform;
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:path/path.dart' as path;
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:signature/signature.dart';

class HomeController extends GetxController {
  Uint8List? signatureImage;
  File? exportedFile;

  double penStock = 1.5;
  Color bgColor = Colors.white;
  Color penColor = Colors.black;

  SignatureController controllerSignature = SignatureController(penStrokeWidth: 1.5,penColor: Colors.black,exportBackgroundColor: Colors.white);

  String signaturePath = "";

  Future<void> saveSignature() async {
    PermissionStatus request = await Permission.manageExternalStorage.request();
    if (request.isGranted) {
      try {
        signatureImage = await controllerSignature.toPngBytes(
          height: 270,
          width: int.parse("${(Get.width - 16).round()}"),
        );
        if (signatureImage != null) {
          if (Platform.isAndroid) {
            final customImagePath = Directory('/storage/emulated/0/Signatures/');
            bool isDirExist = await customImagePath.exists();
            if (!isDirExist) {
              customImagePath.createSync(recursive: true);
            }
            String timestamp = DateTime.now().toString().replaceAll(' ', '_').replaceAll(':', '_').replaceAll(".", "_");
            final imagePath = path.join(customImagePath.path, "Signatures_$timestamp.png");
            final File imageFile = File(imagePath);
            await imageFile.writeAsBytes(signatureImage!);
            signaturePath = imagePath;
            bool isFileCreated = await imageFile.exists();
            if (isFileCreated) {
              Get.snackbar("Success", "Signature Saved", backgroundColor: Colors.green);
            }
            log('Image saved to: $imagePath');
          }
        } else {
          Get.snackbar("Alert", "Enter Signature", backgroundColor: Colors.red);
        }
      } catch (e) {
        log('Error saving image: $e');
      }
    } else {
      Get.snackbar("Alert", "Please give permission to save image ");
      await Permission.storage.request();
    }
  }

  void changeColor(Color color) {
    bgColor = color;
    controllerSignature = SignatureController(penColor: penColor, penStrokeWidth: penStock, points: controllerSignature.points, exportBackgroundColor: bgColor, exportPenColor: penColor);
  }

  void changePenColor(Color color) {
    penColor = color;
    controllerSignature = SignatureController(penColor: penColor, penStrokeWidth: penStock, points: controllerSignature.points, exportBackgroundColor: bgColor, exportPenColor: penColor);
  }

  bgColorPicker() {
    return Get.dialog(
      AlertDialog(
        title: const Text('Pick a Sign Background color!'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: bgColor,
            onColorChanged: changeColor,
          ),
          // Use Material color picker:
          //
          // child: MaterialPicker(
          //   pickerColor: pickerColor,
          //   onColorChanged: changeColor,
          //   showLabel: true, // only on portrait mode
          // ),
          //
          // Use Block color picker:
          //
          // child: BlockPicker(
          //   pickerColor: currentColor,
          //   onColorChanged: changeColor,
          // ),
          //
          // child: MultipleChoiceBlockPicker(
          //   pickerColors: currentColors,
          //   onColorsChanged: changeColors,
          // ),
        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('Got it'),
            onPressed: () {
              update(['Signature']);
              Get.back();
            },
          ),
        ],
      ),
    );
  }

  penColorPicker() {
    return Get.dialog(
      AlertDialog(
        title: const Text('Pick a Pen color!'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: penColor,
            onColorChanged: changePenColor,
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('Got it'),
            onPressed: () {
              update(['Signature']);
              Get.back();
            },
          ),
        ],
      ),
    );
  }

  @override
  void onInit() {
    super.onInit();
    controllerSignature = SignatureController(penStrokeWidth: penStock, penColor: penColor, exportBackgroundColor: bgColor);
    update(['Signature']);
  }

  void clearSign() {
    controllerSignature.clear();
    signatureImage = null;
  }
}
