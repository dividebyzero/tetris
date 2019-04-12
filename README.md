# Tetris
BLoCs for Flutter made easy.

[![Build Status](https://travis-ci.com/dividebyzero/tetris.svg?branch=master)](https://travis-ci.com/dividebyzero/tetris)


## Goals
### __Simplicity__
  Write the Code you need with as minimal Boilerplate as possible
### __RxDart Syntax__
  Feel at Home
### __Flexibility__
  Be usefull everywhere, even in now-unknown places
### __Chaining__
  > Yo dawg, I heard you like Blocs, so I put some Blocs in your Blocs, so now you can play Tetris while playing Tetris
 
 (soon)  
 
## API

### TetrisEvent(action, payload)
An Event happening in your App, originating by UI or somewhere else.
TetrisEvents are fully described by 
 - String  action  The action you expect to happen 
 - String  type  Optional Type of event 
 - dynamic payload Any type of Object you want to process

### TetrisBloc
A TetrisBloc is an asynchronous Event Processor. 
It handles events sourced through 
``` 
MyTetrisBloc.dispatch(TetrisEvent.withAction(action:"MyAction")); 
``` 
in its 
```
Stream<TetrisEvent> processEvent(TetrisEvent event)
``` 
function and yields a (new) event as a result.


### TetrisProvider
TetrisProvicer is a DI Container that provides instances of your TetrisBloc's to Widgets in your App.  
A Provider can hold multiple BLoCs and you can have multiple Providers in your App. 
To retrieve a BLoC from the Provider call 
```
var bloc = TetrisProvider.of<MyBloc>(context) 
``` 

### TetrisBuilder
TetrisBuilder is similar to StreamBuilder in that it will rebuild your Widgets on incoming TetrisEvents
A Single Builder can receive Events from multiple BLoCs. It has a withFilter Constructor that allows you to drop Events that are not of interest.
```
TetrisBuilder.withFilter(
      blocs: [myFirstBloc, mySecondBloc],
      builder: (BuildContext context, TetrisEvent event) { return Text(event.action) },
      filter: (TetrisEvent event){ return event.action == "accept"; }
      ); 
```
 
## Examples
 
 ### Loading a List
 With __Simplicity__ in Mind, loading a List is down to two lines of code.
 To Trigger the Action:
 ```
  TetrisProvider.of<MyTetrisBloc>(context).dispatch(TetrisEvent.withAction("loadList")
 ```
 And the full implementation of the Bloc is this:
 ```
 class MyTetrisBloc extends TetrisBloc {
    Stream<TetrisEvent> processEvent(TetrisEvent event) async* {
      yield TetrisEvent.withPayload("loadList",[1,3,5,7]);
    }
}
 ```
 
 #### Example Project
 The classic "Button Clicker" Example is [here](https://github.com/dividebyzero/tetris_example)
 
 #### Contributors
 * @dividebyzero :shipit:
 * *Your name here ?*
