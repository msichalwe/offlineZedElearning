import '/flutter_flow/flutter_flow_util.dart';
import 'onboarding_copy_widget.dart' show OnboardingCopyWidget;
import 'package:flutter/material.dart';

class OnboardingCopyModel extends FlutterFlowModel<OnboardingCopyWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
