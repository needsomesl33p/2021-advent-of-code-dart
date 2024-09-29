import 'Point.dart';

class Line {
  Point startPoint;
  Point endPoint;

  Line(this.startPoint, this.endPoint);

  bool _isHorizontal() => startPoint.y == endPoint.y;
  bool _isVertical() => startPoint.x == endPoint.x;

  (int, int) _sortHorizontalCoords() {
    var isForward = startPoint.x < endPoint.x;
    var first = isForward ? startPoint.x : endPoint.x;
    var last = isForward ? endPoint.x : startPoint.x;
    return (first, last);
  }

  (int, int) _sortVerticalCoords() {
    var isForward = startPoint.y < endPoint.y;
    var first = isForward ? startPoint.y : endPoint.y;
    var last = isForward ? endPoint.y : startPoint.y;
    return (first, last);
  }

  void updateDiagram<T>(List<List<int>> diagram) {
    if (_isHorizontal()) {
      (int, int) record = _sortHorizontalCoords();
      int first = record.$1, last = record.$2;
      for (first; first <= last; first++) {
        diagram[startPoint.y][first]++;
      }
    }
    if (_isVertical()) {
      (int, int) record = _sortVerticalCoords();
      int first = record.$1, last = record.$2;
      for (first; first <= last; first++) {
        diagram[first][startPoint.x]++;
      }
    }
  }
}
