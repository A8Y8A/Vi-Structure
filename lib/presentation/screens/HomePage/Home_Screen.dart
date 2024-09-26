import 'package:flutter/material.dart';
import 'package:project2/presentation/screens/HomePage/My_Drive.dart';
import 'package:project2/presentation/screens/HomePage/My_Notes.dart';
import 'package:project2/presentation/screens/LoginPage/login_screen.dart';

import 'package:sidebarx/sidebarx.dart';

import 'New.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

const primaryColor = Color(0xFF2E2E48);
const canvasColor = Colors.deepPurple;
const scaffoldBackgroundColor = Color(0xFF7777B6);

class _MyHomePageState extends State<MyHomePage> {
  final _controller = SidebarXController(selectedIndex: 0, extended: true);
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return SafeArea(
      child: Scaffold(
        key: _key,
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          leading: isSmallScreen
              ? IconButton(
                  onPressed: () {
                    _key.currentState?.openDrawer();
                  },
                  icon: Icon(Icons.menu),
                )
              : null,
          title: Row(
            children: [
              if (!isSmallScreen)
                Text(
                  "Vi Structure",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              if (!isSmallScreen)
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                ),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(22.5),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      hintStyle: TextStyle(color: Colors.white60),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 10),
                      prefixIcon: Icon(Icons.search, color: Colors.white),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.09)
            ],
          ),
          centerTitle: false,
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              tooltip: 'Logout',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CircleAvatar(
                backgroundColor: Colors.deepPurple,
                child: Icon(
                  Icons.person,
                  size: 27,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        drawer: isSmallScreen ? SideBarXExample(controller: _controller) : null,
        body: Row(
          children: [
            if (!isSmallScreen)
              SideBarXExample(controller: _controller, showTitle: false),
            Expanded(
              child: Center(
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    switch (_controller.selectedIndex) {
                      case 0:
                        _key.currentState?.closeDrawer();
                        return UploadScreen();
                      case 1:
                        _key.currentState?.closeDrawer();
                        return Mydrive();
                      case 2:
                        _key.currentState?.closeDrawer();
                        return Mynotes();

                      default:
                        return MyHomePage();
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SideBarXExample extends StatelessWidget {
  const SideBarXExample(
      {Key? key, required SidebarXController controller, this.showTitle = true})
      : _controller = controller,
        super(key: key);

  final SidebarXController _controller;
  final bool showTitle;

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: _controller,
      theme: const SidebarXTheme(
        textStyle: TextStyle(color: Colors.white),
        hoverTextStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontFamily: "Montserrat",
        ),
        itemTextPadding: EdgeInsets.only(left: 20),
        selectedItemTextPadding: EdgeInsets.only(left: 30),
        selectedTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: "ralewayStyle",
            fontSize: 20),
        decoration: BoxDecoration(
          color: canvasColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        selectedIconTheme: IconThemeData(
          color: Colors.white,
          size: 20,
        ),
      ),
      extendedTheme: const SidebarXTheme(width: 250),
      footerDivider: Divider(color: Colors.white, height: 1),
      headerBuilder: (context, extended) {
        return showTitle
            ? const SizedBox(
                height: 80,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Vi Structure",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink();
      },
      items: const [
        SidebarXItem(
          icon: Icons.create_new_folder_outlined,
          label: 'New',
        ),
        SidebarXItem(
          icon: Icons.add_to_drive_outlined,
          label: 'My Drive',
        ),
        SidebarXItem(icon: Icons.event_note, label: 'My Notes'),
      ],
    );
  }
}
