import 'package:food_xyz_project/repositories.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    super.key,
    required this.name,
    required this.phoneNumber,
    required this.address,
  });

  final String name;
  final String phoneNumber;
  final String address;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 15.0,
            ),
            child: Icon(Icons.home, size: 40),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: customHeaderBold(),
              ),
              Text(phoneNumber),
              Text(address),
            ],
          ),
        ],
      ),
    );
  }
}
