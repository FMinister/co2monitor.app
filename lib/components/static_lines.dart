import "package:collection/collection.dart";

class StaticLines {
  final double x;
  final double y;

  StaticLines({
    required this.x,
    required this.y,
  });
}

List<StaticLines> get pricePoints {
  final data = <double>[2, 4, 5, 11, 3, 6, 4];

  return data
      .mapIndexed(
          ((index, element) => StaticLines(x: index.toDouble(), y: element)))
      .toList();
}
