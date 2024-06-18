import '/components/banner_widget.dart';
import '/components/nav_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'score_card_widget.dart' show ScoreCardWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ScoreCardModel extends FlutterFlowModel<ScoreCardWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for nav component.
  late NavModel navModel;
  // Model for banner component.
  late BannerModel bannerModel;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  @override
  void initState(BuildContext context) {
    navModel = createModel(context, () => NavModel());
    bannerModel = createModel(context, () => BannerModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    navModel.dispose();
    bannerModel.dispose();
    tabBarController?.dispose();
  }
}
