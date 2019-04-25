import 'package:tetris_blocs/core/tetris_event.dart';
import 'package:rxdart/rxdart.dart';

abstract class TetrisBloc {
  PublishSubject<TetrisEvent> _inStream = PublishSubject<TetrisEvent>();
  BehaviorSubject<TetrisEvent> outStream = BehaviorSubject<TetrisEvent>();

  TetrisBloc() {
    _inStream
        .asyncExpand((TetrisEvent event) => processEvent(event))
        .forEach((TetrisEvent event) => outStream.add(event));
  }

  void dispatch(TetrisEvent event) {
    _inStream.add(event);
  }

  Stream<TetrisEvent> processEvent(TetrisEvent event);
}
