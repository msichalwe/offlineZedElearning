import '/components/banner_widget.dart';
import '/components/footer_widget.dart';
import '/components/nav_widget.dart';
import '/components/side_widget.dart';
import '/components/test_comp_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'subject_widget.dart' show SubjectWidget;
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class SubjectModel extends FlutterFlowModel<SubjectWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for nav component.
  late NavModel navModel;
  // Model for banner component.
  late BannerModel bannerModel;
  // Model for side component.
  late SideModel sideModel;
  // State field(s) for Expandable widget.
  late ExpandableController expandableController;

  // Model for test_comp component.
  late TestCompModel testCompModel;
  // Model for footer component.
  late FooterModel footerModel;

  @override
  void initState(BuildContext context) {
    navModel = createModel(context, () => NavModel());
    bannerModel = createModel(context, () => BannerModel());
    sideModel = createModel(context, () => SideModel());
    testCompModel = createModel(context, () => TestCompModel());
    footerModel = createModel(context, () => FooterModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    navModel.dispose();
    bannerModel.dispose();
    sideModel.dispose();
    expandableController.dispose();
    testCompModel.dispose();
    footerModel.dispose();
  }
}
