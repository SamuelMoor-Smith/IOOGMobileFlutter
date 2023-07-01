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

  final apiToken = UserFormField(
    keyName: "apiToken",
    displayName: "REDCap API Access Token",
  );

  Future<String?>? _onLogin(LoginData data) async {
    final user = await UserSecureStorage.getUsername(data.name);
    var success = user != null && data.password == user.password;
    if (success) {
      project = IOOGProject(user.apiUrl, user.apiToken);
      await getOKFromREDCAP(project); // TODO: this returns error i think
    }

    return success == true ? null : "Something went wrong";
  }

  Future<String?>? _onSignup(SignupData data) {
    final user = UserSecureStorage.createUser(
      data.name,
      data.password,
      data.additionalSignupData!['apiUrl'],
      data.additionalSignupData!['apiToken'],
    );

    UserSecureStorage.addUser(user);

    // APIConstants.apiUrl = user.apiUrl;
    // APIConstants.apiToken = user.apiToken;

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
      additionalSignupFields: [apiUrl, apiToken],
      onSubmitAnimationCompleted: () {
        if (project != null) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => StudyIdPage(project!),
          ));
        } else {
          printError("Project is null");
        }
      },
    );
  }
}
