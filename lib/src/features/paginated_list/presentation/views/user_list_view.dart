import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helios_q1/src/features/paginated_list/presentation/bloc/paginated_list_bloc.dart';
import '../../../../../injection_container.dart';
import '../../../settings/settings_view.dart';
import '../components/components.dart';

class UserListView extends StatelessWidget {
  const UserListView({Key? key}) : super(key: key);
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to the settings page. If the user leaves and returns
              // to the app after it has been killed while running in the
              // background, the navigation stack is restored.
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      body: BlocProvider(
        create: (_) => serviceLocator<PaginatedListBloc>()
          ..add(const GetRandomUsersEvent()),
        child: BlocBuilder<PaginatedListBloc, PaginatedListState>(
            builder: (context, state) {
          if (state is PaginatedListLoading) {
            return const UserListLoading();
          } else if (state is PaginatedListLoaded) {
            return ListView();
          } else if (state is PaginatedListError) {
            return const Center(
              child: Text("Error"),
            );
          } else {
            return const UserListLoading();
          }
        }),
      ),
    );
  }
}
