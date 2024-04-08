import '/backend/sqlite/sqlite_manager.dart';
import '/components/footer_widget.dart';
import '/components/header_nav_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'home_primary_model.dart';
export 'home_primary_model.dart';

class HomePrimaryWidget extends StatefulWidget {
  const HomePrimaryWidget({super.key});

  @override
  State<HomePrimaryWidget> createState() => _HomePrimaryWidgetState();
}

class _HomePrimaryWidgetState extends State<HomePrimaryWidget> {
  late HomePrimaryModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePrimaryModel());

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
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 80.0, 0.0, 0.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'assets/images/Screenshot_2024-03-26_at_12.55.59_PM.png',
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            'Pick a grade ☝️',
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
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              20.0, 0.0, 8.0, 8.0),
                          child: Text(
                            'Pick a grade below to view its content, pretty easily actually.',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 50.0, 0.0, 200.0),
                          child: FutureBuilder<List<GetAllGradesRow>>(
                            future: SQLiteManager.instance.getAllGrades(),
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
                              final rowGetAllGradesRowList = snapshot.data!;
                              return Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: List.generate(
                                    rowGetAllGradesRowList.length, (rowIndex) {
                                  final rowGetAllGradesRow =
                                      rowGetAllGradesRowList[rowIndex];
                                  return InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      context.pushNamed(
                                        'gradeDashboard',
                                        queryParameters: {
                                          'gradeId': serializeParam(
                                            rowGetAllGradesRow.gradeid,
                                            ParamType.int,
                                          ),
                                        }.withoutNulls,
                                      );
                                    },
                                    child: Container(
                                      width: 300.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          if (rowGetAllGradesRow.gradename ==
                                              'Grade 10')
                                            ClipRRect(
                                              borderRadius: const BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(0.0),
                                                bottomRight:
                                                    Radius.circular(0.0),
                                                topLeft: Radius.circular(5.0),
                                                topRight: Radius.circular(5.0),
                                              ),
                                              child: Image.asset(
                                                'assets/images/Screenshot_2024-04-05_at_8.43.10_AM.png',
                                                width: 300.0,
                                                height: 200.0,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          if (rowGetAllGradesRow.gradename ==
                                              'Grade 11')
                                            ClipRRect(
                                              borderRadius: const BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(0.0),
                                                bottomRight:
                                                    Radius.circular(0.0),
                                                topLeft: Radius.circular(5.0),
                                                topRight: Radius.circular(5.0),
                                              ),
                                              child: Image.asset(
                                                'assets/images/Screenshot_2024-04-05_at_8.43.24_AM.png',
                                                width: 300.0,
                                                height: 200.0,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          if (rowGetAllGradesRow.gradename ==
                                              'Grade 12')
                                            ClipRRect(
                                              borderRadius: const BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(0.0),
                                                bottomRight:
                                                    Radius.circular(0.0),
                                                topLeft: Radius.circular(5.0),
                                                topRight: Radius.circular(5.0),
                                              ),
                                              child: Image.asset(
                                                'assets/images/Screenshot_2024-04-05_at_8.43.18_AM.png',
                                                width: 300.0,
                                                height: 200.0,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 20.0, 0.0, 20.0),
                                            child: Text(
                                              valueOrDefault<String>(
                                                rowGetAllGradesRow.gradename,
                                                'Grade 10',
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        fontSize: 25.0,
                                                        letterSpacing: 0.0,
                                                      ),
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
                        ),
                        wrapWithModel(
                          model: _model.footerModel,
                          updateCallback: () => setState(() {}),
                          child: const FooterWidget(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              wrapWithModel(
                model: _model.headerNavModel,
                updateCallback: () => setState(() {}),
                child: const HeaderNavWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
