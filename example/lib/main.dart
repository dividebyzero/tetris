import 'package:flutter/material.dart';
import 'package:tetris_blocs/tetris_blocs.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: TetrisProvider(
          child: MyHomePage(title: 'Tetris Blocs Demo Home Page'),
          blocs: [CounterBloc()]
      )

    );
  }
}
// This is our BLoC
// It holds the state of the counter
class CounterBloc extends TetrisBloc {
  int counter = 0;
  @override
  Stream<TetrisEvent> processEvent(TetrisEvent event) async*{
    //because we only ever handle one event, we can act on it directly
    debugPrint("increment counter");
    counter++;
    yield TetrisEvent.withPayload(action: "counter_update",payload: counter);
  }

}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is STATEFULL, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.
  @override

  final String title;

  @override
  State<StatefulWidget> createState ()=> new MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    //retrieve out BLoC from the provider
    TetrisBloc counterBloc = TetrisProvider.of(context);
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      // the TetrisBuilder is a Wrapper Component similar to StreamBuilder.
      // it will rebuild the widget tree every time it receives an event from the BLoC
      body: TetrisBuilder(
        blocs: [counterBloc], // a List of BLoCs you want to listen to
        builder: (BuildContext context, TetrisEvent event) {
          debugPrint("builder build");
          return Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Column(
              // Column is also layout widget. It takes a list of children and
              // arranges them vertically. By default, it sizes itself to fit its
              // children horizontally, and tries to be as tall as its parent.
              //
              // Invoke "debug painting" (press "p" in the console, choose the
              // "Toggle Debug Paint" action from the Flutter Inspector in Android
              // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
              // to see the wireframe for each widget.
              //
              // Column has various properties to control how it sizes itself and
              // how it positions its children. Here we use mainAxisAlignment to
              // center the children vertically; the main axis here is the vertical
              // axis because Columns are vertical (the cross axis would be
              // horizontal).
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  event.payload.toString(), // The payload is a Number, so we can show it as Text
                  style: Theme
                      .of(context)
                      .textTheme
                      .display1,
                ),
              ],
            ),
          );
        }),
      floatingActionButton: FloatingActionButton(
        //here we send an event to our bloc requesting a counter update
        onPressed: (){counterBloc.dispatch(TetrisEvent.withAction(action: "counter_update"));},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
