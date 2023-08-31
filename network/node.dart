import 'dart:math';

import 'package:flutter/material.dart';

class Node extends StatefulWidget {
  Node({
    super.key,
    required this.position,
    required this.text,
    required this.color,
  });

  Point position; // position of node
  String text; // text within node
  Color color; // color of node

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
            color: widget.color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: widget.color,
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ],
            border: Border.all(
              color: Color.fromARGB(255, 57, 57, 57),
              width: 3,
            ),
          ),
          child: Center(
            child: Text(
              widget.text,
              style: TextStyle(
                fontSize: 10,
              ),
            ),
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
    required this.color,
  });

  Point position;
  String text;
  Color color;
}
