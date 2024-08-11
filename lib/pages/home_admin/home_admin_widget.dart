import 'package:distributor_app/controllers/home_controller.dart';
import 'package:distributor_app/models/task_model.dart';
import 'package:distributor_app/utils/prefs.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'home_admin_model.dart';
export 'home_admin_model.dart';

class HomeAdminWidget extends StatefulWidget {
  const HomeAdminWidget({super.key});

  @override
  State<HomeAdminWidget> createState() => _HomeAdminWidgetState();
}

class _HomeAdminWidgetState extends State<HomeAdminWidget> {
  final controller = Get.put(HomeController());
  late HomeAdminModel _model;

  final prefs = Get.find<PrefsService>().prefs;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeAdminModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primary,
        automaticallyImplyLeading: false,
        title: Text(
          'Dasboard Admin',
          style: FlutterFlowTheme.of(context).headlineMedium.override(
                fontFamily: 'Outfit',
                color: Colors.white,
                fontSize: 22.0,
                letterSpacing: 0.0,
              ),
        ),
        centerTitle: false,
        elevation: 2.0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        12.0, 0.0, 0.0, 0.0),
                    child: Text(
                      'Tugas Tersedia',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Readex Pro',
                            fontSize: 24.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 12.0, 0.0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      context.pushNamed('AddTask');
                    },
                    text: 'Tambah',
                    options: FFButtonOptions(
                      height: 40.0,
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          24.0, 0.0, 24.0, 0.0),
                      iconPadding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
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
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height / 2.1,
            child: PagedListView<int, Task>(
                pagingController: controller.pagingController,
                builderDelegate: PagedChildBuilderDelegate(
                  itemBuilder: (_, data, index) {
                    return Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          12.0, 12.0, 12.0, 0.0),
                      child: Theme(
                        data: ThemeData(
                          splashColor: Colors.transparent,
                          checkboxTheme: const CheckboxThemeData(
                            visualDensity: VisualDensity.compact,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                          ),
                          unselectedWidgetColor:
                              FlutterFlowTheme.of(context).secondaryText,
                        ),
                        child: Card(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero),
                          margin: EdgeInsets.zero,
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          child: CheckboxListTile(
                            value: data.status == 'SUCCESS',
                            onChanged: (newValue) async {
                              await context.pushNamed('DetailTaskAdmin');
                            },
                            title: Text(
                              data.title,
                              style: FlutterFlowTheme.of(context)
                                  .titleLarge
                                  .override(
                                    fontFamily: 'Outfit',
                                    letterSpacing: 0.0,
                                  ),
                            ),
                            subtitle: Text(
                              data.body,
                              style: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    letterSpacing: 0.0,
                                  ),
                            ),
                            activeColor: FlutterFlowTheme.of(context).primary,
                            checkColor: FlutterFlowTheme.of(context).info,
                            dense: false,
                            controlAffinity: ListTileControlAffinity.trailing,
                          ),
                        ),
                      ),
                    );
                  },
                  noItemsFoundIndicatorBuilder: (_) {
                    return const Center(
                      child: Text('NO DATA '),
                    );
                  },
                )),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(12.0, 28.0, 0.0, 0.0),
            child: Text(
              'Akun',
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Readex Pro',
                    fontSize: 24.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsetsDirectional.fromSTEB(12.0, 12.0, 12.0, 0.0),
            child: InkWell(
              onTap: () async {
                context.pushNamed('ChangePass');
              },
              child: ListTile(
                title: Text(
                  'Keamanan',
                  style: FlutterFlowTheme.of(context).titleLarge.override(
                        fontFamily: 'Outfit',
                        letterSpacing: 0.0,
                      ),
                ),
                subtitle: Text(
                  'ubah sandi',
                  style: FlutterFlowTheme.of(context).labelMedium.override(
                        fontFamily: 'Readex Pro',
                        letterSpacing: 0.0,
                      ),
                ),
                trailing: Icon(
                  Icons.password,
                  color: FlutterFlowTheme.of(context).secondaryText,
                  size: 20.0,
                ),
                tileColor: FlutterFlowTheme.of(context).secondaryBackground,
                dense: false,
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsetsDirectional.fromSTEB(12.0, 12.0, 12.0, 0.0),
            child: InkWell(
              onTap: () async {
                Navigator.pop(context);
              },
              child: ListTile(
                onTap: () async {
                  prefs.clear();
                  context.go('/loginPage', extra: {'clearStack': true});
                },
                title: Text(
                  'Keluar',
                  style: FlutterFlowTheme.of(context).titleLarge.override(
                        fontFamily: 'Outfit',
                        letterSpacing: 0.0,
                      ),
                ),
                subtitle: Text(
                  'keluar akun',
                  style: FlutterFlowTheme.of(context).labelMedium.override(
                        fontFamily: 'Readex Pro',
                        letterSpacing: 0.0,
                      ),
                ),
                trailing: Icon(
                  Icons.exit_to_app,
                  color: FlutterFlowTheme.of(context).secondaryText,
                  size: 20.0,
                ),
                tileColor: FlutterFlowTheme.of(context).secondaryBackground,
                dense: false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
