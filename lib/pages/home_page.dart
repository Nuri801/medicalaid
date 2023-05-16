import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicalaid/components/app_colors.dart';
import 'package:medicalaid/pages/add_medicine/add_medicine_page.dart';
import 'package:medicalaid/pages/history/history_page.dart';
import 'package:medicalaid/pages/today/today_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pages = [
    const TodayPage(),
    const HistoryPage(),
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        top: false,
        child: Scaffold(
          appBar: AppBar(),
          body: _pages[_currentIndex],
          floatingActionButton: FloatingActionButton(
            onPressed: _onAddMedicine,
            child: const Icon(CupertinoIcons.add),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: _buildBottomAppBar(),
        ),
      ),
    );
  }

  BottomAppBar _buildBottomAppBar() {
    return BottomAppBar(
          elevation: 0,
          child: Container(
            height: kBottomNavigationBarHeight,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CupertinoButton(
                  onPressed: () => _onCurrentPage(0),
                  child: Icon(
                    CupertinoIcons.checkmark,
                    color: _currentIndex == 0 ? AppColors.primaryColor : Colors.grey,
                  ),
                ),
                CupertinoButton(
                  onPressed: () => _onCurrentPage(1),
                  child: Icon(
                    CupertinoIcons.text_badge_checkmark,
                    color: _currentIndex == 1 ? AppColors.primaryColor : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        );
  }

  void _onCurrentPage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onAddMedicine() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddMedicinePage()),
    );
  }
}
