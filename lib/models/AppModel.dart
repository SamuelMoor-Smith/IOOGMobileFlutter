import 'package:flutter/material.dart';

class AppTheme {
  List<ProTheme>? themes;
  List<ProTheme>? screenList;
  ProTheme? dashboard;
  ProTheme? fullApp;
  ProTheme? widgets;
  ProTheme? defaultTheme;
  ProTheme? integrations;
  ProTheme? workingApps;
  ProTheme? webApps;

  AppTheme({this.themes, this.screenList, this.dashboard, this.fullApp, this.workingApps, this.widgets, this.defaultTheme, this.integrations, this.webApps});

  factory AppTheme.fromJson(Map<String, dynamic> json) {
    return AppTheme(
      themes: json['themes'] != null ? (json['themes'] as List).map((i) => ProTheme.fromJson(i)).toList() : null,
      screenList: json['screen_list'] != null ? (json['screen_list'] as List).map((i) => ProTheme.fromJson(i)).toList() : null,
      dashboard: json['dashboard'] != null ? ProTheme.fromJson(json['dashboard']) : null,
      fullApp: json['fullapp'] != null ? ProTheme.fromJson(json['fullapp']) : null,
      widgets: json['widgets'] != null ? ProTheme.fromJson(json['widgets']) : null,
      defaultTheme: json['defaultTheme'] != null ? ProTheme.fromJson(json['defaultTheme']) : null,
      integrations: json['integrations'] != null ? ProTheme.fromJson(json['integrations']) : null,
      webApps: json['webApps'] != null ? ProTheme.fromJson(json['webApps']) : null,
      workingApps: json['workingApps'] != null ? ProTheme.fromJson(json['workingApps']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (themes != null) {
      data['themes'] = themes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProTheme {
  String? name;

  // ignore: non_constant_identifier_names
  bool? show_cover;

  // ignore: non_constant_identifier_names
  List<ProTheme>? sub_kits;

  // ignore: non_constant_identifier_names
  String? title_name;
  String? type;
  String? icon;

  // ignore: non_constant_identifier_names
  bool? is_theme;
  String? tag;
  bool? darkThemeSupported;
  Widget? widget;
  bool? isWebSupported;

  // ignore: non_constant_identifier_names
  ProTheme({this.name, this.icon, this.is_theme, this.tag, this.type, this.show_cover, this.sub_kits, this.title_name, this.darkThemeSupported, this.widget, this.isWebSupported = false});

  factory ProTheme.fromJson(Map<String, dynamic> json) {
    return ProTheme(
        name: json['name'],
        icon: json['icon'],
        is_theme: json['is_theme'],
        tag: json['tag'],
        type: json['type'],
        show_cover: json['show_cover'],
        sub_kits: json['sub_kits'] != null ? (json['sub_kits'] as List).map((i) => ProTheme.fromJson(i)).toList() : null,
        title_name: json['title_name'],
        darkThemeSupported: json['darkThemeSupported'],
        widget: json['widget'],
        isWebSupported: json['isWebSupported']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['show_cover'] = show_cover;
    data['title_name'] = title_name;
    data['type'] = type;
    data['tag'] = tag;
    data['darkThemeSupported'] = darkThemeSupported;
    data['isWebSupported'] = isWebSupported;
    data['icon'] = icon;
    data['widget'] = widget;
    data['is_theme'] = is_theme;
    if (sub_kits != null) {
      data['sub_kits'] = sub_kits!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
