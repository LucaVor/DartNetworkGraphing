import 'dart:math';

import 'package:fitness/network/node.dart';
import 'package:flutter/material.dart';
import 'package:fitness/network/paint.dart';

// Network widget that displays a network
class Network extends StatefulWidget {
  List<NodeData> items = []; // List of nodes
  List<List<int>> connections = []; // Edges

  void addNode(NodeData nodeData) =>
      items.add(nodeData); // Adds node to network

  void addConnection(int from, int to) =>
      connections.add([from, to]); // Connects two nodes

  void Layout() {
    // Uses forces to lay out the nodes
    int springLength = 100000; // Fine tuned values
    int iterations = 100;

    double force = 0.00001;

    double c = (springLength * springLength) * force;

    // For each node, set random position
    items.forEach((element) {
      element.position = Point(
        Random().nextDouble() * 1000,
        Random().nextDouble() * 1000,
      );
    });

    // Loop through n iterations
    for (int epoch = 0; epoch < iterations; epoch++) {
      List<Point> forces = []; // Empty list of forces per node

      for (int x = 0; x < items.length; x++) {
        forces.add(Point(0, 0)); // Occupy with empty force
      }

      for (int a = 0; a < items.length; a++) {
        // For each combination of nodes
        for (int b = 0; b < items.length; b++) {
          if (a == b) continue;

          // Get force to push
          double force =
              c / pow((items[a].position - items[b].position).magnitude, 2);

          // Direction to push node
          Point dir = (items[b].position - items[a].position) * force;

          // Repel
          forces[a] -= dir;
        }
      }

      // For connected nodes
      for (List<int> connection in connections) {
        // Get connect indicies
        int a = connection[0], b = connection[1];

        // Calculate force to use to attract
        double force =
            (items[a].position - items[b].position).magnitude / springLength;

        // Direction to attract
        Point dir = (items[b].position - items[a].position) * force;

        // Attract each node
        forces[a] += dir;
        forces[b] -= dir;
      }

      // Apply forces
      for (int a = 0; a < items.length; a++) {
        items[a].position += forces[a];
      }
    }

    ApplyPerspective();
  }

  // Center nodes in the perspective
  void ApplyPerspective() {
    // highest values found in nodes
    Point upperBound = Point(-100000, -100000);
    Point lowerBound = Point(100000, 100000);

    // For each node
    for (NodeData node in items) {
      // If any axis position is greater than previously recorded
      // Set the position
      upperBound = Point(
        max(upperBound.x, node.position.x),
        max(upperBound.y, node.position.y),
      );

      // If any axis position is less than previously recorded
      // Set the position
      lowerBound = Point(
        min(lowerBound.x, node.position.x),
        min(lowerBound.y, node.position.y),
      );
    }

    // How much padding to the edges of the network
    num padding = 40;

    for (NodeData node in items) {
      // foreach node
      // Calculate where the position is along the bounds
      num xTime =
          (node.position.x - lowerBound.x) / (upperBound.x - lowerBound.x);

      num yTime =
          (node.position.y - lowerBound.y) / (upperBound.y - lowerBound.y);

      // Calculate where it should lie along the network
      num newX = padding + (500 - padding * 2) * xTime;
      num newY = padding + (500 - padding * 2) * yTime;

      // Set new positions
      node.position = Point(newX, newY);
    }
  }

  @override
  NetworkRender createState() => NetworkRender();
}

class NetworkRender extends State<Network> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 500,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 241, 241, 241),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 20,
              spreadRadius: 1,
            ),
          ]),
      child: Stack(
        children: <Widget>[
          CustomPaint(
            size: Size(500, 500),
            painter: CurvedPainter(
              offsets: widget.items.map((item) => item.position).toList(),
              edges: widget.connections,
            ),
          ),
          ...buildItems()
        ],
      ),
    );
  }

  List<Widget> buildItems() {
    final res = <Widget>[];

    widget.items.asMap().forEach((ind, item) {
      res.add(Node(
        position: item.position,
        text: item.text,
        color: item.color,
      ));
    });

    return res;
  }
}
