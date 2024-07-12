import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:school_platform_windows/backend/sqlite/sqlite_manager.dart';
import 'package:school_platform_windows/flutter_flow/custom_functions.dart';
import 'package:school_platform_windows/pages/assessment/score.dart';
import 'package:school_platform_windows/pages/view_assessment/view_assessment_widget.dart';

import '../../backend/offline_sqlite.dart';
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

import 'view_results_model.dart';
export 'view_results_model.dart';

class ViewResultsWidget extends StatefulWidget {
  final int? lessonId;

  const ViewResultsWidget({super.key, this.lessonId});

  @override
  State<ViewResultsWidget> createState() => _ViewResultsWidgetState();
}

class _ViewResultsWidgetState extends State<ViewResultsWidget> {
  late ViewResultsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final DBHelper dbHelper = DBHelper();
  int count = 0;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ViewResultsModel());
    count = 0;

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  Future<Map?> convertBlobToMap(Uint8List blobData) async {
    // Create ByteData from Uint8List
    final byteData = ByteData.sublistView(blobData);

    // Decode the ByteData back to the original Map using StandardMessageCodec
    final codec = StandardMessageCodec();
    Map? decodedMap = codec.decodeMessage(byteData) as Map?;

    return decodedMap; // Return the decoded map
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
      _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme
            .of(context)
            .primaryBackground,
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
                      FutureBuilder(
                          future: SQLiteManager.instance
                              .getAssessment(assessmentId: widget.lessonId),
                          builder: (context, snapshotMain) {
                            return Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                FutureBuilder(
                                    future: dbHelper.fetchSpecificRecord(
                                        FFAppState().currentUser.hashCode,
                                        widget.lessonId as int),
                                    builder: (context, snapshot){
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const CircularProgressIndicator();
                                      }
                                      if (snapshot.hasError) {
                                        return Text('Error: ${snapshot.error}');
                                      }

                                      if (!snapshot.hasData ||
                                          snapshot.data!.isEmpty) {
                                        return const Center(
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                                style: TextStyle(fontSize: 25),
                                                'No assessment results found.'),
                                          ),
                                        );
                                      }

                                      var kaya;

                                      var data = snapshot.data!['submittedAnswers'];
                                      var blobData = snapshot.data!['submittedAnswers'] as Uint8List;  // Ensure this is actually Uint8List
                                      convertBlobToMap(blobData).then((decodedMap) {
                                        if (decodedMap != null) {
                                          // Now you can use this map as needed
                                          var myMap = decodedMap;

                                          // setState(() {
                                          //   kaya = myMap;
                                          // });
                                          print("Assigned Map: $myMap");
                                        } else {
                                          print("Failed to decode data or data is null");
                                        }
                                      }).catchError((e) {
                                        print("Error decoding data: $e");
                                      });


                                      print(kaya);







                                      List<Widget> returnList = [
                                        Container(
                                          width: double
                                              .infinity,
                                          height: 50,
                                          decoration:
                                          BoxDecoration(
                                            color: FlutterFlowTheme
                                                .of(
                                                context)
                                                .primaryText,
                                            borderRadius:
                                            BorderRadius
                                                .circular(
                                                5),
                                          ),
                                          child: Padding(
                                            padding:
                                            EdgeInsetsDirectional
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
                                                  'Question Number',
                                                  style: FlutterFlowTheme
                                                      .of(
                                                      context)
                                                      .bodyMedium
                                                      .override(
                                                    fontFamily:
                                                    'Roboto',
                                                    color:
                                                    FlutterFlowTheme
                                                        .of(context)
                                                        .secondaryBackground,
                                                    letterSpacing:
                                                    0,
                                                  ),
                                                ),
                                                Text(
                                                  'Question',
                                                  style: FlutterFlowTheme
                                                      .of(
                                                      context)
                                                      .bodyMedium
                                                      .override(
                                                    fontFamily:
                                                    'Roboto',
                                                    color:
                                                    FlutterFlowTheme
                                                        .of(context)
                                                        .secondaryBackground,
                                                    letterSpacing:
                                                    0,
                                                  ),
                                                ),
                                                Text(
                                                  'Submitted Answer',
                                                  style: FlutterFlowTheme
                                                      .of(
                                                      context)
                                                      .bodyMedium
                                                      .override(
                                                    fontFamily:
                                                    'Roboto',
                                                    color:
                                                    FlutterFlowTheme
                                                        .of(context)
                                                        .secondaryBackground,
                                                    letterSpacing:
                                                    0,
                                                  ),
                                                ),
                                                Text(
                                                  'Correct Answer',
                                                  style: FlutterFlowTheme
                                                      .of(
                                                      context)
                                                      .bodyMedium
                                                      .override(
                                                    fontFamily:
                                                    'Roboto',
                                                    color:
                                                    FlutterFlowTheme
                                                        .of(context)
                                                        .secondaryBackground,
                                                    letterSpacing:
                                                    0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),

                                      ];

                                      Future<Map?> futureMap = convertBlobToMap(blobData);  // Ensure you define blobData properly



                                      List<SingleAssessmentRow> assessmentList =
                                          snapshotMain.data ?? [];


                                      var showAnswerCount = 0;

                                      returnList.addAll(
                                          assessmentList.map((item) {
                                            count += 1;
                                            return Container(
                                              width: double
                                                  .infinity,
                                              decoration:
                                              BoxDecoration(
                                                color: FlutterFlowTheme
                                                    .of(
                                                    context)
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
                                                      '${count}',
                                                      style: FlutterFlowTheme
                                                          .of(
                                                          context)
                                                          .bodyMedium
                                                          .override(
                                                        fontFamily:
                                                        'Roboto',
                                                        color:
                                                        FlutterFlowTheme
                                                            .of(context)
                                                            .primaryText,
                                                        letterSpacing:
                                                        0,
                                                      ),
                                                    ),
                                                    Flexible(
                                                      child: Container(
                                                        width: 200,
                                                        padding: EdgeInsets.all(8.0), // Optional for some visual spacing
                                                        child: Text(
                                                          '${item.questionText}',
                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                            fontFamily: 'Roboto',
                                                            color: FlutterFlowTheme.of(context).primaryText,
                                                            letterSpacing: 0,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    FutureBuilder<Map?>(
                                                      future: futureMap,  // Reference to your future
                                                      builder: (context, snapshot) {
                                                        if (snapshot.connectionState == ConnectionState.waiting) {
                                                          return Text(
                                                            'Loading...',
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                              fontFamily: 'Roboto',
                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                              letterSpacing: 0,
                                                            ),
                                                          );
                                                        } else if (snapshot.hasError) {
                                                          return Text(
                                                            'Error: ${snapshot.error}',
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                              fontFamily: 'Roboto',
                                                              color: Colors.red,
                                                              letterSpacing: 0,
                                                            ),
                                                          );
                                                        } else if (snapshot.hasData) {
                                                          // Assuming the data is a Map and you want to display a specific value
                                                          Map? dataMap = snapshot.data;

                                                          // showAnswerCount = showAnswerCount - 1;



                                                          print('Here');
                                                          print(dataMap);

                                                          // print(dataMap?.length);
                                                          Map displayText = dataMap?[showAnswerCount] ?? [] ;




                                                          var test = Text(
                                                            displayText['answer'] ?? '',
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                              fontFamily: 'Roboto',
                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                              letterSpacing: 0,
                                                            ),
                                                          );




                                                          showAnswerCount += 1;



                                                          return test;
                                                        } else {
                                                          return Text(
                                                            'No data available',
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                              fontFamily: 'Roboto',
                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                              letterSpacing: 0,
                                                            ),
                                                          );
                                                        }
                                                      },
                                                    ),
                                                    Flexible(
                                                      child: Container(
                                                        padding: EdgeInsets.all(8.0),  // Adds some padding around the text
                                                        child: Text(
                                                          '${item.correctAnswer}',
                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                            fontFamily: 'Roboto',
                                                            color: FlutterFlowTheme.of(context).primaryText,
                                                            letterSpacing: 0,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          }).toList());


                                      return Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            40, 10, 0, 0),
                                        child: Material(
                                          color: Colors.transparent,
                                          elevation: 0.5,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(12),
                                          ),
                                          child: Container(
                                            width: 900,
                                            decoration: BoxDecoration(
                                              color:
                                              FlutterFlowTheme
                                                  .of(context)
                                                  .secondaryBackground,
                                              borderRadius:
                                              BorderRadius.circular(12),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      20, 20, 0, 20),
                                                  child: Text(
                                                    '${Provider
                                                        .of<FFAppState>(
                                                        context, listen: false)
                                                        .gradeName}',
                                                    style: FlutterFlowTheme
                                                        .of(
                                                        context)
                                                        .bodyMedium
                                                        .override(
                                                      fontFamily: 'Roboto',
                                                      fontSize: 30,
                                                      letterSpacing: 0,
                                                      fontWeight:
                                                      FontWeight.w800,
                                                    ),
                                                  ),
                                                ),


                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(20, 5, 0, 5),
                                                  child: Text(
                                                    'You scored: ${snapshot
                                                        .data!['percentageScore']} % ',
                                                    style: FlutterFlowTheme
                                                        .of(
                                                        context)
                                                        .bodyMedium
                                                        .override(
                                                      fontFamily: 'Roboto',
                                                      fontSize: 30,
                                                      letterSpacing: 0,
                                                      fontWeight:
                                                      FontWeight.w800,
                                                    ),
                                                  ),
                                                ),
                                                Divider(
                                                  thickness: 1,
                                                  color: FlutterFlowTheme
                                                      .of(
                                                      context)
                                                      .secondaryText,
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 20, 0, 0),
                                                  child: Row(
                                                    mainAxisSize:
                                                    MainAxisSize.max,
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .center,
                                                    children: [
                                                      Container(
                                                        width: 800,
                                                        decoration:
                                                        BoxDecoration(
                                                          color: FlutterFlowTheme
                                                              .of(context)
                                                              .secondaryBackground,
                                                        ),
                                                        child: Column(
                                                          mainAxisSize:
                                                          MainAxisSize.max,
                                                          children: returnList,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ],
                            );
                          }),
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
