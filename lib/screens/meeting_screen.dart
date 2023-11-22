import 'dart:math';

import 'package:flutter/material.dart';
import 'package:zoom_clone/resources/jitsi_meet_method.dart';
import 'package:zoom_clone/widgets/home_meeting_button.dart';

class MeetingScreen extends StatelessWidget {
  MeetingScreen({Key? key}) : super(key: key);
  final JitsiMeetMethods _jitsiMeetMethods = JitsiMeetMethods();
  bool isAudioMuted = true;
  bool isVideoMuted = true;
  void createNewMeeting() async {
    var random = Random();
    String roomName = (random.nextInt(10000000) + 10000000).toString();
    _jitsiMeetMethods.createMeeting(roomName, isAudioMuted, isVideoMuted);
  }

  joinMeeting(BuildContext context) {
    Navigator.pushNamed(context, '/video-call');
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          HomeMeetingButton(
            onPressed: createNewMeeting,
            text: 'New Meeting',
            icon: Icons.videocam,
          ),
          HomeMeetingButton(
            onPressed: () => joinMeeting(context),
            text: 'join Meeting',
            icon: Icons.add_box_outlined,
          ),
          HomeMeetingButton(
            onPressed: () {},
            text: 'Schedule Meeting',
            icon: Icons.calendar_today,
          ),
          HomeMeetingButton(
            onPressed: () {},
            text: 'Share Screen',
            icon: Icons.arrow_upward_rounded,
          ),
        ],
      ),
      const Expanded(
          child: Center(
        child: Text(
          'Create/Join Meetings with just a click',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      )),
    ]);
  }
}
