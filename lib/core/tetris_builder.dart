


import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tetris_blocs/core/tetris_bloc.dart';
import 'package:tetris_blocs/core/tetris_event.dart';

/// same as a [StreamBuilder] builder Function
typedef TetrisWidgetBuilder = Widget Function(BuildContext context, TetrisEvent event);
/// filter events, return true to keep, false to drop
typedef TetrisEventFilter = bool Function(TetrisEvent event);

class TetrisBuilder extends TetrisBuilderCore{

  final TetrisWidgetBuilder builder;
  final List<TetrisBloc> blocs;
  final TetrisEventFilter filter;

  TetrisBuilder({Key key, @required this.blocs, @required this.builder}):
        assert(blocs != null),
        assert(builder != null),
        this.filter = ((TetrisEvent event)=> true),
        super(key:key, blocs:blocs);


  TetrisBuilder.withFilter({Key key, @required this.blocs, @required this.builder, @required this.filter}):
        assert(blocs != null),
        assert(builder != null),
        assert(filter != null),
        super.withFilter(key:key, blocs:blocs, filter: filter);


  @override
  Widget build(BuildContext context, TetrisEvent event) => builder(context, event);

}


abstract class TetrisBuilderCore extends StatefulWidget{

  final List<TetrisBloc> blocs;
  final TetrisEventFilter filter;

  const TetrisBuilderCore({Key key, this.blocs}):
        filter = null,
        super(key: key);

  const TetrisBuilderCore.withFilter({Key key, this.blocs, this.filter}) : super(key: key);


  @override
  State<TetrisBuilderCore> createState() => _TetrisBuilderCoreState();

  Widget build(BuildContext context,TetrisEvent event);

}

class _TetrisBuilderCoreState extends State<TetrisBuilderCore> {

  TetrisEvent _event;
  StreamSubscription  _subscription;

  @override void initState() {
    _event = TetrisEvent.empty();
    subscribeToEvents();
    super.initState();
  }

  @override void dispose() {
    unsubscribeFromEvents();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //propagate event upwards.
    return widget.build(context, _event);
  }

  void subscribeToEvents() {
    this._subscription = new Observable<TetrisEvent>
        .merge(this.widget.blocs.map((bloc) => bloc.outStream.stream))
        .where((TetrisEvent event) => applyFilter(event))
        .listen((TetrisEvent event) => processEvent(event));
  }

  bool applyFilter(TetrisEvent event) {
    if(this.widget.filter!=null){
      return this.widget.filter(event);
    }
    return true;
  }

  void processEvent(TetrisEvent event) {
    //ensure we're not disposed,
    if(mounted) {
      setState(() {
        //briefly store the event in state
        this._event = event;
      });
    }
  }

  void unsubscribeFromEvents(){
    this._subscription.cancel();
    this._subscription = null;
  }

}