

import 'package:tetris_blocs/core/tetris_bloc.dart';
import 'package:tetris_blocs/core/tetris_event.dart';

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