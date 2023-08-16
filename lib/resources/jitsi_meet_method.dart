import 'package:flutter/material.dart';
import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';
// import 'package:feature_flags/feature_flags.dart';
import 'package:zoom_clone/resources/auth_methods.dart';

class JitsiMeetMethods {
  final AuthMethods _authMethods = AuthMethods();
  final AuthMethods authMethods = AuthMethods();
  void  createMeeting( String roomName,  bool isAudioMuted,  bool isVideoMuted  ) 
  async {
    try {
      var options = JitsiMeetingOptions(
          roomNameOrUrl: roomName,
          userDisplayName: _authMethods.user.displayName,
          subject: "Meeting with ish",
          userEmail: _authMethods.user.email,
          userAvatarUrl: _authMethods.user.photoURL,
          
          isAudioMuted: isAudioMuted,
          isVideoMuted: isVideoMuted,
          );

      await JitsiMeetWrapper.joinMeeting(options: options);
    } catch (error) {
      print("error:$error");
    }
  }
}
