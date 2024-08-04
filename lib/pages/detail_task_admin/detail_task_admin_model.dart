import '/flutter_flow/flutter_flow_util.dart';
import 'detail_task_admin_widget.dart' show DetailTaskAdminWidget;
import 'package:flutter/material.dart';

class DetailTaskAdminModel extends FlutterFlowModel<DetailTaskAdminWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
