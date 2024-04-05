import '/components/footer_widget.dart';
import '/components/nav_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'lesson_widget.dart' show LessonWidget;
import 'package:flutter/material.dart';

class LessonModel extends FlutterFlowModel<LessonWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for nav component.
  late NavModel navModel;
  // Model for footer component.
  late FooterModel footerModel;

  @override
  void initState(BuildContext context) {
    navModel = createModel(context, () => NavModel());
    footerModel = createModel(context, () => FooterModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    navModel.dispose();
    footerModel.dispose();
  }
}
