import 'package:distributor_app/controllers/delete_proof_controller.dart';
import 'package:distributor_app/controllers/proofs_controller.dart';
import 'package:distributor_app/utils/helper.dart';
import 'package:get/get.dart';

import '../../utils/prefs.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'image_detail_model.dart';
export 'image_detail_model.dart';

class ImageDetailWidget extends StatefulWidget {
  final int taskId;
  final int initIndex;
  const ImageDetailWidget(
      {super.key, required this.taskId, required this.initIndex});

  @override
  State<ImageDetailWidget> createState() => _ImageDetailWidgetState();
}

class _ImageDetailWidgetState extends State<ImageDetailWidget> {
  final proofController = Get.put(ProofsController());
  final deleteProofController = Get.put(DeleteProofController());
  final prefs = Get.find<PrefsService>().prefs;
  int currentIndex = 0;
  late ImageDetailModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ImageDetailModel());
    proofController.getProofs(widget.taskId);
    currentIndex = widget.initIndex;
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Align(
            alignment: const AlignmentDirectional(0.0, -1.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: const AlignmentDirectional(1.0, 0.0),
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(0, 12, 12.0, 0.0),
                    child: FlutterFlowIconButton(
                      borderColor: FlutterFlowTheme.of(context).error,
                      borderRadius: 20.0,
                      borderWidth: 1.0,
                      buttonSize: 40.0,
                      icon: Icon(
                        Icons.close,
                        color: FlutterFlowTheme.of(context).error,
                        size: 24.0,
                      ),
                      onPressed: () async {
                        context.safePop();
                      },
                    ),
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(0.0, -1.0),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 24.0, 0.0, 0.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 300.0,
                      child: Obx(() => proofController.isLoading.isTrue
                          ? const Center(
                              child: Text(
                                'LOADING IMAGE...',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            )
                          : CarouselSlider(
                              items: proofController.data
                                  .map((data) => ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.network(
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return const Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.error,
                                                  size: 200,
                                                  color: Colors.red,
                                                ),
                                                Text('GAGAL MEMUAT GAMBAR')
                                              ],
                                            );
                                          },
                                          getImageRemote(data.image),
                                          width: 300.0,
                                          height: 200.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ))
                                  .toList(),
                              carouselController: _model.carouselController ??=
                                  CarouselController(),
                              options: CarouselOptions(
                                  initialPage: currentIndex,
                                  viewportFraction: 0.8,
                                  disableCenter: true,
                                  enlargeCenterPage: true,
                                  enlargeFactor: 0.25,
                                  enableInfiniteScroll: false,
                                  scrollDirection: Axis.horizontal,
                                  autoPlay: false,
                                  onPageChanged: (index, _) => setState(() {
                                        currentIndex = index;
                                      })),
                            )),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: const AlignmentDirectional(-1.0, 0.0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              12.0, 0.0, 0.0, 0.0),
                          child: Text(
                            'Deskripsi',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ),
                      prefs.getString('role') == 'ADMIN'
                          ? const SizedBox()
                          : Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 24.0, 0.0),
                              child: GestureDetector(
                                onTap: () {
                                  context
                                      .pushNamed('AddProof', pathParameters: {
                                    'id': proofController.data[currentIndex].id
                                        .toString(),
                                    'isEdit': true.toString(),
                                    'description': proofController
                                        .data[currentIndex].description
                                  }).then((_) {
                                    proofController.getProofs(widget.taskId);
                                  });
                                },
                                child: Icon(
                                  Icons.edit_square,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  size: 24.0,
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(-1.0, 0.0),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        12.0, 12.0, 0.0, 0.0),
                    child: Obx(() => proofController.isLoading.isTrue
                        ? const Text('Loading.....')
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                proofController.data[currentIndex].description,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      letterSpacing: 0.0,
                                    ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Lokasi : ${proofController.data[currentIndex].address}',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ],
                          )),
                  ),
                ),
                prefs.getString('role') == 'ADMIN'
                    ? const SizedBox()
                    : Align(
                        alignment: const AlignmentDirectional(-1.0, 0.0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              12.0, 24.0, 0.0, 0.0),
                          child: Text(
                            'Pengaturan',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ),
                prefs.getString('role') == 'ADMIN'
                    ? const SizedBox()
                    : Align(
                        alignment: const AlignmentDirectional(-1.0, 0.0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              12.0, 12.0, 0.0, 0.0),
                          child: Obx(() => deleteProofController
                                  .isLoading.isTrue
                              ? const CircularProgressIndicator()
                              : FFButtonWidget(
                                  onPressed: () async {
                                    Future.delayed(
                                        Duration.zero,
                                        () => deleteProofController.deleteProof(
                                            proofId: proofController
                                                .data[currentIndex].id,
                                            fileName: proofController
                                                .data[currentIndex]
                                                .image)).then((_) {
                                      if (proofController.data.length == 1) {
                                        context.pop();
                                      } else {
                                        proofController
                                            .getProofs(widget.taskId);
                                      }
                                    });
                                  },
                                  text: 'Hapus',
                                  options: FFButtonOptions(
                                    height: 40.0,
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            24.0, 0.0, 24.0, 0.0),
                                    iconPadding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 0.0),
                                    color: FlutterFlowTheme.of(context).error,
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
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
