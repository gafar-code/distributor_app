import '/flutter_flow/flutter_flow_util.dart';
import 'add_proof_widget.dart' show AddProofWidget;
import 'package:flutter/material.dart';

class AddProofModel extends FlutterFlowModel<AddProofWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController textController = TextEditingController();
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController.dispose();
  }
}
