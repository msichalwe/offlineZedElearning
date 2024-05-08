import '/components/choose_profile_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_platform_windows/backend/sqlite/sqlite_manager.dart';
import 'onboarding_model.dart';
export 'onboarding_model.dart';

class OnboardingWidget extends StatefulWidget {
  const OnboardingWidget({super.key});

  @override
  State<OnboardingWidget> createState() => _OnboardingWidgetState();
}

class _OnboardingWidgetState extends State<OnboardingWidget> {
  late OnboardingModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    fetchGrade();
    fetchName();
    fetchAssessmentId();
    // fetchAllGradeAnswers();
    super.initState();
    _model = createModel(context, () => OnboardingModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }
  void fetchGrade() async {
    try {
  print(Provider.of<FFAppState>(context, listen: false).currentUserId);
      print('fetchGrade called');
      var result = await SQLiteManager.instance.getAssessmentGrade(
          assessmentId:9,
          userId: int.parse(Provider.of<FFAppState>(context, listen: false).currentUserId));

      for (var gradeRow in result) {
print('GradeRow: ${gradeRow.data['percentageScore'].toString()}');
      }
    } catch (e) {
      print('Error fetching grade: $e');
    }
  }
  // fetchGrade();
    void fetchAssessmentId() async {
    try {
  print(Provider.of<FFAppState>(context, listen: false).currentUserId);
      print('fetchGrade called');
      var result = await SQLiteManager.instance.getAssessmentGrade(
          assessmentId:9,
          userId: int.parse(Provider.of<FFAppState>(context, listen: false).currentUserId));

      result.forEach((gradeRow) {
        print('Assessment ID: ${gradeRow.data['assessmentId'].toString()}');
      });

    } catch (e) {
      print('Error fetching grade: $e');
    }
  }

  void fetchName() async{
try{
        print('fetchName called');

var resultA=await SQLiteManager.instance.getAssessmentName(
  assessmentId: 9,
  
  );
  for (var gradeRow in resultA) {
    print('Assessment Name: ${gradeRow.data['assessment_name'].toString()}');
  }
}catch(e){
  print('Error fetching Assessment Name: $e');




}


  }

  void fetchAllGradeAnswers() async {
    try {
      print('fetchAllGradeAnswers called');
      var result = await SQLiteManager.instance.getGradeAnswers(
          gradeId: 1,
       /*GOT**/   userId: 2);

      for (var gradeRow in result) {
        print('GradeAnswer: ${gradeRow.data['assessment_name'].toString()}');
      }
    } catch (e) {
      print('Error fetching grade: $e');
    }
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
        body: Container(
          decoration: const BoxDecoration(),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width * 0.5,
                height: 932.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    'assets/images/Screenshot_2024-04-08_at_12.21.48_PM.png',
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: MediaQuery.sizeOf(context).height * 1.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              
              Container(
                width: MediaQuery.sizeOf(context).width * 0.5,
                height: 932.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 210.0, 0.0, 0.0),
                      child: Text(
                        'WELCOME TO ZEDELEARNING \nOFFLINE 😁',
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Readex Pro',
                              fontSize: 30.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.normal,
                            ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Text(
                        'ZEDELEARNING OFFLINE offers a chance for students all accross Zambia \nto download install and use the application offline. Our aim is to provide a seamless \nand easy way fpr students to access schoool material any time and any where.',
                        textAlign: TextAlign.start,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Readex Pro',
                              fontSize: 18.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w300,
                            ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: const AlignmentDirectional(0.0, -1.0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 8.0, 0.0),
                          child: FFButtonWidget(
                            onPressed: () async {
                              await showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: const Color(0xD3FFFFFF),
                                context: context,
                                builder: (context) {
                                  return GestureDetector(
                                    onTap: () => _model
                                            .unfocusNode.canRequestFocus
                                        ? FocusScope.of(context)
                                            .requestFocus(_model.unfocusNode)
                                        : FocusScope.of(context).unfocus(),
                                    child: Padding(
                                      padding: MediaQuery.viewInsetsOf(context),
                                      child: SizedBox(
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                1.0,
                                        child: const ChooseProfileWidget(),
                                      ),
                                    ),
                                  );
                                },
                              ).then((value) => safeSetState(() {}));
                            },
                            text: 'Get Started',
                            options: FFButtonOptions(
                              width: 230.0,
                              height: 52.0,
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: Colors.black,
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyLarge
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    color: FlutterFlowTheme.of(context).info,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                              elevation: 0.0,
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).alternate,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
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
      ),
    );
  }
}
class GradeFetcher {
  final int assessmentId;
  final BuildContext context;

  GradeFetcher({required this.assessmentId, required this.context});

  void fetchGrade() async {
    try {
      print('fetchGrade called');
      var result = await SQLiteManager.instance.getAssessmentGrade(
          assessmentId: this.assessmentId,
          userId: int.parse(Provider.of<FFAppState>(context, listen: false).currentUserId));
      print('Result: $result');
    } catch (e) {
      print('Error fetching grade: $e');
    }
  }
}
class GradeFetcherWidget extends StatefulWidget {
  final int assessmentId;

  GradeFetcherWidget({required this.assessmentId});

  @override
  _GradeFetcherWidgetState createState() => _GradeFetcherWidgetState();
}

class _GradeFetcherWidgetState extends State<GradeFetcherWidget> {
  @override
  void initState() {
    super.initState();
    fetchGrade();
   
  }

  void fetchGrade() async {
    GradeFetcher gradeFetcher = GradeFetcher(assessmentId: widget.assessmentId, context: context);
    gradeFetcher.fetchGrade();
  }

  @override
  Widget build(BuildContext context) {
    // You can return an empty container if you don't want this widget to display anything
    return Container();
  }
}