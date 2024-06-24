import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:school_platform_windows/index.dart';
import 'package:url_launcher/url_launcher.dart';

import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'side_model.dart';
export 'side_model.dart';

class SideWidget extends StatefulWidget {
  const SideWidget({
    super.key,
    int? selectedNav,
    int? gradeId,
  })  : selectedNav = selectedNav ?? 0,
        gradeId = gradeId ?? 1;

  final int selectedNav;
  final int gradeId;

  @override
  State<SideWidget> createState() => _SideWidgetState();
}

class _SideWidgetState extends State<SideWidget> {
  late SideModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SideModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350.0,
      decoration: BoxDecoration(
        color: const Color(0xFF24292D),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              InkWell(
                onTap: () {
                  FFAppState().update(() {
                    FFAppState().subjectName = 'Dashboard';
                  });
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 300),
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(1.0, 0.0),
                            end: Offset.zero,
                          ).animate(animation),
                          child: const GradeDashboardWidget(),
                        );
                      },
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    height: 40.0,
                    decoration: BoxDecoration(
                      color: Provider.of<FFAppState>(context, listen: false)
                                  .subjectName
                                  .toString() ==
                              'Dashboard'
                          ? FlutterFlowTheme.of(context).secondaryBackground
                          : const Color(0x00FFFFFF),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          10.0, 0.0, 0.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Icon(
                            Icons.dashboard_customize_outlined,
                              color: Provider.of<FFAppState>(
                                                            context,
                                                            listen: false)
                                                        .subjectName
                                                        .toString() !=
                                                    
                                                        'Dashboard'
                                                ? FlutterFlowTheme.of(context)
                                                    .primaryBackground
                                                : Colors.black,
                            size: 25.0,
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                10.0, 0.0, 0.0, 0.0),
                            child: Text(
                              'Dashboard',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    color: Provider.of<FFAppState>(
                                                            context,
                                                            listen: false)
                                                        .subjectName
                                                        .toString() !=
                                                    
                                                        'Dashboard'
                                                ? FlutterFlowTheme.of(context)
                                                    .primaryBackground
                                                : Colors.black,
                                    fontFamily: 'Roboto',
                                    fontSize: 18.0,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // GestureDetector(
              //   onTap: () {
              //     FFAppState().update(() {
              //       FFAppState().subjectName = 'Assessment Scores';
              //     });
              //     // Navigator.push(
              //     //   context,
              //     //   PageRouteBuilder(
              //     //     transitionDuration: Duration(milliseconds: 300),
              //     //     pageBuilder: (context, animation, secondaryAnimation) {
              //     //       return SlideTransition(
              //     //         position: Tween<Offset>(
              //     //           begin: const Offset(1.0, 0.0),
              //     //           end: Offset.zero,
              //     //         ).animate(animation),
              //     //         child: AssessmentScoresWidget(),
              //     //       );
              //     //     },
              //     //   ),
              //     // );
              //   },
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: Container(
              //       width: double.infinity,
              //       height: 40.0,
              //       decoration: BoxDecoration(
              //         color: const Color(0x00FFFFFF),
              //         borderRadius: BorderRadius.circular(10.0),
              //       ),
              //       child: Padding(
              //         padding: const EdgeInsetsDirectional.fromSTEB(
              //             10.0, 0.0, 0.0, 0.0),
              //         child: Row(
              //           mainAxisSize: MainAxisSize.max,
              //           children: [
              //             Icon(
              //               Icons.dashboard_customize_outlined,
              //               color:
              //                   FlutterFlowTheme.of(context).primaryBackground,
              //               size: 25.0,
              //             ),
              //             Padding(
              //               padding: const EdgeInsetsDirectional.fromSTEB(
              //                   10.0, 0.0, 0.0, 0.0),
              //               child: Text(
              //                 'Assessment Scores',
              //                 style: FlutterFlowTheme.of(context)
              //                     .bodyMedium
              //                     .override(
              //                       fontFamily: 'Roboto',
              //                       color:
              //                           FlutterFlowTheme.of(context).alternate,
              //                       fontSize: 15.0,
              //                       letterSpacing: 0.0,
              //                     ),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Access Virtual Labs'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text('You can access the virtual labs online.'),
                              SizedBox(height: 10),
                              RichText(
                                text: TextSpan(
                                  text: 'Click here to visit: ',
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'The Virtual Labs',
                                      style: TextStyle(color: Colors.blue),
                                      recognizer: TapGestureRecognizer()..onTap = () {
                                        // Code to open the link
                                        launch('https://zedelearning.chalotek.com/');
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Close'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    height: 40.0,
                    decoration: BoxDecoration(
                      color: const Color(0x00FFFFFF),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.robot,
                            color: FlutterFlowTheme.of(context).primaryBackground,
                            size: 25.0,
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                            child: Text(
                              'Virtual Labs ',
                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Roboto',
                                color: FlutterFlowTheme.of(context).primaryBackground,
                                fontSize: 15.0,
                                letterSpacing: 0.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: const Color(0x00FFFFFF),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        10.0, 0.0, 0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'SUBJECTS',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Roboto',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    fontSize: 18.0,
                                    letterSpacing: 0.0,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              FutureBuilder<List<GetSubjectsInGradeRow>>(
                future: SQLiteManager.instance.getSubjectsInGrade(
                    gradeId: Provider.of<FFAppState>(context, listen: false)
                        .gradeId
                        .toString()),
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
                  final columnGetSubjectsInGradeRowList = snapshot.data!;
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: List.generate(
                        columnGetSubjectsInGradeRowList.length, (columnIndex) {
                      final columnGetSubjectsInGradeRow =
                          columnGetSubjectsInGradeRowList[columnIndex];
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            FFAppState().update(() {
                              FFAppState().subjectName =
                                  columnGetSubjectsInGradeRow.subjectName;
                            });

                            if (Navigator.of(context).canPop()) {
                              context.pop();
                            }
                            context.pushNamed(
                              'subject',
                              queryParameters: {
                                'syllabusId': serializeParam(
                                  valueOrDefault<int>(
                                    columnGetSubjectsInGradeRow.syllabusId,
                                    0,
                                  ),
                                  ParamType.int,
                                ),
                              }.withoutNulls,
                              extra: <String, dynamic>{
                                kTransitionInfoKey: const TransitionInfo(
                                  hasTransition: true,
                                  transitionType: PageTransitionType.fade,
                                  duration: Duration(milliseconds: 10),
                                ),
                              },
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            height: 40.0,
                            decoration: BoxDecoration(
                              color: Provider.of<FFAppState>(context,
                                              listen: false)
                                          .subjectName
                                          .toString() ==
                                      columnGetSubjectsInGradeRow.subjectName
                                  ? FlutterFlowTheme.of(context)
                                      .secondaryBackground
                                  : const Color(0x00FFFFFF),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10.0, 0.0, 0.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  // Icon(
                                  //   Icons.subject,
                                  //     color: Provider.of<FFAppState>(
                                  //                           context,
                                  //                           listen: false)
                                  //                       .subjectName
                                  //                       .toString() !=
                                  //                   columnGetSubjectsInGradeRow
                                  //                       .subjectName
                                  //               ? FlutterFlowTheme.of(context)
                                  //                   .primaryBackground
                                  //               : Colors.black,
                                  //   size: 25.0,
                                  // ),
                                  SubjectIcon(subjectName: columnGetSubjectsInGradeRow.subjectName.toString()),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            10.0, 0.0, 0.0, 0.0),
                                    child: Text(
                                      valueOrDefault<String>(
                                        columnGetSubjectsInGradeRow.subjectName,
                                        'maths',
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Roboto',
                                            color: Provider.of<FFAppState>(
                                                            context,
                                                            listen: false)
                                                        .subjectName
                                                        .toString() !=
                                                    columnGetSubjectsInGradeRow
                                                        .subjectName
                                                ? FlutterFlowTheme.of(context)
                                                    .primaryBackground
                                                : Colors.black,
                                            fontSize: 15.0,
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class SubjectIcon extends StatelessWidget {
  final String subjectName;

  SubjectIcon({required this.subjectName});

  @override
  Widget build(BuildContext context) {
    Color iconColor = Provider.of<FFAppState>(context, listen: false).subjectName != subjectName
        ? FlutterFlowTheme.of(context).primaryBackground
        : Colors.black;

    IconData iconData;
    switch (subjectName) {
      case 'Mathematics':
        iconData = Icons.calculate; // Example icon for Mathematics
        break;
      case 'English':
        iconData = Icons.language; // Example icon for English
        break;
      case 'Physics':
        iconData = Icons.directions_bike; // Example icon for Physics
        break;
      case 'Chemistry':
        iconData = Icons.biotech; // Example icon for Chemistry
        break;
      case 'Biology':
        iconData = Icons.eco; // Example icon for Biology
        break;
      default:
        iconData = Icons.subject; // Default icon for any other subject
    }

    return Icon(
      iconData,
      color: iconColor,
      size: 25.0,
    );
  }
}