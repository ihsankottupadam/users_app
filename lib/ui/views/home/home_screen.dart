import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/controllers/home_provider.dart';
import '../../widgets/user_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeProvider>().init(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        centerTitle: true,
      ),
      body: Consumer<HomeProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          final users = provider.users;
          return ListView.separated(
            padding: const EdgeInsets.all(8),
            controller: provider.scrollController,
            itemCount: provider.users.length + 1,
            itemBuilder: (context, index) {
              if (index == users.length) {
                return provider.isLodingMoreRunning
                    ? _loadingWidget()
                    : const SizedBox();
              }
              return UserTile(user: provider.users[index]);
            },
            separatorBuilder: (context, index) => const SizedBox(height: 10),
          );
        },
      ),
    );
  }

  Widget _loadingWidget() {
    return const Center(
      child: Padding(
          padding: EdgeInsets.all(8), child: CircularProgressIndicator()),
    );
  }
}
