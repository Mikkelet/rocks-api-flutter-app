import 'package:flutter/material.dart';
import 'package:tensoradvancedproject/blocs/contribution_bloc.dart';
import 'package:tensoradvancedproject/models/model.dart';

class ListPage extends StatelessWidget {
  final ContributionBloc bloc;
  final String pageName;

  const ListPage({Key key, this.bloc, this.pageName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bloc.pageName.add(pageName);
    return StreamBuilder(
        stream: bloc.results,
        builder:
            (BuildContext context, AsyncSnapshot<List<Contribution>> snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );

          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                              "https://steemitimages.com/u/${snapshot.data[index].author}/avatar"
                            )
                          )
                        ),
                      ),
                    ),
                    title: Text("${snapshot.data[index].title}",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.left,
                    ),
                  ),
                );
              });
        });
  }
}
