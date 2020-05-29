import 'package:flutter/material.dart';

class ContainerBimby extends StatelessWidget {
  final Widget child;

  ContainerBimby(this.child);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              color: Colors.grey, offset: Offset(0.0, 1.0), blurRadius: 1.0)
        ]),
        child: child);
  }
}
