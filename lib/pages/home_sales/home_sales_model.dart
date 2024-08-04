import '/flutter_flow/flutter_flow_util.dart';
import 'home_sales_widget.dart' show HomeSalesWidget;
import 'package:flutter/material.dart';

class HomeSalesModel extends FlutterFlowModel<HomeSalesWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for CheckboxListTile widget.
  bool? checkboxListTileValue1;
  // State field(s) for CheckboxListTile widget.
  bool? checkboxListTileValue2;
  // State field(s) for CheckboxListTile widget.
  bool? checkboxListTileValue3;
  // State field(s) for CheckboxListTile widget.
  bool? checkboxListTileValue4;
  // State field(s) for CheckboxListTile widget.
  bool? checkboxListTileValue5;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
