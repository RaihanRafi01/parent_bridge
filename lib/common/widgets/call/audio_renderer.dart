import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class AudioRenderer extends StatelessWidget {
  final MediaStream? stream;

  const AudioRenderer({super.key, this.stream});

  @override
  Widget build(BuildContext context) {
    if (stream == null) {
      return const SizedBox.shrink();
    }

    final renderer = RTCVideoRenderer();

    // For audio-only calls, we still need a renderer + RTCVideoView
    // but we keep it tiny/invisible since there's no visible video
    return SizedBox(
      width: 0.1,
      height: 0.1,
      child: RTCVideoView(
        renderer,
        objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitContain,
        mirror: false,           // false for remote audio (no need to mirror)
        // filterQuality: FilterQuality.low, // optional, can add if needed
      ),
    );
  }
}