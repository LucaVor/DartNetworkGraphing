import 'dart:math';

import 'package:flutter/material.dart';

class Node extends StatefulWidget {
  Node({
    super.key,
    required this.position,
    required this.text,
  });

  Point position; // position of node
  String text; // text within node

  final double nodeDiameter = 60; // diameter of node

  @override
  State<Node> createState() => _NodeState();
}

class _NodeState extends State<Node> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
        left: widget.position.x - widget.nodeDiameter / 2,
        top: widget.position.y - widget.nodeDiameter / 2,
        child: Container(
          width: widget.nodeDiameter,
          height: widget.nodeDiameter,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 0, 218, 233),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 194, 194, 194),
                blurRadius: 15,
                spreadRadius: 1,
              ),
            ],
            border: Border.all(
              color: Color.fromARGB(255, 0, 0, 0),
              width: 3,
            ),
          ),
          child: Center(
            child: Text(widget.text),
          ),
        ),
      ),
    ]);
  }
}

class NodeData {
  NodeData({
    required this.position,
    required this.text,
  });

  Point position;
  String text;
}
