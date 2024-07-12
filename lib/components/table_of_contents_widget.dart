import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';

import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'table_of_contents_model.dart';
export 'table_of_contents_model.dart';

class TableOfContentsWidget extends StatefulWidget {
  const TableOfContentsWidget({
    super.key,
    required this.sylabasId,
  });

  final int? sylabasId;

  @override
  State<TableOfContentsWidget> createState() => _TableOfContentsWidgetState();
}

class _TableOfContentsWidgetState extends State<TableOfContentsWidget> {
  late TableOfContentsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TableOfContentsModel());

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
      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 35.0, 0.0, 0.0),
      child: FutureBuilder<List<GetTopicsInSubjectsFromSylabiRow>>(
        future: SQLiteManager.instance.getTopicsInSubjectsFromSylabi(
          syllabiId: widget.sylabasId,
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
          final containerGetTopicsInSubjectsFromSylabiRowList = snapshot.data!;
          return Container(
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).alternate,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 0.0, 0.0, 8.0),
                    child: FutureBuilder<List<GetSingleSyllabiRow>>(
                      future: SQLiteManager.instance.getSingleSyllabi(
                        syllabusId: widget.sylabasId,
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
                        final textGetSingleSyllabiRowList = snapshot.data!;
                        return Text(
                          '${valueOrDefault<String>(
                            textGetSingleSyllabiRowList.first.gradeName,
                            '${Provider.of<FFAppState>(context, listen: false).gradeName}',
                          )} ${textGetSingleSyllabiRowList.first.subjectName}',
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: 'Roboto',
                                color: FlutterFlowTheme.of(context).secondary,
                                fontSize: 20.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                              ),
                        );
                      },
                    ),
                  ),
                  Text(
                    'Table of Contents',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Roboto',
                          fontSize: 17.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(
                    width: 300.0,
                    child: Divider(
                      thickness: 0.5,
                      color: FlutterFlowTheme.of(context).secondaryText,
                    ),
                  ),
                  Builder(
                    builder: (context) {
                      final topics =
                          containerGetTopicsInSubjectsFromSylabiRowList
                              .toList();
                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: List.generate(topics.length, (topicsIndex) {
                          final topicsItem = topics[topicsIndex];
                          return Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                10.0, 10.0, 10.0, 10.0),
                            child: Container(
                              padding: EdgeInsets.only(left: 20, bottom: 10),
                              width: 350.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(0.0),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ' ${topicsItem.topicName}',
                                    // '${(topicsIndex + 1).toString()}. ${topicsItem.topicName}',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Roboto',
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 10.0, 0.0, 0.0),
                                    child: FutureBuilder<
                                        List<GetSubtopicsFromTopicIdRow>>(
                                      future: SQLiteManager.instance
                                          .getSubtopicsFromTopicId(
                                        topicId: topicsItem.topicId,
                                      ),
                                      builder: (context, snapshot) {

                                        if (!snapshot.hasData) {
                                          return Center(
                                            child: SizedBox(
                                              width: 50.0,
                                              height: 50.0,
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                        final columnGetSubtopicsFromTopicIdRowList =
                                            snapshot.data!;
                                        final newList = [
                                          {'name': 'Flutter Basics'},
                                          {'name': 'Installing Flutter'},
                                          {'name': 'Creating a Flutter Project'},
                                          {'name': 'Stateless Widgets'},
                                          {'name': 'Stateful Widgets'},
                                          {'name': 'Inherited Widgets'},
                                          {'name': 'Row and Column'},
                                          {'name': 'Stack and Align'},
                                          {'name': 'Container and Padding'},
                                        ];

                                        return Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: List.generate(columnGetSubtopicsFromTopicIdRowList.length, (columnIndex) {
                                            final columnGetSubtopicsFromTopicIdRow = columnGetSubtopicsFromTopicIdRowList[columnIndex];
                                            return Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                                                  child: Text(
                                                    '${(columnIndex + 1).toString()}. ${columnGetSubtopicsFromTopicIdRow.subtopicName}',
                                                    textAlign: TextAlign.start,
                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      fontFamily: 'Roboto',
                                                      color: FlutterFlowTheme.of(context).secondaryText,
                                                      letterSpacing: 0.0,
                                                    ),
                                                  ),
                                                ),
                                                // Sublist
                                                FutureBuilder<List<dynamic>>(
                                                  future: SQLiteManager.instance.getLessonsFromSubtopics(
                                                    subtopicId: columnGetSubtopicsFromTopicIdRow.subtopicId,
                                                  ), // Replace with your future function
                                                  builder: (BuildContext context,  snapshot) {
                                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                                      return Center(child: CircularProgressIndicator());
                                                    } else if (snapshot.hasError) {
                                                      return Center(child: Text('Error: ${snapshot.error}'));
                                                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                                      return Center(child: Text('No data available'));
                                                    } else {
                                                      final newList = snapshot.data!;
                                                      return Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: List.generate(newList.length, (newIndex) {
                                                          final newItem = newList[newIndex];
                                                          return Padding(
                                                            padding: const EdgeInsetsDirectional.fromSTEB(16.0, 2.0, 0.0, 0.0),
                                                            child: GestureDetector(
                                                              onTap: (){
                                                                context.pushNamed(
                                                                  'lesson',
                                                                  queryParameters: {
                                                                    'lessonId': serializeParam(
                                                                      valueOrDefault<int>(
                                                                        newItem.lessonId,
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
                                                              child: MouseRegion(
                                                                cursor: SystemMouseCursors.click,
                                                                child: AutoSizeText(
                                                                  '${newItem.lessonName}',
                                                                  textAlign: TextAlign.start,
                                                                  style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                    fontFamily: 'Roboto',
                                                                    color: Colors.blue[900],
                                                                    letterSpacing: 0.0,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        }),
                                                      );
                                                    }
                                                  },
                                                ),

                                              ],
                                            );
                                          }),
                                        );



                                      },
                                    ),
                                  ),
                                ],
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
          );
        },
      ),
    );
  }
}
