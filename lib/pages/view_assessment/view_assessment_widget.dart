import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:school_platform_windows/backend/sqlite/sqlite_manager.dart';
import 'package:school_platform_windows/index.dart';

import '/components/banner_widget.dart';
import '/components/footer_widget.dart';
import '/components/nav_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:html/parser.dart';

import 'view_assessment_model.dart';
export 'view_assessment_model.dart';

class ViewAssessmentWidget extends StatefulWidget {
  final int? assessmentId;
  const ViewAssessmentWidget({super.key, this.assessmentId});

  @override
  State<ViewAssessmentWidget> createState() => _ViewAssessmentWidgetState();
}

class _ViewAssessmentWidgetState extends State<ViewAssessmentWidget> {
  late ViewAssessmentModel _model;
  late int _currentQuestionIndex = 0; // Initialize current question index
  Map? selectedAnswers = {}; // List to store selected answers

  TextEditingController _textController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ViewAssessmentModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  String? stripHtmlTags(String htmlString) {
    return parse(htmlString).text;
  }

  void _showModal(BuildContext context, percentage, text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            width: 500,
            height: 500,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Assessment Results',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20.0),
                const Visibility(
                  visible:
                      false, // Set to true to display the Fill In The Blanks score
                  child: Text(
                    'Your Fill In The Blanks score is: 0.00%',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                Text(
                  'Your Overall score is: $percentage%',
                  style: const TextStyle(fontSize: 16.0),
                ),
                Text(
                  text,
                  style: const TextStyle(fontSize: 16.0),
                ),
                const Text(
                  'Credit (6)(C)',
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 20.0),
                FFButtonWidget(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const AssessmentScoresWidget()));
                  },
                  text: 'View Answers',
                  options: FFButtonOptions(
                    width: 300,
                    height: 50,
                    padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                    iconPadding:
                        const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    color: const Color(0xff1BB174),
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'Readex Pro',
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          fontSize: 19,
                          letterSpacing: 0,
                        ),
                    elevation: 0,
                    borderSide: const BorderSide(
                      color: Color(0xff1BB174),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(height: 10.0),
                FFButtonWidget(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  text: 'Retake Assessments',
                  options: FFButtonOptions(
                    width: 300,
                    height: 50,
                    padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                    iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    color: const Color(0xff1992A9),
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'Readex Pro',
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          fontSize: 19,
                          letterSpacing: 0,
                        ),
                    elevation: 0,
                    borderSide: const BorderSide(
                      color: Color(0xff1992A9),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
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
          child: SingleChildScrollView(
            child: FutureBuilder<List<SingleAssessmentRow>>(
              future: SQLiteManager.instance
                  .getAssessment(assessmentId: widget.assessmentId),
              builder:
                  (context, AsyncSnapshot<List<SingleAssessmentRow>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  List<SingleAssessmentRow> assessmentList =
                      snapshot.data ?? [];

                  return Column(
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
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FFButtonWidget(
                              onPressed: () async {
                                context.safePop();
                              },
                              text: 'Back',
                              icon: const Icon(
                                Icons.arrow_back,
                                size: 15.0,
                              ),
                              options: FFButtonOptions(
                                width: 250.0,
                                height: 40.0,
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    24.0, 0.0, 24.0, 0.0),
                                iconPadding:
                                    const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                color: const Color(0xFF066AC9),
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      color: Colors.white,
                                      letterSpacing: 0.0,
                                    ),
                                elevation: 0.0,
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(40, 20, 40, 40),
                        child: Material(
                          elevation: 0,
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Material(
                                  color: Colors.transparent,
                                  elevation: 0,
                                  child: Container(
                                    width: double.infinity,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          50, 30, 0, 30),
                                      child: Text(
                                        '${Provider.of<FFAppState>(context, listen: false).gradeName}',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              fontSize: 40,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.w800,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                                Material(
                                  elevation: 1,
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 1200,
                                          child: Divider(
                                            height: 50,
                                            thickness: 1,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                          ),
                                        ),
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: List.generate(
                                              assessmentList.length,
                                              (index) {
                                                SingleAssessmentRow assessment =
                                                    assessmentList[index];

                                                // Here you can use the assessment data to customize each row.
                                                // For simplicity, I'm just using the index as the content of the row.
                                                return Padding(
                                                  padding: EdgeInsets.all(15),
                                                  child: Text(
                                                    '${index + 1}',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          color:
                                                              _currentQuestionIndex ==
                                                                      index
                                                                  ? Colors.blue
                                                                  : const Color(
                                                                      0xFFE72929),
                                                          fontSize:
                                                              _currentQuestionIndex ==
                                                                      index
                                                                  ? 25
                                                                  : 15,
                                                          letterSpacing: 0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Html(
                                    data: assessmentList[_currentQuestionIndex]
                                        .questionText,
                                    style: {
                                      "p": Style(
                                          fontFamily: 'Readex Pro',
                                          color: Colors.black87,
                                          fontSize: FontSize(30),
                                          fontWeight: FontWeight.bold),
                                      "span": Style(
                                        fontFamily: 'Readex Pro',
                                        color: Colors.black87,
                                        fontSize: FontSize(30),
                                      )
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 1350,
                                  child: Divider(
                                    thickness: 1,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                  ),
                                ),

                                // Question Buttons
                                if (assessmentList[_currentQuestionIndex]
                                        .questionType ==
                                    'trueorfalse')
                                  Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(10),
                                        child: FFButtonWidget(
                                          onPressed: () {
                                            setState(() {
                                              selectedAnswers?[
                                                  _currentQuestionIndex] = {
                                                'question': assessmentList[
                                                        _currentQuestionIndex]
                                                    .questionText,
                                                'answer': 'True'
                                              };
                                            });
                                          },
                                          text: 'True',
                                          options: FFButtonOptions(
                                            width: double.infinity,
                                            height: 50,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    24, 0, 24, 0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 0, 0),
                                            color: selectedAnswers![
                                                            _currentQuestionIndex]
                                                        ?['answer'] ==
                                                    'True'
                                                ? Colors.blue
                                                : Color(0x007713E0),
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'Readex Pro',
                                                      color: Colors.black87,
                                                      fontSize: 19,
                                                      letterSpacing: 0,
                                                    ),
                                            elevation: 0,
                                            borderSide: BorderSide(
                                              color: Color(0xFF008DDA),
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(10),
                                        child: FFButtonWidget(
                                          onPressed: () {
                                            setState(() {
                                              selectedAnswers?[
                                                  _currentQuestionIndex] = {
                                                'question': assessmentList[
                                                        _currentQuestionIndex]
                                                    .questionText,
                                                'answer': 'False'
                                              };
                                            });
                                          },
                                          text: 'False',
                                          options: FFButtonOptions(
                                            width: double.infinity,
                                            height: 50,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    24, 0, 24, 0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 0, 0),
                                            color: selectedAnswers![
                                                            _currentQuestionIndex]
                                                        ?['answer'] ==
                                                    'False'
                                                ? Colors.blue
                                                : Color(0x007713E0),
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'Readex Pro',
                                                      color: Colors.black87,
                                                      fontSize: 19,
                                                      letterSpacing: 0,
                                                    ),
                                            elevation: 0,
                                            borderSide: BorderSide(
                                              color: Color(0xFF008DDA),
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                /////// True or false Above

                                if (assessmentList[_currentQuestionIndex]
                                        .questionType ==
                                    'shortanswer')
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: TextField(
                                          decoration: const InputDecoration(
                                            hintText:
                                                'Your Answer', // Placeholder text
                                            labelText:
                                                'Your Answer', // Label text
                                            border:
                                                OutlineInputBorder(), // Border outline
                                          ),
                                          controller: _textController,
                                        ),
                                      ),
                                    ],
                                  ),

                                if (assessmentList[_currentQuestionIndex]
                                        .questionType ==
                                    'multiplechoice')
                                  ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: jsonDecode(assessmentList[
                                                _currentQuestionIndex]
                                            .options as String)
                                        .cast<String>()
                                        .length,
                                    itemBuilder: (context, index) {
                                      final buttonText = jsonDecode(
                                              assessmentList[
                                                      _currentQuestionIndex]
                                                  .options as String)
                                          .cast<String>()[index];

                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selectedAnswers?[
                                                  _currentQuestionIndex] = {
                                                'question': assessmentList[
                                                        _currentQuestionIndex]
                                                    .questionText,
                                                'answer': buttonText
                                              };
                                            });
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            height: 50,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    24, 0, 24, 0),
                                            decoration: BoxDecoration(
                                              color: selectedAnswers![
                                                              _currentQuestionIndex]
                                                          ?['answer'] ==
                                                      buttonText
                                                  ? Colors.blue
                                                  : Color(0x007713E0),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                color: Color(0xFF008DDA),
                                                width: 1,
                                              ),
                                            ),
                                            child: Center(
                                              child: Html(
                                                  data: buttonText,
                                                  style: {
                                                    "p": Style(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        color: Colors.black87,
                                                        fontSize: FontSize(19),
                                                        textAlign:
                                                            TextAlign.center),
                                                    "span": Style(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        color: Colors.black87,
                                                        fontSize: FontSize(19),
                                                        textAlign:
                                                            TextAlign.center)
                                                  }),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                // Question Buttons

                                if (assessmentList[_currentQuestionIndex]
                                        .questionType ==
                                    'multiplechoice')
                                  ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: jsonDecode(assessmentList[
                                                _currentQuestionIndex]
                                            .options as String)
                                        .cast<String>()
                                        .length,
                                    itemBuilder: (context, index) {
                                      final buttonText = jsonDecode(
                                              assessmentList[
                                                      _currentQuestionIndex]
                                                  .options as String)
                                          .cast<String>()[index];

                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selectedAnswers?[
                                                  _currentQuestionIndex] = {
                                                'question': assessmentList[
                                                        _currentQuestionIndex]
                                                    .questionText,
                                                'answer': buttonText
                                              };
                                            });
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            height: 50,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    24, 0, 24, 0),
                                            decoration: BoxDecoration(
                                              color: selectedAnswers![
                                                              _currentQuestionIndex]
                                                          ?['answer'] ==
                                                      buttonText
                                                  ? Colors.blue
                                                  : Color(0x007713E0),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                color: Color(0xFF008DDA),
                                                width: 1,
                                              ),
                                            ),
                                            child: Center(
                                              child: Html(
                                                data: buttonText,
                                                style: {
                                                  "p": Style(
                                                      fontFamily: 'Readex Pro',
                                                      color: Colors.black87,
                                                      fontSize: FontSize(19),
                                                      textAlign:
                                                          TextAlign.center),
                                                  "span": Style(
                                                      fontFamily: 'Readex Pro',
                                                      color: Colors.black87,
                                                      fontSize: FontSize(19),
                                                      textAlign:
                                                          TextAlign.center)
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),

                                _currentQuestionIndex ==
                                        assessmentList.length - 1
                                    ? Padding(
                                        padding: EdgeInsets.all(10),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            if (assessmentList[
                                                        _currentQuestionIndex]
                                                    .questionType ==
                                                'shortanswer') {
                                              selectedAnswers?[
                                                  _currentQuestionIndex] = {
                                                'question': assessmentList[
                                                        _currentQuestionIndex]
                                                    .questionText,
                                                'answer': _textController.text
                                              };
                                            }
                                            print(selectedAnswers);

                                            double percentage = 0;
                                            var correctAnswers = 0;
                                            for (int i = 0;
                                                i < selectedAnswers!.length;
                                                i++) {
                                              if (assessmentList[i]
                                                      .correctAnswer ==
                                                  selectedAnswers?[i]?['answer']
                                                      .toString()
                                                      .toLowerCase())
                                                correctAnswers++;
                                            }

                                            percentage = correctAnswers /
                                                assessmentList.length *
                                                100;

                                            final user =
                                                Provider.of<FFAppState>(context,
                                                        listen: false)
                                                    .currentUserId;

                                            await SQLiteManager.instance
                                                .createGrade(
                                              user_id: int.parse(user),
                                              assessmentId: widget.assessmentId,
                                              percentageScore: percentage,
                                              submittedAnswers: jsonEncode(
                                                stripHtmlTags(
                                                    selectedAnswers.toString()),
                                              ),
                                            );

                                            _showModal(context, percentage,
                                                '$correctAnswers/${assessmentList.length}');
                                          },
                                          text: 'View Result',
                                          options: FFButtonOptions(
                                            width: 300,
                                            height: 50,
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(24, 0, 24, 0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 0, 0),
                                            color: const Color(0xff1BB174),
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'Readex Pro',
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                      fontSize: 19,
                                                      letterSpacing: 0,
                                                    ),
                                            elevation: 0,
                                            borderSide: BorderSide(
                                              color: const Color(0xff1BB174),
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      )
                                    : Padding(
                                        padding: EdgeInsets.all(15),
                                        child: FFButtonWidget(
                                          onPressed: () {
                                            setState(() {
                                              _currentQuestionIndex++;
                                              _currentQuestionIndex %=
                                                  assessmentList.length;

                                              if (assessmentList[
                                                          _currentQuestionIndex]
                                                      .questionType ==
                                                  'shortanswer') {
                                                selectedAnswers?[
                                                    _currentQuestionIndex] = {
                                                  'question': assessmentList[
                                                          _currentQuestionIndex]
                                                      .questionText,
                                                  'answer': _textController.text
                                                };

                                                _textController.text = '';
                                              }
                                            });
                                          },
                                          text: 'Next Question',
                                          options: FFButtonOptions(
                                            width: 300,
                                            height: 50,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    24, 0, 24, 0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 0, 0),
                                            color: Color(0xFF008DDA),
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'Readex Pro',
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                      fontSize: 19,
                                                      letterSpacing: 0,
                                                    ),
                                            elevation: 0,
                                            borderSide: BorderSide(
                                              color: Color(0xFF008DDA),
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                _currentQuestionIndex == 0
                                    ? const SizedBox(
                                        height: 0,
                                      )
                                    : Padding(
                                        padding: EdgeInsets.all(15),
                                        child: FFButtonWidget(
                                          onPressed: () {
                                            setState(() {
                                              _currentQuestionIndex--;
                                              _currentQuestionIndex %=
                                                  assessmentList.length;
                                            });
                                          },
                                          text: 'Previous Question',
                                          options: FFButtonOptions(
                                            width: 300,
                                            height: 50,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    24, 0, 24, 0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 0, 0),
                                            color: Color(0xFF008DDA),
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'Readex Pro',
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                      fontSize: 19,
                                                      letterSpacing: 0,
                                                    ),
                                            elevation: 0,
                                            borderSide: BorderSide(
                                              color: Color(0xFF008DDA),
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      wrapWithModel(
                        model: _model.footerModel,
                        updateCallback: () => setState(() {}),
                        child: FooterWidget(),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
