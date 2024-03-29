import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:namer_app/models/project.dart';
import 'package:namer_app/api/export/ok.dart';
import 'package:namer_app/utils/logging.dart';
import 'package:namer_app/utils/login.dart';
import '../components/import_toast.dart';
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
    if (futures[0] == false) {
      createToast("REDCap server is not available", Colors.red);
      return false;
    }
    return true;
  }

  Future<String?>? _onLogin(LoginData data) async {
    User? user;
    bool? projectInitialized;
    if (data.name == "admin@ioog.net" &&
        data.password == "qwerty-asdfg-zxcvb") {
      projectInitialized = await initializeProject(
          "https://redcapdemo.vanderbilt.edu/api/",
          "9EFBB80E7196CA113E2C9C1D92002A07");

      if (projectInitialized == false) {
        return "Incorrect credentials or server is down";
      }
      return null;
    } else {
      user = await UserSecureStorage.getUsername(data.name);
    }
    // user = await UserSecureStorage.getUsername(data.name);
    var success = user != null && data.password == user.password;
    if (success) {
      projectInitialized = await initializeProject(user.apiUrl, user.token);
      if (projectInitialized == false) {
        return "Incorrect credentials or server is down";
      }
    }

    return success == true ? null : "Something went wrong";
  }

  Future<String?>? _onSignup(SignupData data) async {
    final user = UserSecureStorage.createUser(
      data.name,
      data.password,
      data.additionalSignupData!['apiUrl'],
      data.additionalSignupData!['token'],
    );

    UserSecureStorage.addUser(user);
    var success = await initializeProject(user.apiUrl, user.token);

    if (success == false) {
      return "Incorrect credentials or server is down";
    }

    // APIConstants.apiUrl = user.apiUrl;
    // APIConstants.token = user.token;

    return null;
  }

  Future<String?>? _onRecoverPassword(String name) {
    createToast("Please make a new account", Colors.blue);
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
