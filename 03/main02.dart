import 'dart:core';
import 'dart:io';

Future<List<String>> readAsync() async {
  return await File('input.txt').readAsLinesSync();
}

String getCommonValue(String mode, List<String> matrix, int position) {
  var numberOfOnes = 0;
  for (final item in matrix) {
    var digits = item.split('');
    digits[position] == '1' ? numberOfOnes++ : numberOfOnes;
  }
  if (mode == 'O2') {
    return numberOfOnes >= matrix.length / 2 ? '1' : '0';
  } else {
    return numberOfOnes < matrix.length / 2 ? '1' : '0';
  }
}

String getRating(
  String mode,
  List<String> matrix,
  int position,
) {
  var tempList = <String>[];
  var commonValue = getCommonValue(mode, matrix, position);
  for (final item in matrix) {
    var digits = item.split('');
    if (digits[position] == commonValue) {
      tempList.add(item);
    }
  }
  position++;
  matrix = tempList;
  if (matrix.length == 1) {
    return matrix[0];
  }
  return getRating(mode, tempList, position);
}

Future<void> main() async {
  var inputData = await readAsync();
  var O2GeneratorRating = getRating('O2', inputData, 0);
  var CO2ScrubberRating = getRating('CO2', inputData, 0);
  print(int.parse(O2GeneratorRating, radix: 2) *
      int.parse(CO2ScrubberRating, radix: 2));
}
