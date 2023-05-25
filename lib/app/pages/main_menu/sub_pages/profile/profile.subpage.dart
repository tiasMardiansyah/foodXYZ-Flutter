import 'package:food_xyz_project/repositories.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});
  @override
  Widget build(BuildContext context) {
    return MVVM<ProfileViewModel>(
      view: () => _View(),
      viewModel: ProfileViewModel(),
    );
  }
}

class _View extends StatelessView<ProfileViewModel> {
  @override
  Widget render(BuildContext context, ProfileViewModel viewModel) {
    return ElevatedButton.icon(
      icon: Icon(Icons.logout),
      onPressed: viewModel.logout, 
      label: Text('Keluar'),
      );
  }
}
