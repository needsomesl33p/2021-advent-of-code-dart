import 'dart:core';
import 'dart:io';
import 'Line.dart';
import 'Point.dart';

Future<List<String>> readAsync() async {
  return await File('input.txt').readAsLines();
}

List<List<int>> initList({int end = 999}) {
  var tempList = <List<int>>[];
  var line = <int>[];
  for (int j = 0; j <= end; j++) line.add(0);
  for (int i = 0; i <= end; i++) tempList.add(List.from(line));
  return tempList;
}

List<Line> getLines(List<String> inputData) {
  List<Line> lines = [];
  for (final data in inputData) {
    var points = data.split(' -> ');
    var startPoint = points[0].split(',');
    var endPoint = points[1].split(',');
    lines.add(Line(Point(int.parse(startPoint[0]), int.parse(startPoint[1])),
        Point(int.parse(endPoint[0]), int.parse(endPoint[1]))));
  }
  return lines;
}

Future<void> main() async {
  var inputData = await readAsync();
  var diagMatrix = initList();
  var lines = getLines(inputData);
  for (final line in lines) {
    line.updateDiagram(diagMatrix);
  }
  var sum = 0;
  for (final line in diagMatrix) {
    for (final number in line) {
      if (number >= 2) sum++;
    }
  }
  print(sum);
  assert(sum == 0);
}
