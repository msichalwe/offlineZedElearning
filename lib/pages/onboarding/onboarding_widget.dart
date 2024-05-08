import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import '/components/choose_profile_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'onboarding_model.dart';
import 'package:sqflite/sqflite.dart';

export 'onboarding_model.dart';

class OnboardingWidget extends StatefulWidget {
  const OnboardingWidget({Key? key}) : super(key: key);

  @override
  _OnboardingWidgetState createState() => _OnboardingWidgetState();
}

class _OnboardingWidgetState extends State<OnboardingWidget> {
  late OnboardingModel _model;
  int notificationCount = 1; // Change this to the actual count
  double _downloadProgress = 0.0;
  bool _downloading = false;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(this.context, () => OnboardingModel());

    WidgetsBinding.instance!.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  Future<void> _downloadFile(String databaseName) async {
    const url = 'http://127.0.0.1:8000/exportu';
    print('Downloading file from: $url');
    setState(() {
      _downloading = true;
      _downloadProgress = 0.0;
    });
    try {
      final response = await http.get(Uri.parse(url));
      print('Response status code: ${response.statusCode}');
      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        final dir = await getTemporaryDirectory();
        final file = File('${dir.path}/myFile.pdf');
        await file.writeAsBytes(bytes);
        print('File downloaded successfully');

        // Get the directory and filename
        final databasesPath = await getDatabasesPath();
        final path = '$databaseName.db';
        final existingDatabasePath = join(databasesPath, path); // Use join method to join paths

        // Replace an existing file with the newly downloaded file
        final existingFile = File(existingDatabasePath);
        if (await existingFile.exists()) {
          await existingFile.delete();
        }
        await file.copy(existingDatabasePath);
        print('File replaced successfully');


      } else {
        print('Failed to download file. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error downloading file: $e');
    } finally {
      setState(() {
        _downloading = false;
        _downloadProgress = 0.0;
      });
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
                width: MediaQuery.of(context).size.width * 0.5,
                height: 932.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    'assets/images/Screenshot_2024-04-08_at_12.21.48_PM.png',
                    width: MediaQuery.of(context).size.width * 1.0,
                    height: MediaQuery.of(context).size.height * 1.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0.0, 210.0, 0.0, 0.0),
                        child: Stack(
                          children: [
                            Positioned(
                              child: IconButton(
                                onPressed: () async {
                                  print('Update icon clicked');
                                  await _downloadFile('lite_zed'); // Replace with your existing database name
                                },
                                icon: Icon(Icons.update),
                                color: Colors.white,

                              ),
                            ),
                            if (_downloading)
                              Positioned.fill(
                                child: Center(
                                  child: CircularProgressIndicator(
                                    value: _downloadProgress,
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue), // Customizing color
                                    semanticsLabel: 'Downloading...',
                                    semanticsValue: '${(_downloadProgress * 100).toStringAsFixed(0)}%',
                                  ),
                                ),
                              ),
                            if (notificationCount > 0)
                              Positioned(
                                right: 0,
                                top: 0,
                                child: Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  constraints: BoxConstraints(
                                    minWidth: 16,
                                    minHeight: 16,
                                  ),
                                  child: Text(
                                    '$notificationCount',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Text(


                          'ZEDELEARNING OFFLINE offers a chance for students all accross Zambia \nto download install and use the application offline. Our aim is to provide a seamless \nand easy way for students to access school material any time and any where.',
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
                            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 8.0, 0.0),
                            child: FFButtonWidget(
                              onPressed: () async {
                                await showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: const Color(0xD3FFFFFF),
                                  context: context,
                                  builder: (context) {
                                    return GestureDetector(
                                      onTap: () => _model.unfocusNode.canRequestFocus
                                          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
                                          : FocusScope.of(context).unfocus(),
                                      child: Padding(
                                        padding: MediaQuery.viewInsetsOf(context),
                                        child: SizedBox(
                                          height: MediaQuery.of(context).size.height * 1.0,
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
                                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                color: Colors.black,
                                textStyle: FlutterFlowTheme.of(context).bodyLarge.override(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}