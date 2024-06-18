import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'lesson_count_banner_model.dart';
export 'lesson_count_banner_model.dart';

class LessonCountBannerWidget extends StatefulWidget {
  const LessonCountBannerWidget({super.key});

  @override
  State<LessonCountBannerWidget> createState() =>
      _LessonCountBannerWidgetState();
}

class _LessonCountBannerWidgetState extends State<LessonCountBannerWidget>
    with TickerProviderStateMixin {
  late LessonCountBannerModel _model;

  Future<Map<String, int>> getFullProgressLessonsCount() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final Map<String, int> userProgressCount = {};

    final Set<String> keys = prefs.getKeys();

    for (String key in keys) {
      if (key.contains('-')) {
        List<String> parts = key.split('-');
        if (parts.length >= 2) {
          String userId = parts[0];
          int? progress = prefs.getInt(key);

          if (progress != null && progress == 100) {
            userProgressCount[userId] = (userProgressCount[userId] ?? 0) + 1;
          }
        }
      }
    }

    return userProgressCount;
  }

  final animationsMap = {
    'containerOnPageLoadAnimation1': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
    'containerOnPageLoadAnimation2': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
    'containerOnPageLoadAnimation3': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
  };

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LessonCountBannerModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(50.0, 0.0, 0.0, 0.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: FutureBuilder<List<LessonGradeCountRow>>(
                future: SQLiteManager.instance.getLessonGradeCount(
                    gradeId:
                        Provider.of<FFAppState>(context, listen: false).gradeId,
                    subjectName: Provider.of<FFAppState>(context, listen: false)
                        .subjectName),
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
                  final containerAllLessonsRowList = snapshot.data!;
                  return Container(
                    width: 270.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFE5D5),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Icon(
                            Icons.computer_rounded,
                            color: Color(0xFFFD7E14),
                            size: 70.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ' ${snapshot.data!.first.totalLessons}',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Roboto',
                                      fontSize: 19.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Text(
                                'Total Lessons',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Roboto',
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ].divide(const SizedBox(width: 15.0)),
                    ),
                  ).animateOnPageLoad(
                      animationsMap['containerOnPageLoadAnimation1']!);
                },
              ),
            ),
            FutureBuilder(
              future: SQLiteManager.instance.getAssessmentGradeCount(
                  gradeId:
                      Provider.of<FFAppState>(context, listen: false).gradeId,
                  subjectName: Provider.of<FFAppState>(context, listen: false)
                      .subjectName),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Container(
                      width: 280.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        color: const Color(0xFFCAB9E8),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(15.0),
                            child: FaIcon(
                              FontAwesomeIcons.clipboardCheck,
                              color: Color(0xFF6F42C1),
                              size: 70.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${snapshot.hasData && snapshot.data!.isNotEmpty && snapshot.data!.first.totalAssessments != null ? snapshot.data!.first.totalAssessments : 0}',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Roboto',
                                        fontSize: 19.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                Text(
                                  'Total Assessments',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Roboto',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ].divide(const SizedBox(width: 15.0)),
                      ),
                    ).animateOnPageLoad(
                        animationsMap['containerOnPageLoadAnimation2']!),
                  );
                }
              },
            ),
            FutureBuilder(
                future: getFullProgressLessonsCount(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  return Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Container(
                      height: 100.0,
                      decoration: BoxDecoration(
                        color: const Color(0xFFC2EEE1),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(15.0),
                            child: FaIcon(
                              FontAwesomeIcons.medal,
                              color: Color(0xFF0CBC87),
                              size: 70.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${snapshot.data![FFAppState().currentUser.hashCode.toString()] ?? 0}',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Roboto',
                                        fontSize: 19.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                Text(
                                  'Completed Lessons',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Roboto',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ].divide(const SizedBox(width: 15.0)),
                      ),
                    ).animateOnPageLoad(
                        animationsMap['containerOnPageLoadAnimation3']!),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
