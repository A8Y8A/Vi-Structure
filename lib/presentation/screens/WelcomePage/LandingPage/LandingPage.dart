import 'package:flutter/material.dart';
import 'package:project2/presentation/screens/LoginPage/login_screen.dart';
import '../../WelcomePage/HoverText.dart';

class LandingPage extends StatefulWidget {
  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool _showFirstText = false;
  bool _showSecondText = false;
  bool _showThirdText = false;
  bool _showFourthText = false;
  bool _showButton = false;

  bool _isHovered = false;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _startAnimations();
  }

  void _startAnimations() async {
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      _showFirstText = true;
    });
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      _showSecondText = true;
    });
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      _showThirdText = true;
    });
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      _showFourthText = true;
    });
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      _showButton = true;
    });
  }

  List<Widget> pageChildren(double width) {
    double height = MediaQuery.of(context).size.height;
    double width1 = MediaQuery.of(context).size.width;

    // Font size for the button, adjusted for screen width
    double buttonFontSize = width1 > 800 ? 20 : 16;

    return <Widget>[
      Container(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AnimatedOpacity(
              opacity: _showFirstText ? 1.0 : 0.0,
              duration: Duration(seconds: 1),
              child: HoverText(text: " - Video To Text."),
            ),
            SizedBox(height: height * 0.05),
            AnimatedOpacity(
              opacity: _showSecondText ? 1.0 : 0.0,
              duration: Duration(seconds: 1),
              child: HoverText(text: " - Video To Document."),
            ),
            SizedBox(height: height * 0.05),
            AnimatedOpacity(
              opacity: _showThirdText ? 1.0 : 0.0,
              duration: Duration(seconds: 1),
              child: HoverText(text: " - Download Document."),
            ),
            SizedBox(height: height * 0.05),
            AnimatedOpacity(
              opacity: _showFourthText ? 1.0 : 0.0,
              duration: Duration(seconds: 1),
              child: HoverText(text: " - Edit Your Document."),
            ),
            AnimatedOpacity(
              opacity: _showButton ? 1.0 : 0.0,
              duration: Duration(seconds: 1),
              child: Container(
                width: width1 > 800 ? width * 0.3 : width * 0.6,
                margin: EdgeInsets.only(left: width * 0.05, top: height * 0.1),
                child: MouseRegion(
                  onEnter: (_) => setState(() => _isHovered = true),
                  onExit: (_) => setState(() => _isHovered = false),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isPressed = true;
                      });
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                      Future.delayed(Duration(milliseconds: 300), () {
                        setState(() {
                          _isPressed = false;
                        });
                      });
                    },
                    child: Center(
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          color: _isPressed
                              ? Color.fromRGBO(36, 11, 54, 1.0)
                              : (_isHovered
                                  ? Color.fromRGBO(36, 11, 54, 1.0)
                                  : Color.fromRGBO(195, 20, 50, 1.0)),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          border: Border.all(
                            color: Colors.white, // Border color
                            width: 2.0, // Border width
                          ),
                          boxShadow: _isPressed
                              ? [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    blurRadius: 10,
                                    offset: Offset(0, 10),
                                  )
                                ]
                              : [],
                        ),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: height * 0.02,
                              bottom: height * 0.02,
                              left: width * 0.001,
                              right: width * 0.01,
                            ),
                            child: Text(
                              "Get Started",
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: buttonFontSize,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      if (width1 > 800)
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Image.asset(
            "assets/images/lp_image.png",
            width: width,
          ),
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 800) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: pageChildren(constraints.biggest.width / 2),
          );
        } else {
          return Column(
            children: pageChildren(constraints.biggest.width),
          );
        }
      },
    );
  }
}
