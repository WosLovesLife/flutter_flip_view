import 'package:flutter/material.dart';
import 'package:flutter_flip_view/flutter_flip_view.dart';

void main() => runApp(MaterialApp(
      home: SimpleFlip()
    ));

class SimpleFlip extends StatefulWidget {
    @override
    _SimpleFlipState createState() => _SimpleFlipState();
}

class _SimpleFlipState extends State<SimpleFlip> with SingleTickerProviderStateMixin {
    AnimationController _animationController;
    Animation<double> _curvedAnimation;

    GlobalKey _frontKey = GlobalKey();
    Size _backSize = Size.zero;

    @override
    void initState() {
        super.initState();

        _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 1000));
        _curvedAnimation = CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);

        WidgetsBinding.instance.addPostFrameCallback(_afterFrame);
    }

    _afterFrame(_) {
        final reverseSize = _frontKey.currentContext?.size;
        if (reverseSize == null || reverseSize.isEmpty) {
            WidgetsBinding.instance.addPostFrameCallback(_afterFrame);
        } else {
            setState(() {
                _backSize = reverseSize;
            });
        }
    }

    @override
    void dispose() {
        _animationController.dispose();
        super.dispose();
    }

    void _flip(bool reverse) {
        if (_animationController.isAnimating) return;
        if (reverse) {
            _animationController.forward();
        } else {
            _animationController.reverse();
        }
    }

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            home: Scaffold(
                body: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                        child: FlipView(
                            animationController: _curvedAnimation,
                            front: _buildFrontSide(),
                            back: _buildBackSide(),
                        ),
                    ),
                ),
            ),
        );
    }

    Widget _buildFrontSide() {
        return AspectRatio(
            key: _frontKey,
            aspectRatio: 0.7,
            child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                            colors: [
                                Color(0xff92ffc0),
                                Color(0Xff002661),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                        ),
                    ),
                    child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                            splashColor: Colors.white.withOpacity(0.1),
                            highlightColor: Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                            onTap: () => _flip(true),
                            child: Center(
                                child: Container(
                                    width: 48,
                                    height: 48,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(60),
                                        color: Colors.amber,
                                    ),
                                    child: Text(
                                        'A',
                                        style:
                                        TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
                                    ),
                                ),
                            ),
                        ),
                    ),
                ),
            ),
        );
    }

    Widget _buildBackSide() {
        print(_backSize);
        return SizedBox(
            width: _backSize.width,
            height: _backSize.height,
            child: Card(
                color: Colors.blueGrey,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                            colors: [
                                Color(0xff92ffc0),
                                Color(0Xff002661),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                        ),
                    ),
                    child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                            splashColor: Colors.white.withOpacity(0.1),
                            highlightColor: Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                            onTap: () => _flip(false),
                            child: Center(
                                child: Container(
                                    width: 48,
                                    height: 48,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(60),
                                        color: Colors.amber,
                                    ),
                                    child: Text(
                                        'B',
                                        style:
                                        TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
                                    ),
                                ),
                            ),
                        ),
                    ),
                ),
            ),
        );
    }
}
