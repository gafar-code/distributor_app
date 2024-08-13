import 'dart:developer';
import 'dart:io';

import 'package:distributor_app/flutter_flow/nav/nav.dart';
import 'package:distributor_app/repositories/file_repository.dart';
import 'package:distributor_app/repositories/proof_repository.dart';
import 'package:distributor_app/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/location_service.dart';

final class AddEditProofController extends GetxController {
  final locaationService = LocationService();
  RxBool isLoading = false.obs;
  RxBool getLocationLoading = false.obs;
  final image = Rxn<File>();
  final descriptionC = TextEditingController();
  final repo = ProofRepository();
  final lat = Rxn<double>();
  final lng = Rxn<double>();
  final address = Rxn<String>();
  final imagePath = Rxn<String>();
  final fileRepo = UploadFileRepository();

  void addOrEditProof(BuildContext context,
      {required int taskId, required bool isEdit}) async {
    try {
      isLoading.value = true;
      if (isEdit) {
        final result = await repo.editProof(
          taskProofId: taskId,
          description: descriptionC.text,
        );
        result.when(error: (e) async {
          showCustomSnackbar(e.message);
        }, success: (s) async {
          context.pop();
          showCustomSnackbar(s.message);
        });
      } else {
        await uploadFile();
        if (imagePath.value == null || imagePath.value!.isEmpty) {
          showCustomSnackbar('Image upload failed');
          return;
        }
        log(imagePath.toString(), name: 'gambar path ada ga');
        final result = await repo.addProof(
            params: ProofParams(
                taskId: taskId,
                description: descriptionC.text,
                address: address.value,
                lat: lat.value,
                lng: lng.value,
                imagePath: imagePath.value));
        result.when(error: (e) async {
          showCustomSnackbar(e.message);
        }, success: (s) async {
          context.pop();
          showCustomSnackbar(s.message);
        });
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> takeImage() async {
    final XFile? pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      image.value = File(pickedImage.path);
      await getCurrentLocation();
    }
  }

  Future<void> getCurrentLocation() async {
    try {
      getLocationLoading.value = true;
      Position position = await locaationService.getCurrentPosition();
      lat.value = position.latitude;
      lng.value = position.longitude;
      address.value = await locaationService.getAddressFromLatLng(
          position.latitude, position.longitude);
    } catch (e) {
      showCustomSnackbar(e.toString());
    } finally {
      getLocationLoading.value = false;
    }
  }

  Future uploadFile() async {
    log('uploadFile() triggered', name: 'UploadFile');
    if (image.value == null) {
      log('Image is null, skipping upload', name: 'UploadFile Error');
      showCustomSnackbar('No image to upload');
      return;
    }
    final result = await fileRepo.uploadImage(image: image.value!);
    result.when(error: (e) async {
      showCustomSnackbar(e.message);
    }, success: (s) async {
      imagePath.value = s.data.name;
      update();
    });
  }
}
