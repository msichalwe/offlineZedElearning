import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_platform_windows/backend/sqlite/sqlite_manager.dart';
import 'package:school_platform_windows/flutter_flow/flutter_flow_util.dart';

class GradeWidget extends StatefulWidget {
  final int assessmentId;

  GradeWidget({required this.assessmentId});

  @override
  _GradeWidgetState createState() => _GradeWidgetState();
}

class _GradeWidgetState extends State<GradeWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SQLiteManager.instance.getAssessmentGrade(assessmentId: widget.assessmentId, userId: int.parse(Provider.of<FFAppState>(context, listen: false).currentUserId)),

      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While the future is loading, display a loading indicator
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          // If there's an error, display an error message
          return Center(
            child: Text("Error: ${snapshot.error}"),
          );
        } else {
                    final percentageScore = snapshot.data!.first.percentageScore.toString();

          return Center(
            child: Text(
              "$percentageScore",
              style: TextStyle(
                fontSize: 74,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }
      },
    );
  }
}
