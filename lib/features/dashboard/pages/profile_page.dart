import 'package:flutter/material.dart';
import '../../../core/storage/local_storage.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: LocalStorage.getEmployeeCode(),
      builder: (context, snapshot) {
        return Center(
          child: Text(
            'Employee Code: ${snapshot.data ?? ''}',
            style: const TextStyle(fontSize: 22),
          ),
        );
      },
    );
  }
}
