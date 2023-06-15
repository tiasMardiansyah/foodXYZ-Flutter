import 'package:food_xyz_project/repositories.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
    this.bgColor = const Color.fromARGB(52, 0, 0, 0),
  });

  final Color bgColor;
  @override
  Widget build(context) {
    return Container(
      color: bgColor,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
