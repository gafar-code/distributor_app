import 'dart:developer';

import 'package:distributor_app/controllers/add_edit_proof_controller.dart';
import 'package:distributor_app/utils/helper.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'add_proof_model.dart';
export 'add_proof_model.dart';

class AddProofWidget extends StatefulWidget {
  final int taskId;
  final String? description;
  final bool isEdit;
  const AddProofWidget(
      {super.key,
      required this.taskId,
      required this.isEdit,
      this.description});

  @override
  State<AddProofWidget> createState() => _AddProofWidgetState();
}

class _AddProofWidgetState extends State<AddProofWidget> {
  final addProofController = Get.put(AddEditProofController());
  final scrollController = ScrollController();
  late AddProofModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddProofModel());
    _model.textFieldFocusNode = FocusNode();
    _requestLocationPermission();
    if (widget.isEdit && widget.description != 'empty') {
      addProofController.descriptionC.text = widget.description.toString();
    }
  }

  void _scrollToField() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _requestLocationPermission() async {
    LocationPermission permission =
        await addProofController.locaationService.requestLocationPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      _showPermissionDeniedDialog();
    }
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Izin akses lokasi ditolak.'),
        content: const Text('Akses lokasi diperlukan untuk melanjutkan'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context); // Navigate back to the previous screen
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void clearFields() {
    addProofController.image.value = null;
    addProofController.lat.value = null;
    addProofController.lng.value = null;
    addProofController.address.value = null;
    addProofController.imagePath.value = null;
    addProofController.descriptionC.clear();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        clearFields();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () async {
              clearFields();
              context.pop();
            },
          ),
          title: Text(
            widget.isEdit == true ? 'Edit Bukti' : 'Tambah bukti',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Outfit',
                  color: Colors.white,
                  fontSize: 22.0,
                  letterSpacing: 0.0,
                ),
          ),
          actions: const [],
          centerTitle: false,
          elevation: 2.0,
        ),
        body: Form(
          key: formKey,
          child: ListView(
            controller: scrollController,
            children: [
              widget.isEdit == true
                  ? const SizedBox()
                  : Obx(() => Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 24.0, 0.0, 0.0),
                      child: addProofController.image.value != null
                          ? imageWidget()
                          : takeImageWidget())),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: const AlignmentDirectional(0.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          24.0, 24.0, 24.0, 12.0),
                      child: TextFormField(
                        controller: addProofController.descriptionC,
                        onTap: () {
                          if (addProofController.image.value != null) {
                            _scrollToField();
                          }
                        },
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Deskripsi',
                          labelStyle:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Readex Pro',
                                    letterSpacing: 0.0,
                                  ),
                          hintStyle:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Readex Pro',
                                    letterSpacing: 0.0,
                                  ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).alternate,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).primary,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Readex Pro',
                              letterSpacing: 0.0,
                            ),
                        textAlign: TextAlign.start,
                        maxLines: 5,
                        maxLength: 80,
                        validator: (val) => val!.isEmpty ? 'Wajib diisi' : null,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 0.0, 0.0, 24.0),
                    child: Obx(() => addProofController.isLoading.isTrue
                        ? const CircularProgressIndicator()
                        : FFButtonWidget(
                            onPressed: () async {
                              if (widget.isEdit) {
                                addProofController.addOrEditProof(context,
                                    taskId: widget.taskId, isEdit: true);
                              } else {
                                if (formKey.currentState!.validate()) {
                                  if (addProofController.image.value != null) {
                                    addProofController.addOrEditProof(context,
                                        taskId: widget.taskId, isEdit: false);
                                  } else {
                                    showCustomSnackbar(
                                        'Masukkan gambar terlebih dahulu');
                                  }
                                }
                              }
                            },
                            text: 'Simpan',
                            options: FFButtonOptions(
                              height: 40.0,
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  24.0, 0.0, 24.0, 0.0),
                              iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: FlutterFlowTheme.of(context).primary,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    color: Colors.white,
                                    letterSpacing: 0.0,
                                  ),
                              elevation: 3.0,
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector takeImageWidget() {
    return GestureDetector(
      onTap: () async {
        await addProofController.takeImage();
        log(addProofController.lat.toString());
        log(addProofController.lng.toString());
        log(addProofController.address.toString());
      },
      child: const Column(
        children: [
          Icon(
            Icons.camera_alt_rounded,
            size: 100,
          ),
          Text('KLIK UNTUK AMBIL GAMBAR')
        ],
      ),
    );
  }

  Column imageWidget() {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.file(
            addProofController.image.value!,
            width: 300.0,
            height: 300.0,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        addProofController.getLocationLoading.isTrue
            ? const Text('Mengambil data lokasi....')
            : Text(
                'Lokasi : ${addProofController.address}',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
        const SizedBox(
          height: 15,
        ),
        GestureDetector(
            onTap: () async {
              await addProofController.takeImage();
            },
            child: const Text(
              'UBAH GAMBAR',
              style: TextStyle(decoration: TextDecoration.underline),
            ))
      ],
    );
  }
}
