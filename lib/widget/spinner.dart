import 'package:flutter_web/material.dart';
import 'dart:math' as math;

class Spinner extends StatelessWidget {
  Spinner({Key key, this.controller, this.onChanged}) : super(key: key);

  final AnimationController controller;
  final onChanged;

  void _handlePress() {
    onChanged();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: _handlePress,
          child: AnimatedBuilder(
            animation: controller,
            child: Image.asset(
              'images/wheel.png',
              height: 300,
              width: 300,
            ),
            builder: (BuildContext context, Widget child) {
              return Transform.rotate(
                angle: controller.value * 15.0 * math.pi,
                child: child,
              );
            },
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 20),
          child: RaisedButton(
            child: Text('Draw'),
            onPressed: _handlePress,
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
          ),
        ),
      ],
    );
  }
}
