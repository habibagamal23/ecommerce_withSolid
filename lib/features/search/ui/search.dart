import 'package:fibeecomm/core/di/di.dart';
import 'package:fibeecomm/features/search/ui/searchbuilder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../logic/search_cubit.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: const Text('Search Products'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Search',
                  border: OutlineInputBorder(),
                ),
                onChanged: (query) {
                  context.read<SearchCubit>().search(query); // Trigger search
                },
              ),
            ),
            Expanded(
              child: Searchbuilder(),
            ),
          ],
        ),
    );
  }
}
