import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:namer_app/models/project.dart';
import 'package:namer_app/api/export/ok.dart';
import 'package:namer_app/utils/logging.dart';
import 'package:namer_app/utils/login.dart';
import 'selection/study_id.dart';

class LoginScreen extends StatelessWidget {
  IOOGProject? project;

  final apiUrl = UserFormField(
    keyName: "apiUrl",
    displayName: "REDCap API url",
  );

  final token = UserFormField(
    keyName: "token",
    displayName: "REDCap API Access Token",
  );

  Future<bool?> initializeProject(String apiUrl, String token) async {
    project = IOOGProject(apiUrl, token);
    if (project == null) {
      throw Exception("Project is null");
    }
    // start the 3 async tasks in parallel
    var futures = [
      getOKFromREDCAP(project!),
      project!.setStudyIds(),
      project!.setInstruments(),
    ];
    // wait for all 3 tasks to complete
    await Future.wait(futures);
    return true;
  }

  Future<String?>? _onLogin(LoginData data) async {
    final user = await UserSecureStorage.getUsername(data.name);
    var success = user != null && data.password == user.password;
    if (success) {
      bool? projectInitialized =
          await initializeProject(user.apiUrl, user.token);
    }

    return success == true ? null : "Something went wrong";
  }

  Future<String?>? _onSignup(SignupData data) {
    final user = UserSecureStorage.createUser(
      data.name,
      data.password,
      data.additionalSignupData!['apiUrl'],
      data.additionalSignupData!['token'],
    );

    UserSecureStorage.addUser(user);
    initializeProject(user.apiUrl, user.token);

    // APIConstants.apiUrl = user.apiUrl;
    // APIConstants.token = user.token;

    return null;
  }

  Future<String?>? _onRecoverPassword(String name) {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: '',
      logo: "assets/IOOGicon.png",
      onLogin: _onLogin,
      onSignup: _onSignup,
      onRecoverPassword: _onRecoverPassword,
      additionalSignupFields: [apiUrl, token],
      onSubmitAnimationCompleted: () async {
        if (project != null) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => StudyIdPage(project!),
          ));
        } else {
          printError("Project is null");
          printLog("creating new project");
          await initializeProject(apiUrl.toString(), token.toString());
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => StudyIdPage(project!),
          ));
        }
      },
    );
  }
}
