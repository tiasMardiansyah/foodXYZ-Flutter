import 'package:food_xyz_project/repositories.dart';


class MainMenuViewModel extends ViewModel {
  // ignore: prefer_final_fields
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  static const List<Widget> _pages = <Widget> [
    Browse(),
    Profile()
  ];

  void navBarChanged(int selectedIndex) {
    _currentIndex = selectedIndex;
    notifyListeners();
  }

  Widget? getCurrentSubPage() {
    return IndexedStack(
      index: _currentIndex,
      children: _pages,
    );
  }

  PreferredSizeWidget? getCurrentAppBar() {
    switch (_currentIndex) {
      //menu utama (Browsing)
      case 0:
        {
          return AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            titleTextStyle: customHeaderBold(),
            title: const Text('Aplikasi Food XYZ'),
            
          );
        }

      //Menu Profile
      case 1:
        {
          return AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            titleTextStyle: customHeaderBold(),
            title: const Text('Profile'),
            centerTitle: true,
          );
        }
    }

    return null;
  }
}
