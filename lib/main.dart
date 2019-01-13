import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:tensoradvancedproject/blocs/contribution_bloc.dart';
import 'package:tensoradvancedproject/blocs/information_bloc.dart';
import 'package:tensoradvancedproject/components/information_drawer.dart';
import 'package:tensoradvancedproject/components/list_page.dart';
import 'package:tensoradvancedproject/models/github_api.dart';
import 'package:tensoradvancedproject/models/rocks_api.dart';
import 'package:tensoradvancedproject/providers/base_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ContributionBloc>(
      builder: (_, bloc) => bloc ?? ContributionBloc(RocksApi()),
      onDispose: (_, bloc) => bloc.dispose(),
      child: RootApp(),
    );
  }
}

class RootApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final contributionBloc = Provider.ofType<ContributionBloc>(context);
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Utpian Rocks Mobile",
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Utopian Rocks Mobile"),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.rate_review),
                  text: "Waiting for review",
                ),
                Tab(
                  icon: Icon(Icons.hourglass_empty),
                  text: "Waiting on Upvote",
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              ListPage(
                pageName: "unreviewed",
                bloc: contributionBloc,
              ),
              ListPage(
                pageName: "pending",
                bloc: contributionBloc,
              )
            ],
          ),
          endDrawer: BlocProvider<InformationBloc>(
            builder: (_, bloc) => bloc ?? 
                InformationBloc(PackageInfo.fromPlatform(), GitHubApi()),
            onDispose: (_, bloc) => bloc.dispose(),
            child: InformationDrawer(),
          ),
        ),
      ),
    );
  }
}
