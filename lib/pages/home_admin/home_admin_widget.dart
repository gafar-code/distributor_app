import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:distributor_app/controllers/home_controller.dart';
import 'package:distributor_app/repositories/task_repository.dart';
import 'package:distributor_app/utils/helper.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../controllers/sales_controller.dart';
import '../../flutter_flow/flutter_flow_drop_down.dart';
import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/form_field_controller.dart';
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
  final salesController = Get.put(SalesContoller());
  final controller = Get.put(HomeController());
  final dateRangeC = TextEditingController();
  final scheduleAtC = TextEditingController();
  DateTimeRange? selectedDateRange;
  DateTime? selectedScheduleAt;
  int? selectedSalesId;
  late HomeAdminModel _model;

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

  void clearFilters() {
    setState(() {
      dateRangeC.clear();
      scheduleAtC.clear();
      selectedDateRange = null;
      selectedScheduleAt = null;
      _model.dropDownValueController = FormFieldController<String>(null);
      selectedSalesId = null;
      _model.dropDownValue = null;
    });
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
                  context.pushNamed('Profile').then((_) {
                    controller.loadInitialTasks();
                    clearFilters();
                  });
                },
              ),
            ),
          ),
        ],
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
                      context.pushNamed('AddTask').then((_) {
                        controller.loadInitialTasks();
                        clearFilters();
                      });
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
                Align(
                  alignment: const AlignmentDirectional(0.0, 0.0),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 0.0, 12.0, 0.0),
                    child: FlutterFlowIconButton(
                      borderColor: Colors.white,
                      borderRadius: 20.0,
                      borderWidth: 1.0,
                      buttonSize: 40.0,
                      fillColor: FlutterFlowTheme.of(context).primary,
                      icon: const Icon(
                        Icons.filter_alt_rounded,
                        color: Colors.white,
                        size: 24.0,
                      ),
                      onPressed: () async {
                        showFilterModalBottom();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Obx(() => controller.isLoading.isTrue
              ? const Center(
                  child: Padding(
                  padding: EdgeInsets.only(top: 24),
                  child: CircularProgressIndicator(),
                ))
              : Expanded(
                  child: SmartRefresher(
                    controller: controller.refreshController,
                    onRefresh: () {
                      controller
                          .loadInitialTasks(); // Trigger a refresh of tasks without filter
                    },
                    onLoading: () {
                      controller
                          .loadMoreTasks(); // Load more tasks with the current filter
                    },
                    enablePullUp: true, // Enable pull-up to load more
                    child: ListView.builder(
                      itemCount:
                          controller.tasks.length, // Display all loaded tasks
                      itemBuilder: (_, index) {
                        final task = controller.tasks[index];
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
                                value: task.status == 'SUCCESS',
                                onChanged: (newValue) async {
                                  await context.pushNamed('DetailTaskAdmin',
                                      pathParameters: {
                                        'id': task.id.toString(),
                                      }).then((_) {
                                    controller
                                        .loadInitialTasks(); // Refresh after returning from detail page
                                  });
                                },
                                title: Text(
                                  task.title,
                                  style: FlutterFlowTheme.of(context)
                                      .titleLarge
                                      .override(
                                        fontFamily: 'Outfit',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                                subtitle: Text(
                                  task.body,
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
                    ),
                  ),
                ))
        ],
      ),
    );
  }

  Future<dynamic> showFilterModalBottom() {
    return showModalBottomSheet(
        backgroundColor: Colors.white,
        isScrollControlled: true,
        isDismissible: false,
        context: context,
        builder: (_) {
          return StatefulBuilder(builder: (context, changeState) {
            return FractionallySizedBox(
              heightFactor: 0.8,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Filters',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            if (selectedDateRange != null ||
                                selectedSalesId != null ||
                                selectedScheduleAt != null) {
                              clearFilters();
                              salesController.getSales();
                            }
                          },
                          child: const Icon(
                            Icons.filter_alt_off,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        GestureDetector(
                            onTap: () {
                              context.safePop();
                              clearFilters();
                            },
                            child: const Icon(Icons.close))
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextField(
                        controller: dateRangeC,
                        onTap: () async {
                          final dateRange = await showCustomDatePicker();
                          if (dateRange != null) {
                            setState(() {
                              selectedDateRange = DateTimeRange(
                                  start: dateRange.first!,
                                  end: dateRange.last!);
                              dateRangeC.text =
                                  '${DateFormat('dd MMM yyyy').format(selectedDateRange!.start)} - ${DateFormat('dd MMM yyyy').format(selectedDateRange!.end)}';
                            });
                            changeState(() {});
                          }
                        },
                        readOnly: true,
                        showCursor: false,
                        textInputAction: TextInputAction.next,
                        obscureText: false,
                        decoration: InputDecoration(
                          suffixIcon: const Icon(Icons.calendar_month_rounded),
                          labelText: 'Rentang Waktu',
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
                            )),
                    const SizedBox(
                      height: 12,
                    ),
                    TextField(
                        controller: scheduleAtC,
                        onTap: () async {
                          final date = await showCustomDatePicker(
                              type: CalendarDatePicker2Type.single);
                          if (date != null) {
                            setState(() {
                              selectedScheduleAt = date.first;
                              scheduleAtC.text = DateFormat('dd MMMM yyyy')
                                  .format(selectedScheduleAt!);
                            });
                            changeState(() {});
                          }
                        },
                        readOnly: true,
                        showCursor: false,
                        textInputAction: TextInputAction.next,
                        obscureText: false,
                        decoration: InputDecoration(
                          suffixIcon: const Icon(Icons.calendar_month_rounded),
                          labelText: 'Tanggal Pelaksanaan Tugas',
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
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).alternate,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
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
                            )),
                    const SizedBox(
                      height: 12,
                    ),
                    Column(
                      children: [
                        Align(
                          alignment: const AlignmentDirectional(0.0, 0.0),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                12.0, 24.0, 0.0, 0.0),
                            child: Text(
                              'PIC',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 18.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Obx(() => salesController.isLoading.isTrue
                            ? const Center(child: CircularProgressIndicator())
                            : Center(
                                child: FlutterFlowDropDown<String>(
                                  controller: _model.dropDownValueController ??=
                                      FormFieldController<String>(null),
                                  options: salesController.data.map((e) {
                                    return e.name;
                                  }).toList(),
                                  onChanged: (val) {
                                    changeState(() {});
                                    setState(() {
                                      _model.dropDownValue = salesController
                                          .data
                                          .where((e) => e.name == val)
                                          .first
                                          .id
                                          .toString();
                                      selectedSalesId = salesController.data
                                          .where((e) => e.name == val)
                                          .first
                                          .id;
                                    });
                                  },
                                  width: 205.0,
                                  height: 56.0,
                                  isSearchable: true,
                                  searchHintTextStyle:
                                      FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily: 'Readex Pro',
                                            letterSpacing: 0.0,
                                          ),
                                  searchTextStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        letterSpacing: 0.0,
                                      ),
                                  textStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        letterSpacing: 0.0,
                                      ),
                                  hintText: 'Pilih sales',
                                  searchHintText: 'Search for an item...',
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    size: 24.0,
                                  ),
                                  fillColor: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  elevation: 2.0,
                                  borderColor:
                                      FlutterFlowTheme.of(context).alternate,
                                  borderWidth: 2.0,
                                  borderRadius: 8.0,
                                  margin: const EdgeInsetsDirectional.fromSTEB(
                                      16.0, 4.0, 16.0, 4.0),
                                  hidesUnderline: true,
                                  isOverButton: true,
                                  isMultiSelect: false,
                                ),
                              )),
                        const SizedBox(
                          height: 30,
                        ),
                        FFButtonWidget(
                          onPressed: () {
                            if (selectedDateRange != null ||
                                selectedSalesId != null ||
                                selectedScheduleAt != null) {
                              controller.applyFilter(
                                TaskFilterParams(
                                  dateRange: selectedDateRange,
                                  salesId: selectedSalesId,
                                  scheduleAt: selectedScheduleAt,
                                ),
                              );
                            } else {
                              controller.loadWithRemovedFilters();
                            }
                            context.pop();
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
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }
}
