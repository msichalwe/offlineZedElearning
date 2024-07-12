import 'dart:ui';
import 'package:chewie/chewie.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:provider/provider.dart';
import 'package:school_platform_windows/components/video_player_widget.dart';
import 'package:school_platform_windows/pages/assessment/assessment_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/backend/sqlite/sqlite_manager.dart';
import '/components/footer_widget.dart';
import '/components/nav_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'lesson_model.dart';
export 'lesson_model.dart';
import 'package:video_player/video_player.dart';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'dart:io';
import 'package:video_thumbnail/video_thumbnail.dart';






class LessonWidget extends StatefulWidget {
  const LessonWidget({
    super.key,
    required this.lessonId,
    this.subTopicId,
    this.subtopicName,
  });

  final int? lessonId;
  final int? subTopicId;
  final String? subtopicName;

  @override
  State<LessonWidget> createState() => _LessonWidgetState();
}

class _LessonWidgetState extends State<LessonWidget>
    with TickerProviderStateMixin {
  late LessonModel _model;

  double _progressValue = 0;
  int _lessonLength = 0;
  int _currentPhase = 1;
  String url = 'https://zedelearning.chalotek.com/storage/';
  var _test;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  _updateProgress(number) {
    setState(() {
      _progressValue = number;
    });
  }

  final animationsMap = {
    'textOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 1550.ms,
          begin: const Offset(0.0, 0.0),
          end: const Offset(0.0, 0.0),
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LessonModel());
    _loadProgress();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_model.pageViewController!.hasClients) {
        _model.pageViewController!.jumpToPage(4);
      }
    });

    // print(_progressValue);

    _model.pageViewController = PageController(
        initialPage:
            calculateCurrentPhase(_progressValue, _lessonLength.toDouble()));

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  Future<void> saveLessonProgress(
      String userId, String lessonId, int progress) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('$userId-$lessonId', progress);
  }

  Future<int?> getLessonProgress(String userId, String lessonId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('$userId-$lessonId');
  }

  int calculateCurrentPhase(double progress, double lessonLength) {
    return ((progress * lessonLength) / 100).round();
  }

  Future<void> _loadProgress() async {
    int? progress = await getLessonProgress(
        FFAppState().currentUser.hashCode.toString(),
        widget.lessonId.toString());
    setState(() {
      _progressValue =
          progress!.toDouble() ?? 0; // Default to 0 if no progress is found
    });
  }

  int listOfPages = 0;


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
          child: FutureBuilder<List<GetSingleLessonColumnsRow>>(
            future: SQLiteManager.instance.getSingleLessonColumns(
              lessonId: widget.lessonId,
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
              final containerGetSingleLessonColumnsRowList = snapshot.data!;
              // print(widget.lessonId);
              return Container(
                decoration: const BoxDecoration(),
                child: RawScrollbar(
                  thickness: 2.0,
                  child: SingleChildScrollView(
                    physics: ScrollPhysics(),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        wrapWithModel(
                          model: _model.navModel,
                          updateCallback: () => setState(() {}),
                          child: const NavWidget(),
                        ),
                        Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF5F7F9),
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                50.0, 20.0, 50.0, 20.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0.0, 25.0, 0.0, 0.0),
                                      child: Text(
                                        valueOrDefault<String>(
                                          containerGetSingleLessonColumnsRowList
                                              .first.lessonName,
                                          'english',
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Roboto',
                                              fontSize: 28.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w400,
                                            ),
                                      ).animateOnPageLoad(animationsMap[
                                          'textOnPageLoadAnimation']!),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0.0, 5.0, 0.0, 0.0),
                                      child: Text(
                                        'Lesson Video Playlist',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Roboto',
                                              fontSize: 18.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.normal,
                                            ),
                                      ),
                                    ),
                                    Container(
                                      width: 500.0,
                                      decoration: const BoxDecoration(),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: FutureBuilder(
                                            future: SQLiteManager.instance.getMedia(lessonId: widget.lessonId),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState == ConnectionState.waiting) {
                                                return Center(child: CircularProgressIndicator());
                                              } else if (snapshot.hasError) {
                                                return Center(child: Text('Error: ${snapshot.error}'));
                                              } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
                                                return Center(child: Text('No media found'));
                                              }

                                              var data = snapshot.data as List;
                                              return Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: data.map((media) {
                                                  print(media);
                                                  return Padding(
                                                    padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                                                    child: VideoThumbnail(
                                                      videoUrl: url + media.media_url,
                                                    ),
                                                  );
                                                }).toList(),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Padding(
                                    //   padding:
                                    //       const EdgeInsetsDirectional.fromSTEB(
                                    //           0.0, 8.0, 0.0, 8.0),
                                    //   child: Row(
                                    //     mainAxisSize: MainAxisSize.max,
                                    //     mainAxisAlignment:
                                    //         MainAxisAlignment.spaceBetween,
                                    //     children: [
                                    //       const FaIcon(
                                    //         FontAwesomeIcons.globe,
                                    //         color: Color(0xFF0668C9),
                                    //         size: 24.0,
                                    //       ),
                                    //       Padding(
                                    //         padding: const EdgeInsetsDirectional
                                    //             .fromSTEB(10.0, 0.0, 0.0, 0.0),
                                    //         child: Text(
                                    //           'Grade 10 Physics',
                                    //           style: FlutterFlowTheme.of(context)
                                    //               .bodyMedium
                                    //               .override(
                                    //                 fontFamily: 'Roboto',
                                    //                 letterSpacing: 0.0,
                                    //               ),
                                    //         ),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0.0, 8.0, 0.0, 8.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const FaIcon(
                                            FontAwesomeIcons.infoCircle,
                                            color: Color(0xFF0CBC87),
                                            size: 24.0,
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(10.0, 0.0, 0.0, 0.0),
                                            child: Text(
                                              'Last updated at ${containerGetSingleLessonColumnsRowList.first.createdAt}',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Roboto',
                                                        letterSpacing: 0.0,
                                                      ),
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
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              45.0, 15.0, 45.0, 30.0),
                          child: Container(
                            // width: double.infinity,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              borderRadius: BorderRadius.circular(14.0),
                              border: Border.all(
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                width: 0.2,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10.0, 10.0, 10.0, 20.0),
                              child: Container(
                                decoration: const BoxDecoration(),
                                child: FutureBuilder<
                                    List<GetPhasesFromLessonIdRow>>(
                                  future: SQLiteManager.instance
                                      .getPhasesFromLessonId(
                                    lessonId: widget.lessonId,
                                  ),
                                  builder: (context, snapshot) {
                                    // Customize what your widget looks like when it's loading.
                                    if (!snapshot.hasData) {
                                      return Center(
                                        child: SizedBox(
                                          width: 50.0,
                                          height: 50.0,
                                          child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    final pageViewGetPhasesFromLessonIdRowList =
                                        snapshot.data!;
                                    _lessonLength =
                                        pageViewGetPhasesFromLessonIdRowList
                                            .length;

                                    return Column(
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          height: 600,
                                          child: Stack(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        0.0, 0.0, 0.0, 40.0),
                                                child: PageView.builder(
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  controller: _model
                                                          .pageViewController ??=
                                                      PageController(
                                                          initialPage: min(
                                                              0,
                                                              pageViewGetPhasesFromLessonIdRowList
                                                                      .length -
                                                                  1)),
                                                  onPageChanged: (_) =>
                                                      setState(() {}),
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount:
                                                      pageViewGetPhasesFromLessonIdRowList
                                                          .length,
                                                  itemBuilder:
                                                      (context, pageViewIndex) {
                                                    listOfPages =
                                                        pageViewGetPhasesFromLessonIdRowList
                                                            .length;
                                                    final pageViewGetPhasesFromLessonIdRow =
                                                        pageViewGetPhasesFromLessonIdRowList[
                                                            pageViewIndex];

                                                    final mediaFiles =
                                                        functions
                                                            .getStringAndConvertToJsonArray(
                                                          pageViewGetPhasesFromLessonIdRow.mediaFiles,
                                                        )
                                                            ?.toList() ??
                                                            [];

                                                    return SingleChildScrollView(
                                                      physics: ScrollPhysics(),
                                                      primary: true,
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          if (pageViewGetPhasesFromLessonIdRow
                                                                      .tip !=
                                                                  null &&
                                                              pageViewGetPhasesFromLessonIdRow
                                                                      .tip !=
                                                                  '')
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(
                                                                      14.0),
                                                              child: Container(
                                                                width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width,
                                                                height: 100.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: const Color(
                                                                      0xFFF2F4F5),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              4.0),
                                                                ),
                                                                child: Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    Container(
                                                                      width:
                                                                          14.0,
                                                                      height:
                                                                          100.0,
                                                                      decoration:
                                                                          const BoxDecoration(
                                                                        color: Color(
                                                                            0xFF007BFF),
                                                                      ),
                                                                    ),
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Padding(
                                                                          padding: const EdgeInsetsDirectional
                                                                              .fromSTEB(
                                                                              20.0,
                                                                              0.0,
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children: [
                                                                              Padding(
                                                                                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                                                                                child: Icon(
                                                                                  Icons.lightbulb_rounded,
                                                                                  color: FlutterFlowTheme.of(context).warning,
                                                                                  size: 32.0,
                                                                                ),
                                                                              ),
                                                                              Padding(
                                                                                padding: const EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 0.0, 0.0),
                                                                                child: Text(
                                                                                  'TIP:',
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        fontFamily: 'Roboto',
                                                                                        fontSize: 24.0,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.bold,
                                                                                        fontStyle: FontStyle.italic,
                                                                                      ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: const EdgeInsetsDirectional
                                                                              .fromSTEB(
                                                                              20.0,
                                                                              10.0,
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Text(
                                                                            valueOrDefault<String>(
                                                                              pageViewGetPhasesFromLessonIdRow.tip,
                                                                              'TIP',
                                                                            ),
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  fontFamily: 'Roboto',
                                                                                  fontSize: 18.0,
                                                                                  letterSpacing: 0.0,
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
                                                            padding:
                                                                EdgeInsets.all(
                                                                    12.0),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: <Widget>[
                                                                Text(
                                                                    '${(_progressValue).round()}%'),
                                                                SizedBox(
                                                                    height:
                                                                        8.0), // Add spacing between progress bar and text
                                                                Container(
                                                                  height:
                                                                      5.0, // Adjust the height as needed
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(5)), // Rounded corners
                                                                    color: Colors
                                                                        .grey
                                                                        .withOpacity(
                                                                            0.5), // Change opacity if needed
                                                                  ),
                                                                  child:
                                                                      LinearProgressIndicator(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .transparent, // Make the background transparent
                                                                    valueColor: AlwaysStoppedAnimation<
                                                                            Color>(
                                                                        Color(
                                                                            0xff0D52BC)),
                                                                    value:
                                                                        _progressValue /
                                                                            100,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          if ( mediaFiles.length < 1 && mediaFiles.isEmpty || pageViewGetPhasesFromLessonIdRow
                                                              .textContent
                                                              ?.isNotEmpty ==
                                                              true )
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          14.0),
                                                              child: Html(
                                                                data: pageViewGetPhasesFromLessonIdRow
                                                                            .textContent
                                                                            ?.isNotEmpty ==
                                                                        true
                                                                    ? pageViewGetPhasesFromLessonIdRow
                                                                        .textContent!
                                                                    : '<div class="no-data">Next lesson Phase, nothing to see on this one</div>',
                                                                onLinkTap: (url,
                                                                        _,
                                                                        __,
                                                                        ___) =>
                                                                    launchURL(
                                                                        url!),
                                                                style: {
                                                                  "body": Style(
                                                                    margin:
                                                                        EdgeInsets
                                                                            .zero,
                                                                    padding:
                                                                        EdgeInsets
                                                                            .zero,
                                                                  ),
                                                                  "table": Style(
                                                                    backgroundColor: Colors.grey.shade200, // Custom style for table background
                                                                    padding: EdgeInsets.all(8.0),
                                                                  ),
                                                                  "th": Style(
                                                                    padding: EdgeInsets.all(6.0),
                                                                    backgroundColor: Colors.grey.shade300,
                                                                    border: Border.all(color: Colors.black),
                                                                  ),
                                                                  "td": Style(
                                                                    padding: EdgeInsets.all(6.0),
                                                                    backgroundColor: Colors.white,
                                                                    border: Border.all(color: Colors.black),
                                                                  ),
                                                                  ".no-data":
                                                                      Style(
                                                                    fontSize:
                                                                        FontSize
                                                                            .large, // You can adjust the size
                                                                    color: Colors
                                                                        .grey, // Change to desired color
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center, // Center the text
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            20), // Add padding for better appearance
                                                                  ),
                                                                },
                                                              ),
                                                            ),
                                                          Builder(
                                                            builder: (context) {
                                                              // print(mediaFiles);

                                                              return Container(
                                                                child: Wrap(
                                                                  children: List.generate(mediaFiles.length, (mediaFilesIndex) {
                                                                    final mediaFilesItem = mediaFiles[mediaFilesIndex];
                                                                    final mediaType = functions.convertJsonPathToString(
                                                                      getJsonField(mediaFilesItem, r'''$.mediaType''').toString(),
                                                                    );
                                                                    final mediaUrl = getJsonField(mediaFilesItem, r'''$.mediaUrl''').toString();
                                                                    final mediaDescription = getJsonField(mediaFilesItem, r'''$.mediaDescription''').toString();
                                                                    final textPosition = functions.convertJsonPathToString(
                                                                      getJsonField(mediaFilesItem, r'''$.textPosition''').toString(),
                                                                    );

                                                                    bool isValidImageType(String type) {
                                                                      return ['image/png', 'image/jpeg', 'image/gif'].contains(type);
                                                                    }

                                                                    bool isValidVideoType(String type) {
                                                                      return ['video/mp4', 'video/ogg', 'video/webm', 'video/mpg', 'video/mkv'].contains(type);
                                                                    }


                                                                    Widget buildVideo() {
                                                                      return Padding(
                                                                        padding: const EdgeInsets.all(8.0),
                                                                        child: ClipRRect(
                                                                          borderRadius: BorderRadius.circular(8.0),
                                                                          child: Container(
                                                                            width: 800,
                                                                            child: AspectRatio(
                                                                              aspectRatio: 16 / 9,
                                                                              child: VideoPlayerWidget(
                                                                                videoUrl: mediaUrl,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    }

                                                                    Widget buildImage() {
                                                                      return Padding(
                                                                        padding: const EdgeInsets.all(8.0),
                                                                        child: ClipRRect(
                                                                          borderRadius: BorderRadius.circular(8.0),
                                                                          child: Image.network(
                                                                            mediaUrl,
                                                                            width: 400.0,
                                                                            fit: BoxFit.cover,
                                                                            errorBuilder: (context, error, stackTrace) => Container(
                                                                              width: 300.0,
                                                                              height: 200.0,
                                                                              color: Colors.grey,
                                                                              child: Icon(Icons.broken_image, color: Colors.white),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    }

                                                                    Widget buildDescription(BuildContext context) {
                                                                      return Padding(
                                                                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                                                                        child: ConstrainedBox(
                                                                          constraints: BoxConstraints(
                                                                            maxWidth: MediaQuery.of(context).size.width - 20, // Subtract padding to get available width
                                                                          ),
                                                                          child: Html(
                                                                            data: mediaDescription,
                                                                            onLinkTap: (url, _, __, ___) => launchURL(url!),
                                                                            // customRenders: {
                                                                            //   "table":(context, child){
                                                                            //     return SingleChildScrollView(
                                                                            //       scrollDirection: Axis.horizontal,
                                                                            //       child: (child as Table),
                                                                            //     );
                                                                            //   }
                                                                            // },
                                                                            style: {
                                                                              "body": Style(
                                                                                margin: EdgeInsets.zero,
                                                                                padding: EdgeInsets.zero,
                                                                                whiteSpace: WhiteSpace.NORMAL, // Ensure text wraps
                                                                              ),
                                                                              "table": Style(
                                                                                backgroundColor: Colors.grey.shade200, // Custom style for table background
                                                                                padding: EdgeInsets.all(8.0),
                                                                              ),
                                                                              "th": Style(
                                                                                padding: EdgeInsets.all(6.0),
                                                                                backgroundColor: Colors.grey.shade300,
                                                                                border: Border.all(color: Colors.black),
                                                                              ),
                                                                              "td": Style(
                                                                                padding: EdgeInsets.all(6.0),
                                                                                backgroundColor: Colors.white,
                                                                                border: Border.all(color: Colors.black),
                                                                              ),
                                                                            },

                                                                          ),
                                                                        ),
                                                                      );
                                                                    }

                                                                    if (mediaType == null || mediaType.isEmpty || (!isValidImageType(mediaType) && !isValidVideoType(mediaType))) {
                                                                      return SizedBox.shrink(); // Return an empty widget if media type is invalid
                                                                    }

                                                                    Widget mediaWidget;
                                                                    if (isValidImageType(mediaType)) {
                                                                      mediaWidget = buildImage();
                                                                    } else if (isValidVideoType(mediaType)) {
                                                                      mediaWidget = buildVideo();
                                                                    } else {
                                                                      mediaWidget = SizedBox.shrink(); // Fallback in case of unexpected type
                                                                    }

                                                                    print(textPosition);

                                                                    return Container(
                                                                      child: SingleChildScrollView(
                                                                        child: Column(
                                                                          mainAxisSize: MainAxisSize.min,
                                                                          children: [
                                                                            if (textPosition == 'top') ...[
                                                                              buildDescription(context),
                                                                              mediaWidget,
                                                                            ] else if (textPosition == 'bottom') ...[
                                                                              mediaWidget,
                                                                              buildDescription(context),
                                                                            ] else if (textPosition == 'left') ...[
                                                                              Row(
                                                                                children: [
                                                                                  Flexible(
                                                                                    child: buildDescription(context),
                                                                                  ),
                                                                                  Flexible(
                                                                                    child: mediaWidget,
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ] else if (textPosition == 'right') ...[
                                                                              Row(
                                                                                children: [
                                                                                  Flexible(
                                                                                    child: mediaWidget,
                                                                                  ),
                                                                                  Flexible(
                                                                                    child: buildDescription(context),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }),
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                          child: Container(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                1.0,
                                            height: 100.0,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                if (_model
                                                        .pageViewCurrentIndex >
                                                    0)
                                                  FFButtonWidget(
                                                    onPressed: () async {
                                                      await _model
                                                          .pageViewController
                                                          ?.previousPage(
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    300),
                                                        curve: Curves.ease,
                                                      );
                                                    },
                                                    text: 'PREVIOUS',
                                                    options: FFButtonOptions(
                                                      height: 40.0,
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(24.0,
                                                              0.0, 24.0, 0.0),
                                                      iconPadding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(0.0,
                                                              0.0, 0.0, 0.0),
                                                      color: const Color(
                                                          0xFFF8F8F8),
                                                      textStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .override(
                                                                fontFamily:
                                                                    'Roboto',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: const Color(
                                                                    0xFF007BFF),
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                      elevation: 0.0,
                                                      borderSide:
                                                          const BorderSide(
                                                        color:
                                                            Color(0xFF007BFF),
                                                        width: 2.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                  ),
                                                if (_model
                                                        .pageViewCurrentIndex <
                                                    (_lessonLength - 1))
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(40.0, 0.0,
                                                            0.0, 0.0),
                                                    child: FFButtonWidget(
                                                      onPressed: () async {
                                                        if (_currentPhase !=
                                                            _lessonLength + 1) {
                                                          _updateProgress((_currentPhase
                                                                      .toDouble() /
                                                                  _lessonLength) *
                                                              100);

                                                          _currentPhase += 1;

                                                          saveLessonProgress(
                                                              FFAppState()
                                                                  .currentUser
                                                                  .hashCode
                                                                  .toString(),
                                                              widget.lessonId
                                                                  .toString(),
                                                              _progressValue
                                                                  .toInt());

                                                          // print('Kaya');
                                                          // print(_test);
                                                          // prefs.setInt(widget.lessonId.toString(),
                                                          //     _currentPhase);
                                                        }

                                                        await _model
                                                            .pageViewController
                                                            ?.nextPage(
                                                          duration:
                                                              const Duration(
                                                                  milliseconds:
                                                                      300),
                                                          curve: Curves.ease,
                                                        );
                                                      },
                                                      text: 'NEXT',
                                                      options: FFButtonOptions(
                                                        height: 40.0,
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(24.0,
                                                                0.0, 24.0, 0.0),
                                                        iconPadding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(0.0,
                                                                0.0, 0.0, 0.0),
                                                        color: const Color(
                                                            0xFFF8F8F8),
                                                        textStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .override(
                                                                  fontFamily:
                                                                      'Roboto',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: const Color(
                                                                      0xFF007BFF),
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                        elevation: 0.0,
                                                        borderSide:
                                                            const BorderSide(
                                                          color:
                                                              Color(0xFF007BFF),
                                                          width: 2.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                    ),
                                                  ),
                                                if (_model
                                                        .pageViewCurrentIndex ==
                                                    (_lessonLength - 1))
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(40.0, 0.0,
                                                            0.0, 0.0),
                                                    child: FFButtonWidget(
                                                      onPressed: () async {
                                                        Navigator.push(
                                                          context,
                                                          PageRouteBuilder(
                                                            pageBuilder: (context, animation, secondaryAnimation) => AssessmentWidget(
                                                              lessonId: widget.lessonId,
                                                            ),
                                                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                                              return FadeTransition(
                                                                opacity: animation,
                                                                child: child,
                                                              );
                                                            },
                                                          ),
                                                        );
                                                      },
                                                      text: 'Take Assessment',
                                                      // icon: const FaIcon(
                                                      //   FontAwesomeIcons.question,
                                                      //   color: Color(0xFFF8F8F8),
                                                      // ),
                                                      options: FFButtonOptions(
                                                        height: 40.0,
                                                        padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                                                        iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                        color: FlutterFlowTheme.of(context).tertiary,
                                                        textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                          fontFamily: 'Roboto',
                                                          color: Colors.white,
                                                          letterSpacing: 0.0,
                                                        ),
                                                        elevation: 0.0,
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme.of(context).tertiary,
                                                          width: 2.0,
                                                        ),
                                                        borderRadius: BorderRadius.circular(8.0),
                                                      ),
                                                    )
                                                    ,
                                                  ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: const AlignmentDirectional(1.0, 1.0),
                          child: wrapWithModel(
                            model: _model.footerModel,
                            updateCallback: () => setState(() {}),
                            child: const FooterWidget(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}





class VideoThumbnail extends StatefulWidget {
  final String videoUrl;

  const VideoThumbnail({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoThumbnailState createState() => _VideoThumbnailState();
}

class _VideoThumbnailState extends State<VideoThumbnail> {
  late VideoPlayerController _videoPlayerController;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    _initializeVideoPlayerFuture = _videoPlayerController.initialize();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => VideoPlayerModal(videoUrl: widget.videoUrl),
              );
            },
            child: Container(
              width: 100.0,
              height: 50.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: AspectRatio(
                  aspectRatio: _videoPlayerController.value.aspectRatio,
                  child: VideoPlayer(_videoPlayerController),
                ),
              ),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class VideoPlayerModal extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerModal({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoPlayerModalState createState() => _VideoPlayerModalState();
}

class _VideoPlayerModalState extends State<VideoPlayerModal> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    _videoPlayerController.initialize().then((_) {
      setState(() {
        _chewieController = ChewieController(
          videoPlayerController: _videoPlayerController,
          autoPlay: true,
          looping: false,
        );
      });
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.8,
        child: _chewieController != null && _chewieController!.videoPlayerController.value.isInitialized
            ? Chewie(
          controller: _chewieController!,
        )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}


