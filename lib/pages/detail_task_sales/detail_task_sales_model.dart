import '/flutter_flow/flutter_flow_util.dart';
import 'detail_task_sales_widget.dart' show DetailTaskSalesWidget;
import 'package:flutter/material.dart';

class DetailTaskSalesModel extends FlutterFlowModel<DetailTaskSalesWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
