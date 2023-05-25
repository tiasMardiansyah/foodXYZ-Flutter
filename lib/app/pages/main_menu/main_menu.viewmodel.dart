import 'package:food_xyz_project/repositories.dart';

class MainMenuViewModel extends ViewModel {
  // ignore: prefer_final_fields
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void navBarChanged(int selectedIndex) {
    _currentIndex = selectedIndex;
    notifyListeners();
  }

  Widget? getCurrentSubPage() {
    switch (_currentIndex) {
      
      //menu utama (Browsing)
      case 0: 
      return const Center(child:Text("this is Main Menu"));
        

      //Menu Profile
      case 1:
        {
          return const Center(child:  Text("This is profile menu"));
        }
    }
    return null;
  }

  PreferredSizeWidget? getCurrentAppBar() {
    switch (_currentIndex) {

      //menu utama (Browsing)
      case 0:
        {
          return AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            titleTextStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            title: const Text('Aplikasi Food XYZ'),
          );
        }

      //Menu Profile
      case 1:
        {
          return AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            titleTextStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            title: const Text('Profile'),
            centerTitle: true,
          );
        }
    }

    return null;
  }

  /*
 String get userName => _userName;
  set userName(String value){
    _userName = value;
    notifyListeners();
  }
*/
}
