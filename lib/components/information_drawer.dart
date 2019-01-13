import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:tensoradvancedproject/blocs/information_bloc.dart';
import 'package:tensoradvancedproject/models/github_api.dart';
import 'package:tensoradvancedproject/providers/base_provider.dart';
import 'package:tensoradvancedproject/providers/information_provider.dart';

class InformationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      semanticLabel: "Information Drawer",
      child: Flex(
        direction: Axis.vertical,
        children: <Widget>[_buildInfoPanel(context), Center()],
      ),
    );
  }

  Widget _buildInfoPanel(BuildContext context) {
    final informationBloc = Provider.ofType<InformationBloc>(context);
    return InformationProvider(
      informationBloc: InformationBloc(PackageInfo.fromPlatform(), GitHubApi()),
      child: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 30.0),
            width: MediaQuery.of(context).size.width,
            color: Colors.black,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "Information",
                style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
          StreamBuilder(
            stream: informationBloc.infoStream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              return Flex(
                direction: Axis.vertical,
                children: <Widget>[
                  _buildInfoTile("${snapshot.data.appName}",
                      subtitle:
                          "Pre-release Version Number: ${snapshot.data.version}"),
                  _buildInfoTile("Instructions: ",
                      subtitle:
                          "Double tap on a contribution to open it in a browser"),
                  _buildInfoTile("Author & Application Info",
                      subtitle: "Developed by @Tensor. ...."),
                  RaisedButton(
                      child: Text("check for updates"), 
                      onPressed:()=> _getNewRelease(context, snapshot))
                ],
              );
            },
          )
        ],
      ),
    );
  }

  Widget _buildInfoTile(String title, {String subtitle}) {
    return ListTile(
      title: Text(
        title,
        textAlign: TextAlign.start,
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        subtitle ?? "",
        textAlign: TextAlign.start,
        style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600),
      ),
    );
  }

  void _getNewRelease(BuildContext context, AsyncSnapshot<PackageInfo> snapshot) {
    final informationBloc = Provider.ofType<InformationBloc>(context);

    informationBloc.releases.listen((releases) {
      if (snapshot.data.version.toString() != releases.tagName) {
        showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: Text("${snapshot.data.appName}"),
                  content: Container(
                    child: Text("A new verstion is available"),
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Download"),
                      onPressed: () => null,
                    ),
                    FlatButton(
                      child: Text("Close"),
                      onPressed: () => Navigator.of(context).pop(),
                    )
                  ],
                ));
      } else {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text("${snapshot.data.appName}"),
                  content: Container(
                    child: Text("No new version"),
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Close"),
                      onPressed: () => Navigator.of(context).pop(),
                    )
                  ],
                ));
      }
    });
  }
}
