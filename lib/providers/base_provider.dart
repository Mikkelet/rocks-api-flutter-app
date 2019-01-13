import 'package:flutter/material.dart';

Type _getType<B>() => B;

class Provider<B> extends InheritedWidget {
  final B bloc;
  
  const Provider({
    Key key, 
    this.bloc,
    Widget child
    }) : super(key: key, child: child);
  
  static Provider of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(Provider)as Provider);
  }

  @override
  bool updateShouldNotify( Provider oldWidget) {
    return oldWidget.bloc != bloc;
  }


  static B ofType<B>(BuildContext context)
  {
    final type = _getType<Provider<B>>();
    final Provider<B> provider = context.inheritFromWidgetOfExactType(type);

    return provider.bloc;
  }
}

class BlocProvider<B> extends StatefulWidget{
  final void Function(BuildContext context, B bloc) onDispose;
  final B Function(BuildContext context, B bloc) builder;
  final Widget child;

  const BlocProvider({Key key, 
  @required this.onDispose, 
  @required this.builder, 
  @required this.child}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BlocProviderState();


}

class _BlocProviderState<B> extends State<BlocProvider<B>>{
  B bloc;

  @override
    void initState() {
      super.initState();
      if(widget.builder!=null)
        bloc = widget.builder(context,bloc);
      
    }

    @override
      void dispose() {
        if(widget.onDispose != null){
          widget.onDispose(context,bloc);
        }
        super.dispose();
      }

  @override
  Widget build(BuildContext context) {
   return Provider(
     bloc: bloc,
     child: widget.child,
   );
  }
}