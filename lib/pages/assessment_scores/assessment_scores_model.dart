import '/components/banner_widget.dart';
import '/components/nav_widget.dart';
import '/components/side_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'assessment_scores_widget.dart' show AssessmentScoresWidget;
import 'package:flutter/material.dart';

class AssessmentScoresModel extends FlutterFlowModel<AssessmentScoresWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for nav component.
  late NavModel navModel;
  // Model for banner component.
  late BannerModel bannerModel;
  // Model for side component.
  late SideModel sideModel;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {
    navModel = createModel(context, () => NavModel());
    bannerModel = createModel(context, () => BannerModel());
    sideModel = createModel(context, () => SideModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    navModel.dispose();
    bannerModel.dispose();
    sideModel.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
