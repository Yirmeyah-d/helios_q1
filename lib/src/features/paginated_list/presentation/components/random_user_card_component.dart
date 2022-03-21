import 'package:flutter/material.dart';
import 'package:helios_q1/src/core/network/network_info.dart';
import 'package:helios_q1/src/features/paginated_list/presentation/views/user_details_view.dart';

import '../../../../../injection_container.dart';
import '../../domain/entities/user.dart';

class RandomUserCard extends StatelessWidget {
  final User user;
  const RandomUserCard({required this.user, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        user.profilePicture.urlPhotoMediumSize,
        errorBuilder:
            (BuildContext context, Object exception, StackTrace? stackTrace) {
          return const Icon(Icons.person);
        },
      ),
      title: Text("${user.name.firstName} ${user.name.lastName}"),
      subtitle: Text(user.email),
      trailing: const Icon(Icons.more_vert_outlined),
      onTap: () {
        Navigator.restorablePushNamed(context, UserDetailsView.routeName,
            arguments: user.toMap());
      },
    );
  }
}
