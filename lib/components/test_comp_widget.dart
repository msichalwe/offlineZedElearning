import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:school_platform_windows/pages/assessment/assessment_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'test_comp_model.dart';
export 'test_comp_model.dart';

class TestCompWidget extends StatefulWidget {
  const TestCompWidget({
    super.key,
    required this.subtopicID,
  });

  final int? subtopicID;

  @override
  State<TestCompWidget> createState() => _TestCompWidgetState();
}

class _TestCompWidgetState extends State<TestCompWidget> {
  late TestCompModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TestCompModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  Future<int?> getLessonProgress(String userId, String lessonId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('$userId-$lessonId');
  }

  double scaleBetween(double value, double min, double max) {
    return (value - min) / (max - min);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: FutureBuilder<List<GetLessonsFromSubtopicsRow>>(
        future: SQLiteManager.instance.getLessonsFromSubtopics(
          subtopicId: widget.subtopicID,
        ),
        builder: (context, snapshot) {
          // Customize what your widget looks like when it's loading.
          if (!snapshot.hasData) {
            return Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            );
          }
          final columnGetLessonsFromSubtopicsRowList = snapshot.data!;
          return Column(
            mainAxisSize: MainAxisSize.max,
            children: List.generate(columnGetLessonsFromSubtopicsRowList.length,
                (columnIndex) {
              final columnGetLessonsFromSubtopicsRow =
                  columnGetLessonsFromSubtopicsRowList[columnIndex];
              return InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  context.pushNamed(
                    'lesson',
                    queryParameters: {
                      'lessonId': serializeParam(
                        valueOrDefault<int>(
                          columnGetLessonsFromSubtopicsRow.lessonId,
                          0,
                        ),
                        ParamType.int,
                      ),
                    }.withoutNulls,
                    extra: <String, dynamic>{
                      kTransitionInfoKey: const TransitionInfo(
                        hasTransition: true,
                        transitionType: PageTransitionType.fade,
                      ),
                    },
                  );
                },
                child: FutureBuilder(
                    future: getLessonProgress(
                        FFAppState().currentUser.hashCode.toString(),
                                    
                        columnGetLessonsFromSubtopicsRow.lessonId.toString()),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      return Container(
                        decoration: const BoxDecoration(),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 188.0,
                                decoration: const BoxDecoration(),
                                child: Wrap(
                                  spacing: 0.0,
                                  runSpacing: 0.0,
                                  alignment: WrapAlignment.start,
                                  crossAxisAlignment: WrapCrossAlignment.start,
                                  direction: Axis.horizontal,
                                  runAlignment: WrapAlignment.start,
                                  verticalDirection: VerticalDirection.down,
                                  clipBehavior: Clip.none,
                                  children: [
                                    AutoSizeText(
                                      valueOrDefault<String>(
                                        columnGetLessonsFromSubtopicsRow
                                            .lessonName,
                                        'default',
                                      ).maybeHandleOverflow(maxChars: 48),
                                      maxLines: 3,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Roboto',
                                            fontSize: 15.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w300,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      10.0, 0.0, 0.0, 0.0),
                                  child: Container(
                                    decoration: const BoxDecoration(),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0.0, 0.0, 0.0, 8.0),
                                            child: Text(
                                              'Your progress is ${double.parse(snapshot.data?.toString() ?? '0')}%',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Roboto',
                                                        letterSpacing: 0.0,
                                                      ),
                                            ),
                                          ),
                                          Align(
                                            alignment:
                                                const AlignmentDirectional(
                                                    0.0, 1.0),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      0.0, 0.0, 0.0, 10.0),
                                              child: LinearPercentIndicator(
                                                percent: scaleBetween(
                                                    double.parse(snapshot.data
                                                            ?.toString() ??
                                                        '0'),
                                                    0,
                                                    100),
                                                width: 350.0,
                                                lineHeight: 5.0,
                                                animation: true,
                                                animateFromLastPercent: true,
                                                progressColor:
                                                    Color(0xff0D52BC),
                                                backgroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                                barRadius:
                                                    const Radius.circular(2.0),
                                                padding: EdgeInsets.zero,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              FFButtonWidget(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation, secondaryAnimation) => AssessmentWidget(
                                        lessonId: columnGetLessonsFromSubtopicsRow.lessonId,
                                      ),
                                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                        return FadeTransition(
                                          opacity: animation,
                                          child: child,
                                        );
                                      },
                                    ),
                                  );

                                },
                                text: 'Assessment',
                                options: FFButtonOptions(
                                  width: 170.0,
                                  height: 35.0,
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      24.0, 0.0, 24.0, 0.0),
                                  iconPadding:
                                      const EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 0.0),
                                  color: const Color(0xFF0CBC87),
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: 'Roboto',
                                        color: Colors.white,
                                        fontSize: 15.0,
                                        letterSpacing: 0.0,
                                      ),
                                  elevation: 0.0,
                                  borderSide: const BorderSide(
                                    color: Color(0xFF0CBC87),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              );
            }),
          );
        },
      ),
    );
  }
}
