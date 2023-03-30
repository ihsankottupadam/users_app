import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:users_app/core/models/user_model.dart';
import 'package:users_app/ui/views/details/details_screen.dart';

class UserTile extends StatelessWidget {
  const UserTile({
    super.key,
    required this.user,
  });
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsScreen(user: user),
            )),
        visualDensity: const VisualDensity(vertical: 4),
        leading: Hero(
          tag: user.id,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(80),
            child: CachedNetworkImage(
                width: 60,
                height: 60,
                imageUrl: user.avatar,
                fit: BoxFit.cover,
                errorWidget: (context, _, error) => const Icon(Icons.person)),
          ),
        ),
        title: Text('${user.firstName} ${user.lastName}'),
        subtitle: Text(user.email),
      ),
    );
  }
}
