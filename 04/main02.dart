import 'dart:core';
import 'dart:io';

Future<List<String>> readAsync() async {
  return await File('input.txt').readAsLines();
}

List<List<List<String>>> generateBoards(List<String> inputData) {
  var matrix = <List<List<String>>>[];
  for (final seq in inputData) {
    if (seq.isEmpty) {
      matrix.add([]);
    } else {
      var vector = seq.replaceAll('  ', ' ').split(' ');
      vector.first.isEmpty ? vector.removeAt(0) : null;
      matrix[matrix.length - 1].add(vector);
    }
  }
  return matrix;
}

List<List<String>> transpose(List<List<String>> matrix) {
  var transposedMatrix = <List<String>>[];
  for (int i = 0; i < matrix.length; i++) {
    transposedMatrix.add(<String>[]);
  }
  for (final vector in matrix) {
    for (int idx = 0; idx < vector.length; idx++) {
      transposedMatrix[idx].add(vector[idx]);
    }
  }

  return transposedMatrix;
}

bool isListContainsAll(List<List<String>> board, List<String> pool) {
  for (final sequence in board) {
    final poolSet = Set.of(pool);
    if (poolSet.containsAll(sequence)) {
      return true;
    }
  }
  return false;
}

List<int> getUnmarkedNumbers(
    List<List<String>> board, List<String> drawNumbers) {
  var mergedBoard = <String>[];
  var unmarkedNumberes = <int>[];
  for (final sequence in board) mergedBoard.addAll(sequence);
  for (final number in mergedBoard) {
    !drawNumbers.contains(number)
        ? unmarkedNumberes.add(int.parse(number))
        : null;
  }
  return unmarkedNumberes;
}

int calcScore(List<int> sequence, String winNumber) {
  int sum = 0;
  for (final number in sequence) sum += number;
  return sum * int.parse(winNumber);
}

int getBingoScore(List<List<List<String>>> boards, List<String> drawNumbers) {
  var start = 0, end = 4;
  var initPool = drawNumbers.getRange(start, end);
  var pool = initPool.toList(growable: true);
  var lastBoard = <List<String>>[];
  var boardHashTable = [], currentPool = <String>[];
  drawNumbers.removeRange(start, end);
  for (final winNumber in drawNumbers) {
    pool.add(winNumber);
    for (final board in boards) {
      var transposedBoard = transpose(board);
      var isWinner = isListContainsAll(board, pool);
      var isTransposedWinner = isListContainsAll(transposedBoard, pool);
      if (isWinner && !boardHashTable.contains(board.hashCode) ||
          isTransposedWinner && !boardHashTable.contains(board.hashCode)) {
        boardHashTable.add(board.hashCode);
        lastBoard = board;
        currentPool = pool.getRange(0, pool.length).toList();
      }
    }
  }
  return calcScore(getUnmarkedNumbers(lastBoard, currentPool),
      currentPool[currentPool.length - 1]);
}

Future<void> main() async {
  var inputData = await readAsync();
  var drawNumbers = inputData[0].split(',');
  inputData.removeAt(0);
  var boards = generateBoards(inputData);
  print(getBingoScore(boards, drawNumbers));
}
