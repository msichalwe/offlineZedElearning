import '/components/footer_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'home_primary_widget.dart' show HomePrimaryWidget;
import 'package:flutter/material.dart';

class HomePrimaryModel extends FlutterFlowModel<HomePrimaryWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for footer component.
  late FooterModel footerModel;

  @override
  void initState(BuildContext context) {
    footerModel = createModel(context, () => FooterModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    footerModel.dispose();
  }
}
