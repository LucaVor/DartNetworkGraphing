import 'dart:math';

import 'package:flutter/material.dart';

class CurvedPainter extends CustomPainter {
  CurvedPainter({
    required this.offsets,
    required this.edges,
  });

  // Node positions
  List<Point> offsets;
  // Node connections
  List<List<int>> edges;

  @override
  void paint(Canvas canvas, Size size) {
    edges.asMap().forEach((index, offset) {
      // For each connection
      // Draw line between positions
      canvas.drawLine(
        Offset(offsets[edges[index][0]].x as double,
            offsets[edges[index][0]].y as double),
        Offset(offsets[edges[index][1]].x as double,
            offsets[edges[index][1]].y as double),
        Paint()
          ..color = Color.fromARGB(255, 221, 221, 221)
          ..strokeWidth = 4,
      );
    });
  }

  @override
  bool shouldRepaint(CurvedPainter oldDelegate) => true;
}
