import 'dart:async';
import 'package:http/http.dart' as http;
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
  bool done  = false;
  FormBloc(){
    formData.putIfAbsent('Image', ()=>"");
    formData.putIfAbsent('Type of Food', ()=> "");
    formData.putIfAbsent('Description', ()=> "");
    formData.putIfAbsent('Location', ()=> "");
  }

  StreamController streamListController = StreamController<Map<String, String>>.broadcast();

  Sink get dataSink => streamListController.sink;

  Stream<Map<String,String>> get pageStream => streamListController.stream;

  Stream<Map<String, String>> get formStream => streamListController.stream;

  submitData(){
    if(!formData.containsValue('')){
       
    }
  }
  changeForm(String key, String value) async{
    formData[key] = value;
    //print(formData);
    //print(formData.containsValue(''));
  
    
  }
}
