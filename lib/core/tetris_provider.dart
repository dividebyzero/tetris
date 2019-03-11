

import 'package:flutter/widgets.dart';
import 'package:tetris_blocs/core/tetris_bloc.dart';

class TetrisProvider extends InheritedWidget{

  final ObjectKey key = new ObjectKey(TetrisProvider);
  final Widget child;
  final List<TetrisBloc> blocs;

  TetrisProvider({@required this.child, @required this.blocs}):
    assert(child!=null),
    assert(blocs != null),
    super(key:new ObjectKey(TetrisProvider));


  static T of<T extends TetrisBloc>(BuildContext context) {
    TetrisProvider provider = context.ancestorInheritedElementForWidgetOfExactType(TetrisProvider).widget;

    if(provider == null){
      throw FlutterError(
        """
        TetrisProvider.of() called with a context that does not contain TetrisProvider.
        TetrisProvider should be instanciated on the App Root exactly once.
        The context used was: $context
        """,
      );
    }

    TypeMatcher<T> typeMatcher = TypeMatcher();

    return provider.blocs.firstWhere((bloc) => typeMatcher.check(bloc)) as T;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

}