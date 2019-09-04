import 'package:flutter_web/material.dart';
import 'dart:math' as math;
import 'dart:async';

class Spinner extends StatefulWidget {
  @override
  _SpinnerState createState() => _SpinnerState();
}

class _SpinnerState extends State<Spinner> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    );
  }

  void _handleClick() {
    setState(() {
      _controller..repeat();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: _controller,
          child: Image.asset('wheel.png'),
          builder: (BuildContext context, Widget child) {
            return Transform.rotate(
              angle: _controller.value * 15.0 * math.pi,
              child: child,
            );
          },
        ),
        RaisedButton(
          child: Text('Draw'),
          onPressed: () async {
            _handleClick();
            await Future.delayed(const Duration(seconds: 3), () {
              dispose();
              // Navigator.pushNamed(context, '/second');
            });
          },
        ),
      ],
    );
  }
}
