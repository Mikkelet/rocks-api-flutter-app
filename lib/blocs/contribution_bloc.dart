import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:tensoradvancedproject/models/model.dart';
import 'package:tensoradvancedproject/models/rocks_api.dart';

class ContributionBloc{
  final RocksApi rocksApi;

  Stream<List<Contribution>> _results = Stream.empty();

  BehaviorSubject<String> _pageName 
  = BehaviorSubject<String>(seedValue: "unreviewed");

  ContributionBloc(this.rocksApi){
    _results = _pageName.asyncMap((page) => rocksApi.getContributions(pageName: page))
    .asBroadcastStream();
  }

  void dispose(){
    _pageName.close();
  }
   
  
  // getters
  Stream<List<Contribution>> get results => _results;
  Sink<String> get pageName => _pageName;
}