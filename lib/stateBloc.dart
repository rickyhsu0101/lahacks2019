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
// Random Colour generator
// Color getRandomColor() {
//   Random _random = Random();
//   return Color.fromARGB(
//     _random.nextInt(256),
//     _random.nextInt(256),
//     _random.nextInt(256),
//     _random.nextInt(256),
//   );
// }