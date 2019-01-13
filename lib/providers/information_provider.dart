import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:tensoradvancedproject/blocs/information_bloc.dart';
import 'package:tensoradvancedproject/models/github_api.dart';



class InformationProvider extends InheritedWidget {
  final InformationBloc informationBloc;

  InformationProvider({Key key, InformationBloc informationBloc, Widget child})
      : this.informationBloc = informationBloc ??
      // allows us to grab meta data from app and put it into blockn
            InformationBloc(PackageInfo.fromPlatform(), GitHubApi()),
        super(key: key, child: child);

  static InformationBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(InformationProvider)
            as InformationProvider)
        .informationBloc;
  }

  @override
  bool updateShouldNotify(InformationProvider oldWidget) => true;
}
