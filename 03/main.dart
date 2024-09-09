import 'dart:core';
import 'dart:io';

Future<List<String>> readAsync() async {
  return await File('input.txt').readAsLinesSync();
}

List<String> initMatrix(List<String> inputData) {
  var helperList = <String>[];
  var firstLine = inputData.first;
  for (final char in firstLine.split('')) {
    helperList.add(char);
  }
  return helperList;
}

List<String> createtransposeMatrix(List<String> inputData) {
  var matrix = initMatrix(inputData);
  for (final line in inputData) {
    for (int i = 0; i < line.length; i++) {
      matrix[i] += line[i];
    }
  }
  return matrix;
}

String getGammaRate(List<String> matrix) {
  var binary = '';
  var maxNumber = matrix[0].length;
  var numberOfOnes;
  for (final line in matrix) {
    numberOfOnes = '1'.allMatches(line).length;
    var digit = (maxNumber / 2 < numberOfOnes) ? '1' : '0';
    binary += digit;
  }
  return binary;
}

String getEpsilonRate(String gammaRate) {
  var binary = '';
  var digits = gammaRate.split('');
  for (final digit in digits) {
    var inverseDigit = digit == '0' ? '1' : '0';
    binary += inverseDigit;
  }
  return binary;
}

Future<void> main() async {
  var inputData = await readAsync();
  var transposeMatrix = createtransposeMatrix(inputData);
  var gammaRate = getGammaRate(transposeMatrix);
  var epsilonRate = getEpsilonRate(gammaRate);
  print(int.parse(gammaRate, radix: 2) * int.parse(epsilonRate, radix: 2));
}
