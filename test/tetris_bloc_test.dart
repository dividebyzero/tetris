

import 'package:flutter/material.dart';
import 'package:tetris_blocs/core/tetris_bloc.dart';
import 'package:tetris_blocs/core/tetris_event.dart';
import 'package:tetris_blocs/core/tetris_provider.dart';

class EchoBloc extends TetrisBloc {

  String prefix ="";

  EchoBloc();

  EchoBloc.withPrefix({this.prefix});

  @override
  Stream<TetrisEvent> processEvent(TetrisEvent event) async*{
    event.type =  (this.prefix != null ? this.prefix + "echo" : "echo");
    yield event;
  }
}

class SimpleTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var bloc  = TetrisProvider.of<EchoBloc>(context);
    assert(bloc!=null);
    return Text("ok");
  }

}