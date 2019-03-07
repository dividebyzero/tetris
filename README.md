# tetris
Blocs for Flutter made easy



## Goals
 ### __Simplicity__
  Write the Code you need with as minimal Boilerplate as possible
 ### __RxDart Syntax__
  Feel at Home
 ### __Flexibility__
  Be usefull everywhere, even in now-unknown places
 ### __Chaining__
  > Yo dawg, I heard you like Blocs, so I put some Blocs in your Blocs, so now you can play Tetris while playing Tetris
  
 ##   API

TetrisEvent(action, payload)

TetrisBloc

TetrisProvider

TetrisBuilder.WithFilter
 
 
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
    Observable<TetrisEvent> processEvent(TetrisEvent event) async* {
      yield TetrisEvent.withPayload("loadList",[1,3,5,7]);
    }
}
 ```
 
 #### Contributors
 * @dividebyzero :shipit:
 * *Your name here ?*
