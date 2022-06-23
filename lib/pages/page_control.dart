// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:planner_app/pages/calendario_page.dart';
import 'package:planner_app/pages/home_page.dart';
import 'package:planner_app/pages/login_page.dart';
import 'package:planner_app/pages/task_page.dart';

class PageControl extends StatefulWidget {
  const PageControl({Key? key}) : super(key: key);

  static PageController controller = PageController();

  @override
  State<PageControl> createState() => _PageControlState();
}

class _PageControlState extends State<PageControl> {
  @override
  Widget build(BuildContext context) {
    int paginaIndex;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageView(
        controller: PageControl.controller,
        children: <Widget>[
          HomePage(),
          TaskPage(),
          CalendarioPage(),
        ],
        onPageChanged: (page) {
          setState(() {
            paginaIndex = page;
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 60,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                iconSize: 30.0,
                padding: EdgeInsets.only(left: 60.0),
                icon: Icon(Icons.home),
                onPressed: () {
                  setState(() {
                    paginaIndex = 0;
                    PageControl.controller.jumpToPage(paginaIndex);
                  });
                },
              ),
              IconButton(
                iconSize: 30.0,
                padding: EdgeInsets.only(right: 60.0),
                icon: Icon(Icons.calendar_month),
                onPressed: () {
                  setState(() {
                    paginaIndex = 2;
                    PageControl.controller.jumpToPage(paginaIndex);
                  });
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        height: 65.0,
        width: 65.0,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {
              setState(() {
                TaskPage.task = null;
                paginaIndex = 1;
                PageControl.controller.jumpToPage(paginaIndex);
              });
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            // elevation: 5.0,
          ),
        ),
      ),
    );
  }
}
