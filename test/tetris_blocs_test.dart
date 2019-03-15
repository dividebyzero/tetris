import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tetris_blocs/core/tetris_builder.dart';

import 'package:tetris_blocs/tetris_blocs.dart';

import 'tetris_bloc_test.dart';

void main() {
  /*
  test('adds one to input values', () {
    final calculator = Calculator();
    expect(calculator.addOne(2), 3);
    expect(calculator.addOne(-7), -6);
    expect(calculator.addOne(0), 1);
    expect(() => calculator.addOne(null), throwsNoSuchMethodError);
  });
  */


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
