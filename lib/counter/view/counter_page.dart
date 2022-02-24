// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_channel_example/counter/counter.dart';
import 'package:flutter_channel_example/l10n/l10n.dart';
import 'package:flutter_channel_example/repository/platform_repository.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CounterView();
}

class CounterView extends State<CounterPage> {

  final _repository = PlatformRepository();
  String colorResult = "0xFFCA2C92";

  Future changeColor(String color) async {
    colorResult = await _repository.changeColor(color);
    return colorResult;
  }

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final l10n = context.l10n;

    var _counter = 0;

    void _counterAdd() {
      setState(() {
        _counter = _counter + 1;
        print("counter ${_counter}");
      });
    }

    void _counterRemove() {
      setState(() {
        _counter = _counter - 1;
        print("counter ${_counter}");
      });
    }

    return Scaffold(
      appBar: AppBar(title: Text(l10n.counterAppBarTitle)),
      body: Center(child: Text('$_counter', style: theme.textTheme.headline1)),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            key: const Key('counterView_increment_floatingActionButton'),
            child: const Icon(Icons.add),
            onPressed: _counterAdd
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            key: const Key('counterView_decrement_floatingActionButton'),
            child: const Icon(Icons.remove),
            onPressed: _counterRemove,
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
              key: const Key('kotlin_code_button'),
              child: const Icon(Icons.ac_unit),
              backgroundColor: Color(int.parse(colorResult)),
              onPressed: () {
                //send info in channel
                setState(() {
                  changeColor("0xFF2196F3");
                });
              }),
        ],
      ),
    );
  }
}
