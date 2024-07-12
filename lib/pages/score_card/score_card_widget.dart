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
                        alignment: const Alignment(0, 0),
                        child: TabBar(
                          labelColor: FlutterFlowTheme.of(context).primaryText,
                          unselectedLabelColor:
                              FlutterFlowTheme.of(context).secondaryText,
                          labelStyle:
                              FlutterFlowTheme.of(context).titleMedium.override(
                                    fontFamily: 'Roboto',
                                    letterSpacing: 0,
                                  ),
                          unselectedLabelStyle: const TextStyle(),
                          indicatorColor: Colors.blue[800],
                          padding: const EdgeInsets.all(4),
                          tabs: const [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Tab(
                                text: 'Report Card',
                              ),
                            ),
                          ],
                          controller: _model.tabBarController,
                          onTap: (i) async {
                            [() async {}, () async {}][i]();
                          },
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20 ),
                          child: Container(
                            decoration:  BoxDecoration(
                              border: Border(
                                left: BorderSide(color: Colors.grey[300] as Color),
                                right: BorderSide(color: Colors.grey[300] as Color),
                                bottom: BorderSide(color: Colors.grey[300] as Color),
                              ),
                            ),
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
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Report Card',
                                                      style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                        fontFamily: 'Roboto',
                                                        fontSize: 30,
                                                        letterSpacing: 0,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Lesson and Assessment Statistics',
                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                        fontFamily: 'Roboto',
                                                        letterSpacing: 0,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                                      child: Container(

                                                        width: 700,
                                                        decoration: BoxDecoration(
                                                          color: FlutterFlowTheme.of(context).alternate,
                                                          borderRadius: BorderRadius.circular(10),
                                                        ),
                                                        child: Table(
                                                          columnWidths: {
                                                            0: FlexColumnWidth(3),
                                                            1: FlexColumnWidth(1),
                                                          },
                                                          children: [
                                                            TableRow(
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsets.all(8.0),
                                                                  child: Text(
                                                                    'LESSONS & ASSESSMENT',
                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                      fontFamily: 'Roboto',
                                                                      letterSpacing: 0,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets.all(8.0),
                                                                  child: Text(
                                                                    'STATS',
                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                      fontFamily: 'Roboto',
                                                                      letterSpacing: 0,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 700,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme.of(context).secondaryBackground,
                                                      ),
                                                      child: FutureBuilder(
                                                        future: SQLiteManager.instance.countLessons(),
                                                        builder: (context, outerSnapshot) {
                                                          if (outerSnapshot.connectionState == ConnectionState.waiting) {
                                                            return Center(child: CircularProgressIndicator());
                                                          } else if (outerSnapshot.hasError) {
                                                            return Center(child: Text('Outer Error: ${outerSnapshot.error}'));
                                                          } else {
                                                            return FutureBuilder(
                                                              future: getFullProgressLessonsCount(),
                                                              builder: (context, snapshot) {
                                                                if (snapshot.connectionState == ConnectionState.waiting) {
                                                                  return Center(child: CircularProgressIndicator());
                                                                } else if (snapshot.hasError) {
                                                                  return Center(child: Text('Error: ${snapshot.error}'));
                                                                } else {
                                                                  return Table(
                                                                    columnWidths: {
                                                                      0: FlexColumnWidth(3),
                                                                      1: FlexColumnWidth(1),
                                                                    },
                                                                    children: [
                                                                      TableRow(
                                                                        children: [
                                                                          Padding(
                                                                            padding: EdgeInsets.all(8.0),
                                                                            child: Text(
                                                                              'Lessons completed',
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                fontFamily: 'Roboto',
                                                                                letterSpacing: 0,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsets.all(8.0),
                                                                            child: Text(
                                                                              '${snapshot.data![FFAppState().currentUser.hashCode.toString()] ?? 0}/ ${outerSnapshot.data![0].total}',
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                fontFamily: 'Roboto',
                                                                                letterSpacing: 0,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      TableRow(
                                                                        children: [
                                                                          Padding(
                                                                            padding: EdgeInsets.all(8.0),
                                                                            child: Text(
                                                                              'Assessments Taken',
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                fontFamily: 'Roboto',
                                                                                letterSpacing: 0,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          FutureBuilder<int>(
                                                                            future: dbHelper.countUserAnswers(FFAppState().currentUser.hashCode),
                                                                            builder: (context, snapshot) {
                                                                              if (snapshot.connectionState == ConnectionState.waiting) {
                                                                                return Padding(
                                                                                  padding: EdgeInsets.all(8.0),
                                                                                  child: Text(
                                                                                    'Loading...',
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      fontFamily: 'Roboto',
                                                                                      letterSpacing: 0,
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              } else if (snapshot.hasError) {
                                                                                return Padding(
                                                                                  padding: EdgeInsets.all(8.0),
                                                                                  child: Text(
                                                                                    'Error!',
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      fontFamily: 'Roboto',
                                                                                      letterSpacing: 0,
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              } else {
                                                                                return Padding(
                                                                                  padding: EdgeInsets.all(8.0),
                                                                                  child: Text(
                                                                                    '${snapshot.data}/${outerSnapshot.data![0].total}',
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      fontFamily: 'Roboto',
                                                                                      letterSpacing: 0,
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              }
                                                                            },
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      TableRow(
                                                                        children: [
                                                                          Padding(
                                                                            padding: EdgeInsets.all(8.0),
                                                                            child: Text(
                                                                              'Assessments Passed',
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                fontFamily: 'Roboto',
                                                                                letterSpacing: 0,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          FutureBuilder<int>(
                                                                            future: dbHelper.countUserAnswersAbove50(FFAppState().currentUser.hashCode),
                                                                            builder: (context, snapshot) {
                                                                              if (snapshot.connectionState == ConnectionState.waiting) {
                                                                                return Padding(
                                                                                  padding: EdgeInsets.all(8.0),
                                                                                  child: Text(
                                                                                    'Loading...',
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      fontFamily: 'Roboto',
                                                                                      letterSpacing: 0,
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              } else if (snapshot.hasError) {
                                                                                return Padding(
                                                                                  padding: EdgeInsets.all(8.0),
                                                                                  child: Text(
                                                                                    'Error!',
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      fontFamily: 'Roboto',
                                                                                      letterSpacing: 0,
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              } else {
                                                                                return Padding(
                                                                                  padding: EdgeInsets.all(8.0),
                                                                                  child: Text(
                                                                                    '${snapshot.data}/${outerSnapshot.data![0].total}',
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      fontFamily: 'Roboto',
                                                                                      letterSpacing: 0,
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              }
                                                                            },
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  );
                                                                }
                                                              },
                                                            );
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                              ),
                                              AnimatedCard()
                                            ]),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Center(
                                          child: FutureBuilder(
                                            future: SQLiteManager.instance
                                                .getScoresheetData(),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return CircularProgressIndicator();
                                              } else if (snapshot.hasError) {
                                                return Text(
                                                    'Error: ${snapshot.error}');
                                              } else {
                                                // Check if data is fetched
                                                if (snapshot.hasData) {
                                                  return Table(
                                                    children: [
                                                      TableRow(
                                                        decoration: BoxDecoration(
                                                            color: Colors.grey[100],
                                                            borderRadius:
                                                                const BorderRadius.all(
                                                                    Radius.circular(
                                                                        10))),
                                                        children: const [
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.all(8.0),
                                                            child: Text('Subject'),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.all(8.0),
                                                            child: Text('Topic'),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.all(8.0),
                                                            child:
                                                                Text('Assessment'),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.all(8.0),
                                                            child: Text('Score'),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.all(8.0),
                                                            child: Text(
                                                                'Average Score'),
                                                          ),
                                                        ],
                                                      ),
                                                      // Generate table rows from fetched data
                                                      ...snapshot.data!
                                                          .map((items) {
                                                        return TableRow(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets.all(
                                                                      8.0),
                                                              child: Text(
                                                                  '${items.subject_name}'),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets.all(
                                                                      8.0),
                                                              child: Text(
                                                                  '${items.topic_name}'),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets.all(
                                                                      8.0),
                                                              child: Text(
                                                                  '${items.assessment_name}'),
                                                            ),
                                                            FutureBuilder(
                                                                future: dbHelper.fetchResults(
                                                                    FFAppState()
                                                                        .currentUser
                                                                        .hashCode,
                                                                    items.assessment_id
                                                                        as int),
                                                                builder: (context,
                                                                    snapshot2) {
                                                                  if (snapshot2
                                                                          .connectionState ==
                                                                      ConnectionState
                                                                          .waiting) {
                                                                    return CircularProgressIndicator();
                                                                  }
                                                                  if (snapshot2
                                                                      .hasError) {
                                                                    return Text(
                                                                        'Error: ${snapshot2.error}');
                                                                  }

                                                                  return Padding(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(
                                                                                8.0),
                                                                    child: Text(
                                                                        '${snapshot2.data != null ? snapshot2.data!['percentageScore'].toStringAsFixed(2) : '0.00'}'
                                                                    ),
                                                                  );
                                                                }),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets.all(
                                                                      8.0),
                                                              child: Text(
                                                                  items.Average_Score?.toStringAsFixed(2) ?? '0.00'),
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
class AnimatedCard extends StatefulWidget {
  @override
  _AnimatedCardState createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard> {
  double _opacity = 0.0;
  final DBHelper dbHelper = DBHelper();

  @override
  void initState() {
    super.initState();
    // Start the animation when the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _opacity = 1.0;
      });
    });
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

  Future<List<PieChartSectionData>> fetchPieChartData() async {
    final fullProgressCount = await getFullProgressLessonsCount();
    final totalLessons = await SQLiteManager.instance.countLessons();
    final lessonsCompleted = fullProgressCount[FFAppState().currentUser.hashCode.toString()] ?? 0;
    final assessmentsTaken = await dbHelper.countUserAnswers(FFAppState().currentUser.hashCode);
    final assessmentsPassed = await dbHelper.countUserAnswersAbove50(FFAppState().currentUser.hashCode);

    final total = totalLessons.isNotEmpty ? totalLessons[0].total : 1; // Assuming total lessons is stored this way

    return [
      PieChartSectionData(
        color: Colors.blue,
        value: (lessonsCompleted / total!) * 100,
        title: '${(lessonsCompleted / total * 100).toStringAsFixed(1)}%',
        radius: 120,
        titleStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        showTitle: true,
        badgeWidget: Tooltip(
          message: 'Lessons Completed',
          child: SizedBox(
            width: 100,
            height: 100,
          ),
        ),
        badgePositionPercentageOffset: 0.98,
      ),
      PieChartSectionData(
        color: Colors.red,
        value: (assessmentsTaken / total) * 100,
        title: '${(assessmentsTaken / total * 100).toStringAsFixed(1)}%',
        radius: 120,
        titleStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        showTitle: true,
        badgeWidget: const Tooltip(
          message: 'Assessments Taken',
          child: SizedBox(
            width: 100,
            height: 100,
          ),
        ),
        badgePositionPercentageOffset: 0.98,
      ),
      PieChartSectionData(
        color: Colors.green,
        value: (assessmentsPassed / total) * 100,
        title: '${(assessmentsPassed / total * 100).toStringAsFixed(1)}%',
        radius: 120,
        titleStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        showTitle: true,
        badgeWidget: Tooltip(
          message: 'Assessments Passed',
          child: SizedBox(
            width: 100,
            height: 100,
          ),
        ),
        badgePositionPercentageOffset: 0.98,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Progress Summary',
            style: TextStyle(
              fontSize: 25,
              fontFamily: 'Roboto',
              color: FlutterFlowTheme.of(context).primaryText,
            ),
          ),
          SizedBox(height: 5),
          AnimatedOpacity(
            opacity: _opacity,
            duration: Duration(seconds: 1),
            curve: Curves.easeInOut,
            child: Material(
              color: Colors.transparent,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                width: 400, // Adjust width as needed
                height: 430, // Adjust height as needed
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: FutureBuilder<List<PieChartSectionData>>(
                  future: fetchPieChartData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      return PieChart(
                        PieChartData(
                          borderData: FlBorderData(
                            show: false,
                          ),
                          sectionsSpace: 0,
                          centerSpaceRadius: 0,
                          sections: snapshot.data!,
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

