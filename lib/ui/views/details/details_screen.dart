import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:users_app/core/models/user_model.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.user});
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Hero(
              tag: user.id,
              child: CachedNetworkImage(
                width: double.infinity,
                imageUrl: user.avatar,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Column(children: [
                _cell('Id', user.id.toString()),
                _cell('First Name', user.firstName),
                _cell('Last Name', user.lastName),
                _cell('Email', user.email),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cell(String title, String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
          ),
          Text(
            value,
            style: TextStyle(
                fontSize: 18,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
