import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:school_platform_windows/backend/sqlite/sqlite_manager.dart';
import 'package:school_platform_windows/pages/assessment/score.dart';
import 'package:school_platform_windows/pages/view_assessment/view_assessment_widget.dart';
import 'package:school_platform_windows/pages/view_results/view_results_widget.dart';

import '/components/banner_widget.dart';
import '/components/footer_widget.dart';
import '/components/nav_widget.dart';
import '/components/side_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'assessment_model.dart';
export 'assessment_model.dart';

class AssessmentWidget extends StatefulWidget {
  final int? lessonId;

  const AssessmentWidget({super.key, this.lessonId});

  @override
  State<AssessmentWidget> createState() => _AssessmentWidgetState();
}

class _AssessmentWidgetState extends State<AssessmentWidget> {
  late AssessmentModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AssessmentModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                wrapWithModel(
                  model: _model.navModel,
                  updateCallback: () => setState(() {}),
                  child: NavWidget(),
                ),
                wrapWithModel(
                  model: _model.bannerModel,
                  updateCallback: () => setState(() {}),
                  child: BannerWidget(),
                ),
                Padding(
                  padding: EdgeInsets.all(24),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      wrapWithModel(
                        model: _model.sideModel,
                        updateCallback: () => setState(() {}),
                        child: SideWidget(),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(40, 10, 0, 0),
                            child: Material(
                              color: Colors.transparent,
                              elevation: 0.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Container(
                                width: 900,
                                height: 300,
                                decoration: BoxDecoration(

                                    color: FlutterFlowTheme
                                        .of(context)
                                        .secondaryBackground,
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    border: Border.all(
                                        color: Color(0xFFEFF1F2) as Color
                                    )

                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20, 20, 0, 20),
                                      child: Text(
                                        '${Provider.of<FFAppState>(context, listen: false).gradeName}',
                                        style: FlutterFlowTheme
                                            .of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily:
                                          'Roboto',
                                          fontSize:
                                          28.0,
                                          letterSpacing:
                                          0.0,
                                          fontWeight:
                                          FontWeight
                                              .w500,
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      thickness: 1,
                                      color: Color(0xFFEFF1F2),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 20, 0, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 800,
                                            height: 100,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Container(
                                                  width: double.infinity,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                10, 0, 10, 0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(padding: EdgeInsets.only(left: 5), child: Text(
                                                          'Assessment Title',
                                                          style: FlutterFlowTheme
                                                              .of(context)
                                                              .bodyMedium
                                                              .override(
                                                            fontFamily:
                                                            'Roboto',
                                                            color: FlutterFlowTheme.of(
                                                                context)
                                                                .secondaryBackground,
                                                            letterSpacing:
                                                            0,
                                                          ),
                                                        ),),
                                                        Padding(padding: EdgeInsets.only(right: 10), child: Text(
                                                          'Action',
                                                          style: FlutterFlowTheme
                                                              .of(context)
                                                              .bodyMedium
                                                              .override(
                                                            fontFamily:
                                                            'Roboto',
                                                            color: FlutterFlowTheme.of(
                                                                context)
                                                                .secondaryBackground,
                                                            letterSpacing:
                                                            0,
                                                          ),
                                                        ),),

                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                FutureBuilder(
                                                  future: SQLiteManager.instance
                                                      .getAssessmentsFromLessonId(
                                                          lessonId:
                                                              widget.lessonId),
                                                  builder: (context,
                                                      AsyncSnapshot<
                                                              List<
                                                                  GetLessonAssessmentsRow>>
                                                          snapshot) {
                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return const CircularProgressIndicator();
                                                    } else if (snapshot
                                                        .hasError) {
                                                      return Text(
                                                          'Error: ${snapshot.error}');
                                                    } else if (!snapshot
                                                            .hasData ||
                                                        snapshot
                                                            .data!.isEmpty) {
                                                      return const Text(
                                                          'No assessments found.');
                                                    } else {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => ViewAssessmentWidget(
                                                                      assessmentId: snapshot
                                                                          .data!
                                                                          .first
                                                                          .assessmentId)));
                                                        },
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          height: 50,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                    10,
                                                                    0,
                                                                    10,
                                                                    0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  '${snapshot.data!.first.assessmentName}',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        letterSpacing:
                                                                            0,
                                                                      ),
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                ViewResultsWidget(lessonId: snapshot.data!.first.assessmentId as int)));
                                                                  },
                                                                  child: Text(
                                                                    'View Results',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'Roboto',
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryText,
                                                                          letterSpacing:
                                                                              0,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                wrapWithModel(
                  model: _model.footerModel,
                  updateCallback: () => setState(() {}),
                  child: FooterWidget(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
