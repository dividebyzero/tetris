import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tetris_blocs/core/tetris_builder.dart';

import 'package:tetris_blocs/tetris_blocs.dart';

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

void main() {


  testWidgets("BlocBuilderForwardsEvents", (WidgetTester tester) async {

      var myBloc = EchoBloc();

      var builderToTest = TetrisBuilder(
        blocs: [myBloc],
        builder: (BuildContext context, TetrisEvent event) {
          if(event!=null && event.action != null ) {
            print("action="+event.action);
            return MaterialApp(
                home: Scaffold(
                  body: Text(event.action)
              ));
          }else {
            print("no action");
            return MaterialApp(
              home: Container()
            );
          }
        },
      );

      await tester.pumpWidget(builderToTest);

      myBloc.dispatch(TetrisEvent.withAction(action:"test"));
      await tester.pumpAndSettle();

      final finder = find.text("test");
      expect(finder, findsWidgets);



  });


  testWidgets("Provider gives right bloc", (WidgetTester tester)async {
    var myBloc  = EchoBloc();

    var providerToTest = TetrisProvider(
        child: MaterialApp(
          home: Scaffold(
            body: SimpleTest()
          )
        ),
        blocs: [myBloc]
    );

    await tester.pumpWidget(providerToTest);
    final finder = find.text("ok");
    expect(finder, findsWidgets);
  });


}
