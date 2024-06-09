import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housr_booking_app/bloc/hotel/hotel_list_bloc.dart';
import 'package:housr_booking_app/screen/hotel_list.dart';
import 'package:housr_booking_app/screen/main_page.dart';
import 'package:housr_booking_app/screen/profile.dart';

import 'dart:io';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _pageController = PageController(initialPage: 0);
  final NotchBottomBarController _controller =
      NotchBottomBarController(index: 0);
  int maxCount = 3;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> bottomBarPages = [
      BlocProvider(
        create: (context) => HotelBloc(),
        child: const MainPage(),
      ),
      BlocProvider(
        create: (context) => HotelBloc(),
        child: const HotelList(),
      ),
      BlocProvider(
        create: (context) => HotelBloc(),
        child: const Profile(),
      ),
    ];
    return WillPopScope(
      onWillPop: () async {
        // Return true to allow the app to exit
        return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Exit App?'),
            content: Text('Are you sure you want to exit?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => exit(0),
                child: const Text('Yes'),
              ),
            ],
          ),
        );
      },
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(
              bottomBarPages.length, (index) => bottomBarPages[index]),
        ),
        extendBody: true,
        bottomNavigationBar: (bottomBarPages.length <= maxCount)
            ? AnimatedNotchBottomBar(
                notchBottomBarController: _controller,
                color: const Color(0xff565FFF),
                showLabel: true,
                textOverflow: TextOverflow.visible,
                maxLine: 1,
                shadowElevation: 5,
                kBottomRadius: 28.0,
                notchColor: const Color(0xffA7BFEA),
                removeMargins: false,
                bottomBarWidth: 500,
                showShadow: false,
                durationInMilliSeconds: 300,
                itemLabelStyle: const TextStyle(fontSize: 10),
                elevation: 1,
                bottomBarItems: const [
                  BottomBarItem(
                    inActiveItem: Icon(
                      Icons.home_filled,
                      color: Colors.white,
                    ),
                    activeItem: Icon(
                      Icons.home_filled,
                      color: Color(0xff565FFF),
                    ),
                    itemLabelWidget: Text(
                      "Home",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  BottomBarItem(
                    inActiveItem: Icon(Icons.explore, color: Colors.white),
                    activeItem: Icon(
                      Icons.explore,
                      color: Color(0xff565FFF),
                    ),
                    itemLabelWidget: Text(
                      "Explore",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  BottomBarItem(
                    inActiveItem: Icon(Icons.person, color: Colors.white),
                    activeItem: Icon(
                      Icons.person,
                      color: Color(0xff565FFF),
                    ),
                    itemLabelWidget: Text(
                      "Profile",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
                onTap: (index) {
                  _pageController.jumpToPage(index);
                },
                kIconSize: 24.0,
              )
            : null,
      ),
    );
  }
}
