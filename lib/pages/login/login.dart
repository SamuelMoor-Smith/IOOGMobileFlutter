import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:namer_app/services/REDCapAPI/ok.dart';
import 'package:namer_app/services/login.dart';
import 'package:namer_app/services/REDCapAPI/api_constants.dart';
import 'package:namer_app/utils.dart';
import '../selection/study_id.dart';

class LoginScreen extends StatelessWidget {

  final apiUrl = UserFormField(
    keyName: "apiUrl", 
    displayName: "REDCap API url",
  );

  final token = UserFormField(
    keyName: "token", 
    displayName: "REDCap API Access Token",
  );

  Future<String?>? _onLogin(LoginData data) async {
    final user = await UserSecureStorage.getUsername(data.name);
    var success = user != null && data.password == user.password;
    if (success) {
      APIConstants.apiUrl = user.apiUrl;
      APIConstants.token = user.token;
    }
    await apiOK();
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

    APIConstants.apiUrl = user.apiUrl;
    APIConstants.token = user.token;

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
      onSubmitAnimationCompleted: () {
        nextPage(context, StudyIdPage());
      },
    );
  }
}