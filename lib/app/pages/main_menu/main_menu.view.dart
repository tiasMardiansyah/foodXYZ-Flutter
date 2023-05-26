import 'package:food_xyz_project/repositories.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return MVVM<MainMenuViewModel>(
      view: () => _View(),
      viewModel: MainMenuViewModel(),
    );
  }
  
}

class _View extends StatelessView<MainMenuViewModel> {  
  
  @override
  Widget render(BuildContext context, MainMenuViewModel viewModel) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 238, 238, 238),
      appBar: viewModel.getCurrentAppBar(),
      body: viewModel.getCurrentSubPage(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Belanja',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box_rounded),
            label: 'Profile',
          ),
        ],
        currentIndex: viewModel.currentIndex,
        onTap: viewModel.navBarChanged,
      ),
    );
  }

  
}

/*  untuk referensi ganti panel
  [Login(),Login(),][viewModel.currentIndex] 
*/
