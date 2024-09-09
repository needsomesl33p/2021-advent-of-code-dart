import 'dart:io';

List<String> readSync() {
  return File('input.txt').readAsLinesSync();
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

Future<void> main() async {
  var inputData = readSync();
  print(countIncrease(inputData));
}
