import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:school_platform_windows/backend/sqlite/sqlite_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../backend/offline_sqlite.dart';
import '/components/banner_widget.dart';
import '/components/nav_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'score_card_model.dart';
export 'score_card_model.dart';

class ScoreCardWidget extends StatefulWidget {
  const ScoreCardWidget({super.key});

  @override
  State<ScoreCardWidget> createState() => _ScoreCardWidgetState();
}

class _ScoreCardWidgetState extends State<ScoreCardWidget>
    with TickerProviderStateMixin {
  late ScoreCardModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final DBHelper dbHelper = DBHelper();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ScoreCardModel());

    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => setState(() {}));
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

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
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        body: SafeArea(
          top: true,
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
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment(0, 0),
                        child: TabBar(
                          labelColor: FlutterFlowTheme.of(context).primaryText,
                          unselectedLabelColor:
                              FlutterFlowTheme.of(context).secondaryText,
                          labelStyle:
                              FlutterFlowTheme.of(context).titleMedium.override(
                                    fontFamily: 'Roboto',
                                    letterSpacing: 0,
                                  ),
                          unselectedLabelStyle: TextStyle(),
                          indicatorColor: FlutterFlowTheme.of(context).primary,
                          padding: EdgeInsets.all(4),
                          tabs: const [
                            Tab(
                              text: 'Report Card',
                            ),
                          ],
                          controller: _model.tabBarController,
                          onTap: (i) async {
                            [() async {}, () async {}][i]();
                          },
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _model.tabBarController,
                          children: [
                            SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 500,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                    ),
                                    child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    15, 15, 0, 0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Report Card',
                                                  style:
                                                      FlutterFlowTheme.of(context)
                                                          .bodyLarge
                                                          .override(
                                                            fontFamily: 'Roboto',
                                                            fontSize: 30,
                                                            letterSpacing: 0,
                                                          ),
                                                ),
                                                Text(
                                                  'Lesson and Assessment Statistics',
                                                  style:
                                                      FlutterFlowTheme.of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily: 'Roboto',
                                                            letterSpacing: 0,
                                                          ),
                                                ),
                                                Container(
                                                  width: 700,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .alternate,
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Text(
                                                        'LESSONS & ASSESSMENT',
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .bodyMedium
                                                            .override(
                                                              fontFamily:
                                                                  'Roboto',
                                                              letterSpacing: 0,
                                                            ),
                                                      ),
                                                      Text(
                                                        'STATS',
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .bodyMedium
                                                            .override(
                                                              fontFamily:
                                                                  'Roboto',
                                                              letterSpacing: 0,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: 700,
                                                  height: 250,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      FutureBuilder(
                                                        future: SQLiteManager
                                                            .instance
                                                            .countLessons(),
                                                        // This should be your outer future
                                                        builder: (context,
                                                            outerSnapshot) {
                                                          if (outerSnapshot
                                                                  .connectionState ==
                                                              ConnectionState
                                                                  .waiting) {
                                                            return Center(
                                                                child:
                                                                    CircularProgressIndicator());
                                                          } else if (outerSnapshot
                                                              .hasError) {
                                                            return Center(
                                                                child: Text(
                                                                    'Outer Error: ${outerSnapshot.error}'));
                                                          } else {
                                                            // Place your original FutureBuilder here
                                                            return FutureBuilder(
                                                              future:
                                                                  getFullProgressLessonsCount(),
                                                              // Replace 'myFutureData' with your actual future variable
                                                              builder: (context,
                                                                  snapshot) {
                                                                if (snapshot
                                                                        .connectionState ==
                                                                    ConnectionState
                                                                        .waiting) {
                                                                  return Center(
                                                                      child:
                                                                          CircularProgressIndicator());
                                                                } else if (snapshot
                                                                    .hasError) {
                                                                  return Center(
                                                                      child: Text(
                                                                          'Error: ${snapshot.error}'));
                                                                } else {
                                                                  return Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            10,
                                                                            0,
                                                                            10),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceEvenly,
                                                                      children: [
                                                                        Text(
                                                                          'Lessons completed',
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: 'Roboto',
                                                                                letterSpacing: 0,
                                                                              ),
                                                                        ),
                                                                        Text(
                                                                          '${snapshot.data![FFAppState().currentUser.hashCode.toString()] ?? 0}/ ${outerSnapshot.data![0].total}',
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: 'Roboto',
                                                                                letterSpacing: 0,
                                                                              ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                }
                                                              },
                                                            );
                                                          }
                                                        },
                                                      ),
                                                      FutureBuilder(
                                                        future: SQLiteManager
                                                            .instance
                                                            .countAssessments(),
                                                        // Dummy future for example. Replace with actual future if needed.
                                                        builder:
                                                            (context, snapshot2) {
                                                          return Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        10,
                                                                        0,
                                                                        10),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                Text(
                                                                  'Assessments Taken',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        letterSpacing:
                                                                            0,
                                                                      ),
                                                                ),
                                                                FutureBuilder<
                                                                    int>(
                                                                  future: dbHelper.countUserAnswers(
                                                                      FFAppState()
                                                                          .currentUser
                                                                          .hashCode),
                                                                  builder: (context,
                                                                      snapshot) {
                                                                    if (snapshot
                                                                            .connectionState ==
                                                                        ConnectionState
                                                                            .waiting) {
                                                                      return Text(
                                                                        'Loading...',
                                                                        style: FlutterFlowTheme.of(
                                                                                context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily:
                                                                                  'Roboto',
                                                                              letterSpacing:
                                                                                  0,
                                                                            ),
                                                                      );
                                                                    } else if (snapshot
                                                                        .hasError) {
                                                                      return Text(
                                                                        'Error!',
                                                                        style: FlutterFlowTheme.of(
                                                                                context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily:
                                                                                  'Roboto',
                                                                              letterSpacing:
                                                                                  0,
                                                                            ),
                                                                      );
                                                                    } else {
                                                                      return Text(
                                                                        '${snapshot.data}/${snapshot2.data![0].total}',
                                                                        style: FlutterFlowTheme.of(
                                                                                context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily:
                                                                                  'Roboto',
                                                                              letterSpacing:
                                                                                  0,
                                                                            ),
                                                                      );
                                                                    }
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                      FutureBuilder(
                                                        future: dbHelper
                                                            .countUserAnswers(
                                                                FFAppState()
                                                                    .currentUser
                                                                    .hashCode),
                                                        // Dummy future for example. Replace with actual future if needed.
                                                        builder:
                                                            (context, snapshot2) {
                                                          return Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        10,
                                                                        0,
                                                                        10),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                Text(
                                                                  'Assessments Passed',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        letterSpacing:
                                                                            0,
                                                                      ),
                                                                ),
                                                                FutureBuilder<
                                                                    int>(
                                                                  future: dbHelper.countUserAnswersAbove50(
                                                                      FFAppState()
                                                                          .currentUser
                                                                          .hashCode),
                                                                  builder: (context,
                                                                      snapshot) {
                                                                    if (snapshot
                                                                            .connectionState ==
                                                                        ConnectionState
                                                                            .waiting) {
                                                                      return Text(
                                                                        'Loading...',
                                                                        style: FlutterFlowTheme.of(
                                                                                context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily:
                                                                                  'Robot',
                                                                              letterSpacing:
                                                                                  0,
                                                                            ),
                                                                      );
                                                                    } else if (snapshot
                                                                        .hasError) {
                                                                      return Text(
                                                                        'Error!',
                                                                        style: FlutterFlowTheme.of(
                                                                                context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily:
                                                                                  'Roboto',
                                                                              letterSpacing:
                                                                                  0,
                                                                            ),
                                                                      );
                                                                    } else {
                                                                      return Text(
                                                                        '${snapshot.data}/${snapshot2.data}',
                                                                        style: FlutterFlowTheme.of(
                                                                                context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily:
                                                                                  'Roboto',
                                                                              letterSpacing:
                                                                                  0,
                                                                            ),
                                                                      );
                                                                    }
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                0, 0, 80, 0),
                                            child: Material(
                                              color: Colors.transparent,
                                              elevation: 2,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: Container(
                                                width: 350,
                                                height: 400,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: PieChart(
                                                  PieChartData(
                                                    borderData: FlBorderData(
                                                      show: false,
                                                    ),
                                                    sectionsSpace: 0,
                                                    centerSpaceRadius: 70,
                                                    sections: [
                                                      PieChartSectionData(
                                                        color: Colors.blue,
                                                        value: 40,
                                                        title: 'Chemistry',
                                                        radius: 50,
                                                      ),
                                                      PieChartSectionData(
                                                        color: Colors.red,
                                                        value: 30,
                                                        title: 'Physics',
                                                        radius: 50,
                                                      ),
                                                      PieChartSectionData(
                                                        color: Colors.green,
                                                        value: 15,
                                                        title: 'English',
                                                        radius: 50,
                                                      ),
                                                      PieChartSectionData(
                                                        color: Colors.yellow,
                                                        value: 15,
                                                        title: 'Biology',
                                                        radius: 50,
                                                      ),
                                                      PieChartSectionData(
                                                        color: Colors.white,
                                                        value: 15,
                                                        title: 'Mathematics',
                                                        radius: 50,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ]),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Center(
                                      child: FutureBuilder(
                                        future: SQLiteManager.instance.getScoresheetData(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            return CircularProgressIndicator();
                                          } else if (snapshot.hasError) {
                                            return Text('Error: ${snapshot.error}');
                                          } else {
                                            // Check if data is fetched
                                            if (snapshot.hasData) {
                                              return Table(
                                                children: [
                                                  TableRow(
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey[100],
                                                        borderRadius: BorderRadius.all(Radius.circular(10))
                                                    ),
                                                    children: const [
                                                      Padding(
                                                        padding: EdgeInsets.all(8.0),
                                                        child: Text('Subject'),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.all(8.0),
                                                        child: Text('Topic'),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.all(8.0),
                                                        child: Text('Assessment'),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.all(8.0),
                                                        child: Text('Score'),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.all(8.0),
                                                        child: Text('Average Score'),
                                                      ),
                                                    ],
                                                  ),
                                                  // Generate table rows from fetched data
                                                  ...snapshot.data!.map((items) {
                                                    return  TableRow(
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.all(8.0),
                                                          child: Text('${items.subject_name}'),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.all(8.0),
                                                          child: Text('${items.topic_name}'),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.all(8.0),
                                                          child: Text('${items.assessment_name}'),
                                                        ),
                                                        FutureBuilder(
                                                          future: dbHelper.fetchResults(FFAppState().currentUser.hashCode, items.assessment_id as int),
                                                          builder: (context, snapshot2) {

                                                            if (snapshot2.connectionState == ConnectionState.waiting) {
                                                              return CircularProgressIndicator();
                                                            }
                                                            if (snapshot2.hasError) {
                                                              return Text('Error: ${snapshot2.error}');
                                                            }

                                                            return Padding(
                                                              padding: EdgeInsets.all(8.0),
                                                              child: Text('${snapshot2.data != null ? snapshot2.data!['percentageScore'] : 0}'),
                                                            );
                                                          }
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.all(8.0),
                                                          child: Text('${items.Average_Score}'),
                                                        ),
                                                      ],
                                                    );
                                                  }).toList(),
                                                ],
                                              );
                                            } else {
                                              // Handle the case where there is no data yet (potentially unnecessary)
                                              return Text("No data available");
                                            }
                                          }
                                        },
                                      ),
                                    ),
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
            ],
          ),
        ),
      ),
    );
  }
}
