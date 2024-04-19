import '/components/banner_widget.dart';
import '/components/footer_widget.dart';
import '/components/nav_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'view_assessment_widget.dart' show ViewAssessmentWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ViewAssessmentModel extends FlutterFlowModel<ViewAssessmentWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for nav component.
  late NavModel navModel;
  // Model for banner component.
  late BannerModel bannerModel;
  // Model for footer component.
  late FooterModel footerModel;

  @override
  void initState(BuildContext context) {
    navModel = createModel(context, () => NavModel());
    bannerModel = createModel(context, () => BannerModel());
    footerModel = createModel(context, () => FooterModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    navModel.dispose();
    bannerModel.dispose();
    footerModel.dispose();
  }
}
