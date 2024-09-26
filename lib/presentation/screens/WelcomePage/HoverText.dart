import 'package:flutter/material.dart';

class HoverText extends StatefulWidget {
  final String text;

  HoverText({required this.text});

  @override
  _HoverTextState createState() => _HoverTextState();
}

class _HoverTextState extends State<HoverText> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          gradient: _isHovered
              ? LinearGradient(
                  colors: [
                    Color.fromRGBO(36, 11, 54, 1.0),
                    Color.fromRGBO(195, 20, 50, 1.0),
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                )
              : null,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          widget.text ?? '',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 24,
            color: _isHovered ? Colors.white : Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
  }
}
