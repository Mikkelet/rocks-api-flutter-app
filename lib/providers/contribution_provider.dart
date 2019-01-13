import 'package:flutter/material.dart';
import 'package:tensoradvancedproject/blocs/contribution_bloc.dart';
import 'package:tensoradvancedproject/models/rocks_api.dart';

class ContributionProvider extends InheritedWidget {

  final ContributionBloc contributionBloc;

    ContributionProvider({
    Key key,
    ContributionBloc contributionBloc,
    Widget child,
  })  : this.contributionBloc = contributionBloc ??
            ContributionBloc(
              RocksApi(),
            ),
        super(child: child, key: key);


  static ContributionBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(ContributionProvider)
    as ContributionProvider)
    .contributionBloc;
  }

  @override
  bool updateShouldNotify( ContributionProvider oldWidget) => true;
}