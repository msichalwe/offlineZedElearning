import '/flutter_flow/flutter_flow_util.dart';
import 'home_p_widget.dart' show HomePWidget;
import 'package:flutter/material.dart';

class HomePModel extends FlutterFlowModel<HomePWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
