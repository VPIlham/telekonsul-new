part of '../pages.dart';

class BottomNavigationBarUserScreen extends StatefulWidget {
  @override
  _BottomNavigationBarUserScreenState createState() =>
      _BottomNavigationBarUserScreenState();
}

class _BottomNavigationBarUserScreenState extends State {
  int _selectedIndex = 1;

  final _widgetOptions = [ListTransaksiUser(), MainPage(), ProfileUser()];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
          // backgroundColor: Color(0xffF4F4F4),
          backgroundColor: Colors.white70,
          elevation: 4,
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.redAccent,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Transaksi',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ]),
    );
  }
}
