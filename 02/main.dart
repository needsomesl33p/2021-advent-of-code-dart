import 'dart:core';
import 'dart:io';

Future<List<String>> readAsync() async {
  return await File('input.txt').readAsLines();
}

int getCoordinates(List<String> inputData) {
  var vertical = 0;
  var horizontal = 0;
  for (final instrument in inputData) {
    var direction = instrument.split(' ')[0];
    var unit = instrument.split(' ')[1];
    if (direction == 'up') {
      vertical -= int.parse(unit);
    } else if (direction == 'down') {
      vertical += int.parse(unit);
    } else {
      horizontal += int.parse(unit);
    }
  }
  return horizontal * vertical;
}

Future<void> main() async {
  var inputData = await readAsync();
  print(getCoordinates(inputData));
}
