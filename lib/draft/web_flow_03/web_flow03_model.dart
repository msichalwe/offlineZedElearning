import '/draft/side_nav/side_nav_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'web_flow03_widget.dart' show WebFlow03Widget;
import 'package:flutter/material.dart';

class WebFlow03Model extends FlutterFlowModel<WebFlow03Widget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for sideNav component.
  late SideNavModel sideNavModel;

  @override
  void initState(BuildContext context) {
    sideNavModel = createModel(context, () => SideNavModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    sideNavModel.dispose();
  }
}
