import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helios_q1/src/features/paginated_list/presentation/bloc/paginated_list_bloc.dart';
import '../../../../../injection_container.dart';
import '../../../settings/settings_view.dart';
import '../components/components.dart';

class UserListView extends StatelessWidget {
  UserListView({Key? key}) : super(key: key);
  static const routeName = '/';
  final _scrollController = ScrollController();

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
          ..add(const FetchNextResultsPageEvent()),
        child: BlocBuilder<PaginatedListBloc, PaginatedListState>(
            builder: (context, state) {
          if (state is PaginatedListLoading) {
            return const UserListLoading();
          } else if (state is PaginatedListLoaded) {
            return NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification notification) {
                if (notification is ScrollEndNotification &&
                    _scrollController.position.extentAfter == 0) {
                  BlocProvider.of<PaginatedListBloc>(context)
                      .add(const FetchNextResultsPageEvent());
                }
                return false;
              },
              child: ListView.builder(
                controller: _scrollController,
                itemCount: state.nextResultsPage.length,
                itemBuilder: (BuildContext context, int index) {
                  return RandomUserCard(user: state.nextResultsPage[index]);
                },
              ),
            );
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
