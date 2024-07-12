import '/components/banner_widget.dart';
import '/components/nav_widget.dart';
import '/components/side_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'assessment_scores_model.dart';
import 'package:provider/provider.dart';
import 'package:school_platform_windows/backend/sqlite/sqlite_manager.dart';
export 'assessment_scores_model.dart';

class Score {
  final String subjectName;
  final String topicName;
  final String assessmentName;

  final int value;


  Score(this.subjectName, this.topicName, this.assessmentName,  this.value);


// List<String> gradeAnswers = [];
// List<String> gradeLesson = [];
// List<String> percentageScore = [];
// List<String> LessonName = [];
// List<String> assessmentName = [];
// List<String> GradeName=[];
// List<String> SubjectName=[];
// List<String> TopicName=[];



}



class AssessmentScoresWidget extends StatefulWidget {
  const AssessmentScoresWidget({super.key});

  @override
  State<AssessmentScoresWidget> createState() => _AssessmentScoresWidgetState();
}

class _AssessmentScoresWidgetState extends State<AssessmentScoresWidget> {
// void printAssessmentGrade() async {
//     var result = await SQLiteManager.instance.getAssessmentGrade(
//         assessmentId:1,
//         userId: int.parse(Provider.of<FFAppState>(context, listen: false).currentUserId)
//     );
//     print('Result: $result');
//   }

  List<Score> scores = []; // Initialize the scores list

  void fetchAllGradeAnswers() async {
    try {
      final String userId = Provider.of<FFAppState>(context, listen: false).currentUserId;
      final String gradeId = Provider.of<FFAppState>(context, listen: false).gradeId.toString();
      print('fetchAllGradeAnswers called New');
      var result = await SQLiteManager.instance.getGradeAnswers(
        gradeId: int.parse(gradeId),
        userId: int.parse(userId),
      );

      for (var gradeRow in result) {
        String subject = gradeRow.data['subject_name'].toString();
        String topic = gradeRow.data['topic_name'].toString();
        String category = gradeRow.data['assessment_name'].toString();
        int score = int.parse(gradeRow.data['percentageScore'].toString());

        Score newScore = Score(subject, topic, category, score);
        scores.add(newScore);
        print(newScore.subjectName);
      }
    } catch (e) {
      // Handle exceptions
      print(e);
    }
  }



  final int assessmentId = 1;
  late AssessmentScoresModel _model;
  // List<Score> scores = [
  //   Score('Physics','MECHANICS', 'Basic and Derived Quantities', 76),

  //   // Add more scores here
  // ];

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    fetchAllGradeAnswers();
    super.initState();

    _model = createModel(context, () => AssessmentScoresModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

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
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: SingleChildScrollView( // Added SingleChildScrollView
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                wrapWithModel(
                  model: _model.navModel,
                  updateCallback: () => setState(() {}),
                  child: const NavWidget(),
                ),
                wrapWithModel(
                  model: _model.bannerModel,
                  updateCallback: () => setState(() {}),
                  child: const BannerWidget(),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      wrapWithModel(
                        model: _model.sideModel,
                        updateCallback: () => setState(() {}),
                        child: const SideWidget(),
                      ),
                      SingleChildScrollView( // Added SingleChildScrollView
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  30.0, 0.0, 0.0, 0.0),
                              child: Container(
                                width: 1000.0,
                                height: 400.0,
                                decoration: const BoxDecoration(
                                  color: Color(0x00FFFFFF),
                                ),
                                child: Card(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  elevation: 1.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          'My Assessment Grades',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Readex Pro',
                                            fontSize: 35.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Divider(
                                        thickness: 0.5,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            10.0, 8.0, 0.0, 8.0),
                                        child: Container(
                                          width: 500.0,
                                          height: 50.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                          ),
                                          child: Padding(
                                            padding:
                                            const EdgeInsetsDirectional.fromSTEB(
                                                8.0, 0.0, 8.0, 0.0),
                                            child: TextFormField(
                                              controller: _model.textController,
                                              focusNode:
                                              _model.textFieldFocusNode,
                                              autofocus: true,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                labelText: 'Search',
                                                labelStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .override(
                                                  fontFamily:
                                                  'Readex Pro',
                                                  letterSpacing: 0.0,
                                                ),
                                                hintStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .override(
                                                  fontFamily:
                                                  'Readex Pro',
                                                  letterSpacing: 0.0,
                                                ),
                                                enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                        context)
                                                        .alternate,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                  BorderRadius.circular(8.0),
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                        context)
                                                        .secondaryText,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                  BorderRadius.circular(8.0),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                        context)
                                                        .error,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                  BorderRadius.circular(8.0),
                                                ),
                                                focusedErrorBorder:
                                                OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                        context)
                                                        .error,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                  BorderRadius.circular(8.0),
                                                ),
                                                suffixIcon: Icon(
                                                  Icons.search_sharp,
                                                  color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                                ),
                                              ),
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                fontFamily: 'Readex Pro',
                                                letterSpacing: 0.0,
                                              ),
                                              minLines: null,
                                              validator: _model
                                                  .textControllerValidator
                                                  .asValidator(context),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded( // Added Expanded
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional.fromSTEB(10.0, 8.0, 0.0, 8.0),
                                          child: DataTable(
                                            columns: const <DataColumn>[
                                              DataColumn(
                                                label: Text(
                                                  'Subject Name',
                                                  style: TextStyle(fontStyle: FontStyle.italic),
                                                ),
                                              ),
                                              DataColumn(
                                                label: Text(
                                                  'Topic Name',
                                                  style: TextStyle(fontStyle: FontStyle.italic),
                                                ),
                                              ),
                                              DataColumn(
                                                label: Text(
                                                  'Assessment Name',
                                                  style: TextStyle(fontStyle: FontStyle.italic),
                                                ),
                                              ),
                                              DataColumn(
                                                label: Text(
                                                  'Percentage Score',
                                                  style: TextStyle(fontStyle: FontStyle.italic),
                                                ),
                                              ),
                                            ],
                                            rows: scores.map<DataRow>((Score score) => DataRow(
                                              cells: <DataCell>[
                                                DataCell(Text(score.subjectName)),
                                                DataCell(Text(score.topicName)),
                                                DataCell(Text(score.assessmentName)),
                                                DataCell(Text(score.value.toString())),
                                              ],
                                            )).toList(),
                                          ),
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}