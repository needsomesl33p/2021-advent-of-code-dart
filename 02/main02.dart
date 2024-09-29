import 'dart:core';
import 'dart:io';

Future<List<String>> readAsync() async {
  return await File('input.txt').readAsLines();
}

int getCoordinates(List<String> inputData) {
  var aim = 0;
  var horizontal = 0;
  var depth = 0;
  for (final instrument in inputData) {
    var direction = instrument.split(' ')[0];
    var unit = instrument.split(' ')[1];
    if (direction == 'up') {
      aim -= int.parse(unit);
    } else if (direction == 'down') {
      aim += int.parse(unit);
    } else {
      horizontal += int.parse(unit);
      depth = depth + aim * int.parse(unit);
    }
  }
  return horizontal * depth;
}

Future<void> main() async {
  var inputData = await readAsync();
  print(getCoordinates(inputData));
}
