import 'package:flutter_web/material.dart';

import 'widget/spinner.dart';

class FirstRoute extends StatefulWidget {
  @override
  _FirstRouteState createState() => _FirstRouteState();
}

class _FirstRouteState extends State<FirstRoute>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    );
  }

  void _handleClick() async {
    setState(() {
      _controller..repeat();
    });
    await Future.delayed(const Duration(seconds: 3), () {
      _controller..stop();
      Navigator.pushNamed(context, '/award');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lucky Draw Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spinner(
              controller: _controller,
              onChanged: _handleClick,
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
