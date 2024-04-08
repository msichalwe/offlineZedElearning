import '/components/footer_widget.dart';
import '/components/header_nav_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'home_primary_widget.dart' show HomePrimaryWidget;
import 'package:flutter/material.dart';

class HomePrimaryModel extends FlutterFlowModel<HomePrimaryWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for footer component.
  late FooterModel footerModel;
  // Model for headerNav component.
  late HeaderNavModel headerNavModel;

  @override
  void initState(BuildContext context) {
    footerModel = createModel(context, () => FooterModel());
    headerNavModel = createModel(context, () => HeaderNavModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    footerModel.dispose();
    headerNavModel.dispose();
  }
}
