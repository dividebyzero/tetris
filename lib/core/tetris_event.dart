

class TetrisEventTypes {
  static const String EMPTY = "EMPTY";
  static const String OTHER = "OTHER";
  static const String ERROR = "ERROR";
}

class TetrisEvent {

  String action;

  dynamic payload;

  String type;

  TetrisEvent({this.action, this.type, this.payload}):
        assert(action!=null),
        assert(type!=null);


  TetrisEvent.withAction({this.action}){
    assert(action!=null);
    this.type = TetrisEventTypes.OTHER;
  }

  TetrisEvent.withPayload({this.action, this.payload}){
    assert(payload!=null);
    assert(action!=null);
    this.type = TetrisEventTypes.OTHER;
  }

  TetrisEvent.Empty(){
    this.type = TetrisEventTypes.EMPTY;
  }

}