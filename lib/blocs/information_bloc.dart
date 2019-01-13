import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:tensoradvancedproject/models/model.dart';
import 'package:tensoradvancedproject/models/github_api.dart';
import 'package:package_info/package_info.dart';

class InformationBloc{
  final Future<PackageInfo> packageInfo;
  final GitHubApi api;

  Stream<PackageInfo> _infoStream = Stream.empty();
  Stream<GitHubModel> _releases = Stream.empty();

  InformationBloc(this.packageInfo, this.api){
    _releases = Observable.defer(
      () => Observable.fromFuture(api.getReleases()).asBroadcastStream(),
      reusable: true
    );

    _infoStream = Observable.defer(
      () => Observable.fromFuture(packageInfo).asBroadcastStream(),
      reusable: true
    );

  }

  void dispose() {
    print("Dispose of Information Bloc");
  }

// getters
  Stream<PackageInfo> get infoStream => _infoStream;
  Stream<GitHubModel> get releases => _releases;
}