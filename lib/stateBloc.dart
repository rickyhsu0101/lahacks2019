import 'dart:async';
class StateBloc {
// streams of Color
  StreamController streamListController = StreamController<int>.broadcast();
// sink
  Sink get dataSink => streamListController.sink;
// stream
  Stream<int> get pageStream => streamListController.stream;

// function to change the color
  changePage(int pageNum) {
    dataSink.add(setPage(pageNum));
  }
}
int setPage(int pageNum){
  return pageNum;
}
class FormBloc {
  final Map<String, String> formData = new Map<String, String>();
  FormBloc(){
    formData.putIfAbsent('Type of Food', ()=> "");
    formData.putIfAbsent('Description', ()=> "");
    formData.putIfAbsent('Location', ()=> "0,0");
  }

  StreamController streamListController = StreamController<Map<String, String>>.broadcast();

  Sink get dataSink => streamListController.sink;

  Stream<Map<String, String>> get formStream => streamListController.stream;

  changeForm(String key, String value){
    formData[key] = value;
    print(formData);
  }
}
