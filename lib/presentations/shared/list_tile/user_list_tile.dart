import 'package:async_value_with_switch_sample/domains/models/home_town.dart';
import 'package:async_value_with_switch_sample/domains/models/user.dart';
import 'package:flutter/material.dart';

class UserListTile extends StatelessWidget {
  const UserListTile({
    required this.user,
    required this.onTap,
    required this.onLongPress,
    super.key,
  });

  final User user;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.person),
      title: Text(user.name),
      subtitle: Text('Age: ${user.age}, Hometown: ${user.homeTown.name}'),
      trailing: Icon(
        user.isDrinkingAlcohol ? Icons.local_bar : Icons.no_drinks,
      ),
      onTap: onTap,
      onLongPress: onLongPress,
      tileColor: switch (user.homeTown) {
        HomeTown.Fukuoka => Colors.red,
        HomeTown.Osaka => Colors.brown,
        HomeTown.Tokyo => Colors.green,
        HomeTown.Kyoto => Colors.yellow,
        HomeTown.Sapporo => Colors.purple,
        HomeTown.Sendai => Colors.orange,
      },
    );
  }
}
