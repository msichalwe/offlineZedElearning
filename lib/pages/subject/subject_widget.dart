import '/backend/sqlite/sqlite_manager.dart';
import '/components/banner_widget.dart';
import '/components/footer_widget.dart';
import '/components/lesson_count_banner_widget.dart';
import '/components/nav_widget.dart';
import '/components/side_widget.dart';
import '/components/table_of_contents_widget.dart';
import '/components/test_comp_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'subject_model.dart';
export 'subject_model.dart';

class SubjectWidget extends StatefulWidget {
  const SubjectWidget({
    super.key,
    int? syllabusId,
  }) : syllabusId = syllabusId ?? 0;

  final int syllabusId;

  @override
  State<SubjectWidget> createState() => _SubjectWidgetState();
}

class _SubjectWidgetState extends State<SubjectWidget> {
  late SubjectModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SubjectModel());

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
          child: SingleChildScrollView(
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
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(35.0, 35.0, 0.0, 35.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            wrapWithModel(
                              model: _model.sideModel,
                              updateCallback: () => setState(() {}),
                              child: const SideWidget(),
                            ),
                            wrapWithModel(
                              model: _model.tableOfContentsModel,
                              updateCallback: () => setState(() {}),
                              child: TableOfContentsWidget(
                                sylabasId: widget.syllabusId,
                              ),
                            ),
                          ],
                        ),
                        FutureBuilder<List<GetSingleSyllabiRow>>(
                          future: SQLiteManager.instance.getSingleSyllabi(
                            syllabusId: widget.syllabusId,
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
                            final mainTopicsContainerGetSingleSyllabiRowList =
                                snapshot.data!;
                            return Container(
                              decoration: const BoxDecoration(),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  wrapWithModel(
                                    model: _model.lessonCountBannerModel,
                                    updateCallback: () => setState(() {}),
                                    child: const LessonCountBannerWidget(),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        30.0, 0.0, 0.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 50.0, 0.0),
                                          child: Container(
                                            width: 1020.0,
                                            decoration: const BoxDecoration(
                                              color: Color(0x00FFFFFF),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(18.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(30.0, 0.0,
                                                                0.0, 0.0),
                                                    child: Card(
                                                      clipBehavior: Clip
                                                          .antiAliasWithSaveLayer,
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                      elevation: 0.0,
                                                      shape:
                                                          const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  0.0),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  0.0),
                                                          topLeft:
                                                              Radius.circular(
                                                                  0.0),
                                                          topRight:
                                                              Radius.circular(
                                                                  0.0),
                                                        ),
                                                      ),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets.all(
                                                                    20.0),
                                                            child: Text(
                                                              '${valueOrDefault<String>(
                                                                mainTopicsContainerGetSingleSyllabiRowList
                                                                    .first
                                                                    .gradeName,
                                                                'Grade 10',
                                                              )} ${valueOrDefault<String>(
                                                                mainTopicsContainerGetSingleSyllabiRowList
                                                                    .first
                                                                    .subjectName,
                                                                'Physics',
                                                              )}',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Readex Pro',
                                                                    fontSize:
                                                                        30.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300,
                                                                  ),
                                                            ),
                                                          ),
                                                          Divider(
                                                            thickness: 0.5,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryText,
                                                          ),
                                                          Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        15.0,
                                                                        0.0,
                                                                        15.0),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  children: [
                                                                    FFButtonWidget(
                                                                      onPressed:
                                                                          () {
                                                                        print(
                                                                            'Button pressed ...');
                                                                      },
                                                                      text:
                                                                          'Media Library',
                                                                      options:
                                                                          FFButtonOptions(
                                                                        width:
                                                                            200.0,
                                                                        height:
                                                                            50.0,
                                                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                                                            24.0,
                                                                            0.0,
                                                                            24.0,
                                                                            0.0),
                                                                        iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                        color: const Color(
                                                                            0x007713E0),
                                                                        textStyle: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .override(
                                                                              fontFamily: 'Readex Pro',
                                                                              color: const Color(0xFF008DDA),
                                                                              fontSize: 19.0,
                                                                              letterSpacing: 0.0,
                                                                            ),
                                                                        elevation:
                                                                            0.0,
                                                                        borderSide:
                                                                            const BorderSide(
                                                                          color:
                                                                              Color(0xFF008DDA),
                                                                          width:
                                                                              1.0,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(8.0),
                                                                      ),
                                                                    ),
                                                                    FFButtonWidget(
                                                                      onPressed:
                                                                          () {
                                                                        print(
                                                                            'Button pressed ...');
                                                                      },
                                                                      text:
                                                                          'TextBooks',
                                                                      options:
                                                                          FFButtonOptions(
                                                                        width:
                                                                            200.0,
                                                                        height:
                                                                            50.0,
                                                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                                                            24.0,
                                                                            0.0,
                                                                            24.0,
                                                                            0.0),
                                                                        iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                        color: const Color(
                                                                            0x007713E0),
                                                                        textStyle: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .override(
                                                                              fontFamily: 'Readex Pro',
                                                                              color: const Color(0xFF65B741),
                                                                              fontSize: 19.0,
                                                                              letterSpacing: 0.0,
                                                                            ),
                                                                        elevation:
                                                                            0.0,
                                                                        borderSide:
                                                                            const BorderSide(
                                                                          color:
                                                                              Color(0xFF65B741),
                                                                          width:
                                                                              1.0,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(8.0),
                                                                      ),
                                                                    ),
                                                                    FFButtonWidget(
                                                                      onPressed:
                                                                          () {
                                                                        print(
                                                                            'Button pressed ...');
                                                                      },
                                                                      text:
                                                                          'PastPapers',
                                                                      options:
                                                                          FFButtonOptions(
                                                                        width:
                                                                            200.0,
                                                                        height:
                                                                            50.0,
                                                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                                                            24.0,
                                                                            0.0,
                                                                            24.0,
                                                                            0.0),
                                                                        iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                        color: const Color(
                                                                            0x007713E0),
                                                                        textStyle: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .override(
                                                                              fontFamily: 'Readex Pro',
                                                                              color: const Color(0xFFFFB534),
                                                                              fontSize: 19.0,
                                                                              letterSpacing: 0.0,
                                                                            ),
                                                                        elevation:
                                                                            0.0,
                                                                        borderSide:
                                                                            const BorderSide(
                                                                          color:
                                                                              Color(0xFFFFB534),
                                                                          width:
                                                                              1.0,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(8.0),
                                                                      ),
                                                                    ),
                                                                    FFButtonWidget(
                                                                      onPressed:
                                                                          () {
                                                                        print(
                                                                            'Button pressed ...');
                                                                      },
                                                                      text:
                                                                          'Media Library',
                                                                      options:
                                                                          FFButtonOptions(
                                                                        width:
                                                                            200.0,
                                                                        height:
                                                                            50.0,
                                                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                                                            24.0,
                                                                            0.0,
                                                                            24.0,
                                                                            0.0),
                                                                        iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                        color: const Color(
                                                                            0x007713E0),
                                                                        textStyle: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .override(
                                                                              fontFamily: 'Readex Pro',
                                                                              color: const Color(0xFFE72929),
                                                                              fontSize: 19.0,
                                                                              letterSpacing: 0.0,
                                                                            ),
                                                                        elevation:
                                                                            0.0,
                                                                        borderSide:
                                                                            const BorderSide(
                                                                          color:
                                                                              Color(0xFFE72929),
                                                                          width:
                                                                              1.0,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(8.0),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(30.0, 0.0,
                                                                0.0, 0.0),
                                                    child: Card(
                                                      clipBehavior: Clip
                                                          .antiAliasWithSaveLayer,
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                      elevation: 0.0,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(0.0),
                                                      ),
                                                      child: FutureBuilder<
                                                          List<
                                                              GetTopicsInSubjectsFromSylabiRow>>(
                                                        future: SQLiteManager
                                                            .instance
                                                            .getTopicsInSubjectsFromSylabi(
                                                          syllabiId:
                                                              mainTopicsContainerGetSingleSyllabiRowList
                                                                  .first
                                                                  .syllabusId,
                                                        ),
                                                        builder: (context,
                                                            snapshot) {
                                                          // Customize what your widget looks like when it's loading.
                                                          if (!snapshot
                                                              .hasData) {
                                                            return Center(
                                                              child: SizedBox(
                                                                width: 50.0,
                                                                height: 50.0,
                                                                child:
                                                                    CircularProgressIndicator(
                                                                  valueColor:
                                                                      AlwaysStoppedAnimation<
                                                                          Color>(
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                          final columnGetTopicsInSubjectsFromSylabiRowList =
                                                              snapshot.data!;
                                                          return SingleChildScrollView(
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: List.generate(
                                                                  columnGetTopicsInSubjectsFromSylabiRowList
                                                                      .length,
                                                                  (columnIndex) {
                                                                final columnGetTopicsInSubjectsFromSylabiRow =
                                                                    columnGetTopicsInSubjectsFromSylabiRowList[
                                                                        columnIndex];
                                                                return FutureBuilder<
                                                                    List<
                                                                        GetSubtopicsFromTopicIdRow>>(
                                                                  future: SQLiteManager
                                                                      .instance
                                                                      .getSubtopicsFromTopicId(
                                                                    topicId:
                                                                        columnGetTopicsInSubjectsFromSylabiRow
                                                                            .topicId,
                                                                  ),
                                                                  builder: (context,
                                                                      snapshot) {
                                                                    // Customize what your widget looks like when it's loading.
                                                                    if (!snapshot
                                                                        .hasData) {
                                                                      return Center(
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              50.0,
                                                                          height:
                                                                              50.0,
                                                                          child:
                                                                              CircularProgressIndicator(
                                                                            valueColor:
                                                                                AlwaysStoppedAnimation<Color>(
                                                                              FlutterFlowTheme.of(context).primary,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    }
                                                                    final containerGetSubtopicsFromTopicIdRowList =
                                                                        snapshot
                                                                            .data!;
                                                                    return Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryBackground,
                                                                      ),
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(20.0),
                                                                            child:
                                                                                Text(
                                                                              valueOrDefault<String>(
                                                                                columnGetTopicsInSubjectsFromSylabiRow.topicName,
                                                                                'name',
                                                                              ),
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'Readex Pro',
                                                                                    fontSize: 30.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.w300,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: const EdgeInsetsDirectional.fromSTEB(
                                                                                20.0,
                                                                                0.0,
                                                                                0.0,
                                                                                15.0),
                                                                            child:
                                                                                Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                const Icon(
                                                                                  Icons.window_outlined,
                                                                                  color: Color(0xFFFFB534),
                                                                                  size: 24.0,
                                                                                ),
                                                                                Padding(
                                                                                  padding: const EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
                                                                                  child: Text(
                                                                                    '${containerGetSubtopicsFromTopicIdRowList.length.toString()} Subtopics',
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          fontFamily: 'Readex Pro',
                                                                                          fontSize: 18.0,
                                                                                          letterSpacing: 0.0,
                                                                                        ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Divider(
                                                                            thickness:
                                                                                0.5,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryText,
                                                                          ),
                                                                          Padding(
                                                                            padding: const EdgeInsetsDirectional.fromSTEB(
                                                                                20.0,
                                                                                18.0,
                                                                                0.0,
                                                                                5.0),
                                                                            child:
                                                                                Text(
                                                                              'Subtopics',
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'Readex Pro',
                                                                                    fontSize: 25.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.w300,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                          FutureBuilder<
                                                                              List<GetSubtopicsFromTopicIdRow>>(
                                                                            future:
                                                                                SQLiteManager.instance.getSubtopicsFromTopicId(
                                                                              topicId: columnGetTopicsInSubjectsFromSylabiRow.topicId,
                                                                            ),
                                                                            builder:
                                                                                (context, snapshot) {
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
                                                                              final columnGetSubtopicsFromTopicIdRowList = snapshot.data!;
                                                                              return Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: List.generate(columnGetSubtopicsFromTopicIdRowList.length, (columnIndex) {
                                                                                  final columnGetSubtopicsFromTopicIdRow = columnGetSubtopicsFromTopicIdRowList[columnIndex];
                                                                                  return Container(
                                                                                    width: double.infinity,
                                                                                    decoration: BoxDecoration(
                                                                                      color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                    ),
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.all(8.0),
                                                                                      child: Container(
                                                                                        width: double.infinity,
                                                                                        color: Colors.white,
                                                                                        child: ExpandableNotifier(
                                                                                          initialExpanded: false,
                                                                                          child: ExpandablePanel(
                                                                                            header: Padding(
                                                                                              padding: const EdgeInsets.all(18.0),
                                                                                              child: Text(
                                                                                                'International System of Units',
                                                                                                style: FlutterFlowTheme.of(context).displaySmall.override(
                                                                                                      fontFamily: 'Outfit',
                                                                                                      color: Colors.black,
                                                                                                      fontSize: 22.0,
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FontWeight.normal,
                                                                                                    ),
                                                                                              ),
                                                                                            ),
                                                                                            collapsed: FutureBuilder<List<GetLessonsFromSubtopicsRow>>(
                                                                                              future: SQLiteManager.instance.getLessonsFromSubtopics(
                                                                                                subtopicId: columnGetSubtopicsFromTopicIdRow.subtopicId,
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
                                                                                                final containerGetLessonsFromSubtopicsRowList = snapshot.data!;
                                                                                                return Container(
                                                                                                  width: MediaQuery.sizeOf(context).width * 1.0,
                                                                                                  height: 59.0,
                                                                                                  decoration: BoxDecoration(
                                                                                                    color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                  ),
                                                                                                  child: Padding(
                                                                                                    padding: const EdgeInsetsDirectional.fromSTEB(20.0, 8.0, 0.0, 0.0),
                                                                                                    child: Text(
                                                                                                      '${containerGetLessonsFromSubtopicsRowList.length.toString()} Lessons',
                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                            fontFamily: 'Readex Pro',
                                                                                                            color: const Color(0x8A000000),
                                                                                                            fontSize: 20.0,
                                                                                                            letterSpacing: 0.0,
                                                                                                          ),
                                                                                                    ),
                                                                                                  ),
                                                                                                );
                                                                                              },
                                                                                            ),
                                                                                            expanded: SingleChildScrollView(
                                                                                              child: Column(
                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                children: [
                                                                                                  Container(
                                                                                                    width: double.infinity,
                                                                                                    decoration: BoxDecoration(
                                                                                                      color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                    ),
                                                                                                    child: Padding(
                                                                                                      padding: const EdgeInsets.all(16.0),
                                                                                                      child: wrapWithModel(
                                                                                                        model: _model.testCompModels.getModel(
                                                                                                          '${columnGetSubtopicsFromTopicIdRow.subtopicName}${columnGetSubtopicsFromTopicIdRow.subtopicId?.toString()}${columnIndex.toString()}',
                                                                                                          columnIndex,
                                                                                                        ),
                                                                                                        updateCallback: () => setState(() {}),
                                                                                                        updateOnChange: true,
                                                                                                        child: TestCompWidget(
                                                                                                          key: Key(
                                                                                                            'Keyh41_${'${columnGetSubtopicsFromTopicIdRow.subtopicName}${columnGetSubtopicsFromTopicIdRow.subtopicId?.toString()}${columnIndex.toString()}'}',
                                                                                                          ),
                                                                                                          subtopicID: columnGetSubtopicsFromTopicIdRow.subtopicId!,
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                            theme: const ExpandableThemeData(
                                                                                              tapHeaderToExpand: true,
                                                                                              tapBodyToExpand: false,
                                                                                              tapBodyToCollapse: false,
                                                                                              headerAlignment: ExpandablePanelHeaderAlignment.center,
                                                                                              hasIcon: true,
                                                                                            ),
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
                                                                    );
                                                                  },
                                                                );
                                                              }),
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
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        if (responsiveVisibility(
                          context: context,
                          desktop: false,
                        ))
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 35.0, 30.0, 0.0),
                            child: Container(
                              width: 350.0,
                              height: 500.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).alternate,
                                borderRadius: BorderRadius.circular(14.0),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 7.0, 0.0, 8.0),
                                    child: Text(
                                      'Grade 10 Physics',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Readex Pro',
                                            color: FlutterFlowTheme.of(context)
                                                .secondary,
                                            fontSize: 20.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                  Text(
                                    'Table of Contents',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          fontSize: 17.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  SizedBox(
                                    width: 300.0,
                                    child: Divider(
                                      thickness: 0.5,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                    ),
                                  ),
                                  ListView(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              '1. GENERAL PHYSICS',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Readex Pro',
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    fontSize: 25.0,
                                                    letterSpacing: 0.0,
                                                  ),
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'i. International System of Units(SI)',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        letterSpacing: 0.0,
                                                      ),
                                                ),
                                                Container(
                                                  width: 240.0,
                                                  decoration: const BoxDecoration(),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                        'a. ',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Readex Pro',
                                                                  color: const Color(
                                                                      0xFF1933D3),
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                      ),
                                                      Container(
                                                        width: 230.0,
                                                        decoration:
                                                            const BoxDecoration(),
                                                        child: Wrap(
                                                          spacing: 0.0,
                                                          runSpacing: 0.0,
                                                          alignment:
                                                              WrapAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              WrapCrossAlignment
                                                                  .start,
                                                          direction:
                                                              Axis.horizontal,
                                                          runAlignment:
                                                              WrapAlignment
                                                                  .start,
                                                          verticalDirection:
                                                              VerticalDirection
                                                                  .down,
                                                          clipBehavior:
                                                              Clip.none,
                                                          children: [
                                                            Text(
                                                              'Basic and Derived Quantities',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Readex Pro',
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: 240.0,
                                                  decoration: const BoxDecoration(),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                        'b. ',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Readex Pro',
                                                                  color: const Color(
                                                                      0xFF1933D3),
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                      ),
                                                      Container(
                                                        width: 230.0,
                                                        decoration:
                                                            const BoxDecoration(),
                                                        child: Wrap(
                                                          spacing: 0.0,
                                                          runSpacing: 0.0,
                                                          alignment:
                                                              WrapAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              WrapCrossAlignment
                                                                  .start,
                                                          direction:
                                                              Axis.horizontal,
                                                          runAlignment:
                                                              WrapAlignment
                                                                  .start,
                                                          verticalDirection:
                                                              VerticalDirection
                                                                  .down,
                                                          clipBehavior:
                                                              Clip.none,
                                                          children: [
                                                            Text(
                                                              'Basic and Derived Units',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Readex Pro',
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: 240.0,
                                                  decoration: const BoxDecoration(),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                        'c. ',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Readex Pro',
                                                                  color: const Color(
                                                                      0xFF1933D3),
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                      ),
                                                      Container(
                                                        width: 230.0,
                                                        decoration:
                                                            const BoxDecoration(),
                                                        child: Wrap(
                                                          spacing: 0.0,
                                                          runSpacing: 0.0,
                                                          alignment:
                                                              WrapAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              WrapCrossAlignment
                                                                  .start,
                                                          direction:
                                                              Axis.horizontal,
                                                          runAlignment:
                                                              WrapAlignment
                                                                  .start,
                                                          verticalDirection:
                                                              VerticalDirection
                                                                  .down,
                                                          clipBehavior:
                                                              Clip.none,
                                                          children: [
                                                            Text(
                                                              'Prefix Multiples of fundermental and derived units.',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Readex Pro',
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: 240.0,
                                                  decoration: const BoxDecoration(),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                        'd. ',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Readex Pro',
                                                                  color: const Color(
                                                                      0xFF1933D3),
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                      ),
                                                      Container(
                                                        width: 230.0,
                                                        decoration:
                                                            const BoxDecoration(),
                                                        child: Wrap(
                                                          spacing: 0.0,
                                                          runSpacing: 0.0,
                                                          alignment:
                                                              WrapAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              WrapCrossAlignment
                                                                  .start,
                                                          direction:
                                                              Axis.horizontal,
                                                          runAlignment:
                                                              WrapAlignment
                                                                  .start,
                                                          verticalDirection:
                                                              VerticalDirection
                                                                  .down,
                                                          clipBehavior:
                                                              Clip.none,
                                                          children: [
                                                            Text(
                                                              'Scientific Notation',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Readex Pro',
                                                                    letterSpacing:
                                                                        0.0,
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
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                wrapWithModel(
                  model: _model.footerModel,
                  updateCallback: () => setState(() {}),
                  child: const FooterWidget(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
