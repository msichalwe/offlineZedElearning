import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  void _initializePlayer() {
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    _videoPlayerController.initialize().then((_) {
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: false,
        looping: false,
        allowFullScreen: true,
        allowedScreenSleep: false,
        showControls: true,
        placeholder: Center(child: CircularProgressIndicator()),
        aspectRatio: _videoPlayerController.value.aspectRatio,
        autoInitialize: true,

      );
      setState(() {});
    });
  }

  // Future<void> _buildOptions(BuildContext context, List<OptionItem> chewieOptions) async {
  //   // Define your custom options
  //   final List<OptionItem> customOptions = [
  //     OptionItem(
  //       onTap: () {
  //         // Custom option 1 action
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text('Custom Option 1 Selected')),
  //         );
  //       },
  //       iconData: Icons.settings,
  //       title: 'Custom Option 1',
  //     ),
  //     OptionItem(
  //       onTap: () {
  //         // Custom option 2 action
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text('Custom Option 2 Selected')),
  //         );
  //       },
  //       iconData: Icons.info,
  //       title: 'Custom Option 2',
  //     ),
  //   ];
  //
  //   // Combine default and custom options
  //   final List<OptionItem> allOptions = [...chewieOptions, ...customOptions];
  //
  //   // Show a dialog with the options
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (context) {
  //       return Wrap(
  //         children: allOptions.map((option) {
  //           return ListTile(
  //             leading: Icon(option.iconData),
  //             title: Text(option.title),
  //             onTap: () {
  //               Navigator.pop(context);
  //               // option.onTap();
  //             },
  //           );
  //         }).toList(),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400.0,
      child: _chewieController != null && _videoPlayerController.value.isInitialized
          ? Chewie(controller: _chewieController!)
          : Center(child: CircularProgressIndicator()),
    );
  }
}
