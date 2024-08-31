import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../controllers/home_controller.dart';
import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../models/task_model.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'home_sales_model.dart';
export 'home_sales_model.dart';

class HomeSalesWidget extends StatefulWidget {
  const HomeSalesWidget({super.key});

  @override
  State<HomeSalesWidget> createState() => _HomeSalesWidgetState();
}

class _HomeSalesWidgetState extends State<HomeSalesWidget> {
  final controller = Get.put(HomeController());
  final refreshController = RefreshController();
  final dateRangeC = TextEditingController();
  final scheduleAtC = TextEditingController();
  DateTimeRange? selectedDateRange;
  DateTime? selectedScheduleAt;
  late HomeSalesModel _model;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeSalesModel());
  }

  void onRefresh() {
    controller.pagingController.refresh();
    refreshController.refreshCompleted();
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
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          title: Text(
            'Dasboard Sales',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Outfit',
                  color: Colors.white,
                  fontSize: 22.0,
                  letterSpacing: 0.0,
                ),
          ),
          actions: [
            Align(
              alignment: const AlignmentDirectional(0.0, 0.0),
              child: Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 12.0, 0.0),
                child: FlutterFlowIconButton(
                  borderColor: Colors.white,
                  borderRadius: 20.0,
                  borderWidth: 1.0,
                  buttonSize: 40.0,
                  fillColor: FlutterFlowTheme.of(context).accent1,
                  icon: Icon(
                    Icons.person_rounded,
                    color: FlutterFlowTheme.of(context).primaryBackground,
                    size: 24.0,
                  ),
                  onPressed: () async {
                    context.pushNamed('Profile');
                  },
                ),
              ),
            ),
          ],
          centerTitle: false,
          elevation: 2.0,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            taskSummaryWidget(),
            Padding(
              padding:
                  const EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Align(
                      alignment: const AlignmentDirectional(-1.0, 0.0),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            12.0, 0.0, 0.0, 0.0),
                        child: Text(
                          'Tugas',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 24.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                    ),
                  ),
                  // Obx(() => Padding(
                  //       padding: const EdgeInsetsDirectional.fromSTEB(
                  //           0.0, 0.0, 12.0, 0.0),
                  //       child: Text(
                  //         'selesai ${controller.completedTaskCount}/${controller.totalPendingTaskCount}',
                  //         style:
                  //             FlutterFlowTheme.of(context).bodyMedium.override(
                  //                   fontFamily: 'Readex Pro',
                  //                   fontSize: 18.0,
                  //                   letterSpacing: 0.0,
                  //                 ),
                  //       ),
                  //     )),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: SmartRefresher(
                controller: refreshController,
                onRefresh: onRefresh,
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
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              child: CheckboxListTile(
                                value: data.status == 'SUCCESS',
                                onChanged: (newValue) async {
                                  await context.pushNamed('DetailTaskSales',
                                      pathParameters: {
                                        'id': data.id.toString()
                                      });
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
                                activeColor:
                                    FlutterFlowTheme.of(context).primary,
                                checkColor: FlutterFlowTheme.of(context).info,
                                dense: false,
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
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
            ),
          ],
        ),
      ),
    );
  }

  Padding taskSummaryWidget() {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(12.0, 24.0, 12.0, 0.0),
      child: Obx(() => Card(
            margin: EdgeInsets.zero,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            elevation: 0,
            color: FlutterFlowTheme.of(context).secondaryBackground,
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              title: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Sukses',
                        style: FlutterFlowTheme.of(context).titleLarge.override(
                              fontFamily: 'Outfit',
                              letterSpacing: 0.0,
                            ),
                      ),
                      Text(
                        '${controller.completedTaskCount}',
                        style: FlutterFlowTheme.of(context).titleLarge.override(
                              fontFamily: 'Outfit',
                              letterSpacing: 0.0,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Pending',
                        style: FlutterFlowTheme.of(context).titleLarge.override(
                              fontFamily: 'Outfit',
                              letterSpacing: 0.0,
                            ),
                      ),
                      Text(
                        '${controller.totalPendingTaskCount}',
                        style: FlutterFlowTheme.of(context).titleLarge.override(
                              fontFamily: 'Outfit',
                              letterSpacing: 0.0,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Dijadwalkan',
                        style: FlutterFlowTheme.of(context).titleLarge.override(
                              fontFamily: 'Outfit',
                              letterSpacing: 0.0,
                            ),
                      ),
                      Text(
                        '${controller.scheduledTaskCount}',
                        style: FlutterFlowTheme.of(context).titleLarge.override(
                              fontFamily: 'Outfit',
                              letterSpacing: 0.0,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
