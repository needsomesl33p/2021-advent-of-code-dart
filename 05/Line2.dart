import 'Point.dart';

class Line {
  Point startPoint;
  Point endPoint;

  Line(this.startPoint, this.endPoint);

  bool _isHorizontal() => startPoint.y == endPoint.y;
  bool _isVertical() => startPoint.x == endPoint.x;
  bool _isXAscent() => startPoint.x < endPoint.x;
  bool _isYAscent() => startPoint.y < endPoint.y;
  int _getDistance() => (startPoint.x - endPoint.x).abs();

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
    } else if (_isVertical()) {
      (int, int) record = _sortVerticalCoords();
      int first = record.$1, last = record.$2;
      for (first; first <= last; first++) {
        diagram[first][startPoint.x]++;
      }
    } else if (_isXAscent() && _isYAscent()) {
      for (int i = 0; i <= _getDistance(); i++) {
        diagram[startPoint.y + i][startPoint.x + i]++;
      }
    } else if (!_isXAscent() && _isYAscent()) {
      for (int i = 0; i <= _getDistance(); i++) {
        diagram[startPoint.y + i][startPoint.x - i]++;
      }
    } else if (_isXAscent() && !_isYAscent()) {
      //
      for (int i = 0; i <= _getDistance(); i++) {
        diagram[startPoint.y - i][startPoint.x + i]++;
      }
    } else if (!_isXAscent() && !_isYAscent()) {
      for (int i = 0; i <= _getDistance(); i++) {
        diagram[startPoint.y - i][startPoint.x - i]++;
      }
    }
  }
}
