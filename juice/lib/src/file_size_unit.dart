import './pair.dart';

const _fileLengthUnitString = ["B", "KB", "MB", "GB"];

enum FileLengthUnit {
  B,
  KB,
  MB,
  GB,
  AUTO,
}

String fileLengthUnitToString(FileLengthUnit unit) =>
    _fileLengthUnitString[unit.index];

class FileLength {
  int _length;

  FileLength(int length, {FileLengthUnit unit = FileLengthUnit.B}) {
    switch (unit) {
      case FileLengthUnit.B:
        _length = length;
        break;
      case FileLengthUnit.KB:
        _length = length * 1024;
        break;
      case FileLengthUnit.MB:
        _length = length * 1024 * 1024;
        break;
      case FileLengthUnit.GB:
        _length = length * 1024 * 1024 * 1024;
        break;
      default:
        throw UnsupportedError("error unit");
    }
  }

  Pair<num, FileLengthUnit> length(
      {FileLengthUnit unit = FileLengthUnit.AUTO}) {
    switch (unit) {
      case FileLengthUnit.B:
        return Pair(_length, unit);
        break;
      case FileLengthUnit.KB:
        return Pair(_length / 1024, unit);
        break;
      case FileLengthUnit.MB:
        return Pair(_length / (1024 * 1024), unit);
        break;
      case FileLengthUnit.GB:
        return Pair(_length / (1024 * 1024 * 1024), unit);
        break;
      case FileLengthUnit.AUTO:
        var index = 0;
        num length = _length;
        while (length > 1024) {
          index++;
          length /= 1024;
        }
        return Pair(length, FileLengthUnit.values[index]);
        break;
      default:
        throw UnsupportedError("error unit");
    }
  }

  String lengthString({FileLengthUnit unit = FileLengthUnit.AUTO}) {
    final lengthPair = length(unit: unit);
    return lengthPair.first.toString() +
        fileLengthUnitToString(lengthPair.second);
  }
}
