import 'dart:core';
import 'dart:io';

Future<List<String>> readAsync() async {
  return await File('input.txt').readAsLines();
}

int countIncrease(List<String> inputData) {
  var numberOfIncrease = 0;
  for (int i = 0; i < inputData.length - 1; i++) {
    if (int.parse(inputData[i]) < int.parse(inputData[i + 1])) {
      numberOfIncrease++;
    }
  }
  return numberOfIncrease;
}

int convertGroups(Iterable<String> group) {
  var sum = 0;
  for (final number in group) {
    sum += int.parse(number);
  }
  return sum;
}

int countSlideWindowSum(List<String> inputData) {
  var numberOfIncrease = 0;
  for (int i = 0; i < inputData.length - 3; i++) {
    var groupOne = inputData.getRange(i, i + 3);
    var groupTwo = inputData.getRange(i + 1, i + 4);
    if (convertGroups(groupOne) < convertGroups(groupTwo)) {
      numberOfIncrease++;
    }
  }
  return numberOfIncrease;
}

Future<void> main() async {
  var inputData = await readAsync();
  print(countIncrease(inputData));
  print(countSlideWindowSum(inputData));
}
