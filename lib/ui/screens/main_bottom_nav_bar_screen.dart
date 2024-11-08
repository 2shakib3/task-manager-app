import 'package:flutter/material.dart';
import 'package:task_management_app/ui/screens/cancelled_task_screen.dart';
import 'package:task_management_app/ui/screens/completed_task_screen.dart';
import 'package:task_management_app/ui/screens/new_task_screen.dart';
import 'package:task_management_app/ui/screens/progress_task_screen.dart';
import 'package:task_management_app/ui/widgets/tm_app_bar.dart';

class MainBottomNavBarScreen extends StatefulWidget {
  const MainBottomNavBarScreen({super.key});

  @override
  State<MainBottomNavBarScreen> createState() => _MainBottomNavBarScreenState();
}

class _MainBottomNavBarScreenState extends State<MainBottomNavBarScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screen = const [
    NewTaskScreen(),
    CompletedTaskScreen(),
    CancelledTaskScreen(),
    ProgressTaskScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TMAppBar(),
      body: _screen[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int Index) {
          _selectedIndex = Index;
          setState(() {});
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.new_label), label: 'New'),
          NavigationDestination(
              icon: Icon(Icons.check_box), label: 'Completed'),
          NavigationDestination(icon: Icon(Icons.close), label: 'Cancelled'),
          NavigationDestination(
              icon: Icon(Icons.access_alarm_outlined), label: 'Progress'),
        ],
      ),
    );
  }
}
