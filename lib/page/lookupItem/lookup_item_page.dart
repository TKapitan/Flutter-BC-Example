import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tka_demo/page/components/list_footer.dart';

import 'package:tka_demo/page/lookupItem/bloc/lookup_item_bloc.dart';
import 'package:tka_demo/page/lookupItem/bloc/lookup_item_event.dart';
import 'package:tka_demo/page/lookupItem/bloc/lookup_item_state.dart';

import '../components/drawer.dart';

class LookupItemPage extends StatefulWidget {
  static const String routeName = '/lookupItem';
  static const String id = 'LookupItem';

  @override
  State<StatefulWidget> createState() => _LookupItemState();
}

class _LookupItemState extends State<LookupItemPage> {
  final LookupItemBloc _lookupItemBloc = LookupItemBloc();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _lookupItemBloc.add(LookupItemSearchFieldFilled(
      itemToFind: '123AAA',
    ));
  }

  @override
  void dispose() {
    _lookupItemBloc.close();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lookup Items'),
      ),
      drawer: AppDrawer(),
      body: BlocListener<LookupItemBloc, LookupItemState>(
        bloc: _lookupItemBloc,
        listener: (context, state) {},
        child: BlocBuilder<LookupItemBloc, LookupItemState>(
          bloc: _lookupItemBloc,
          condition: (previous, current) {
            if (previous is LookupItemStateLoading &&
                current is LookupItemStateLoaded) return true;
            return false;
          },
          builder: (context, state) {
            return Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return index >= state.noOfRecordsToShow
                          ? ListFooter()
                          : state.dataEntities[index].asListItem();
                    },
                    itemCount: state.noOfRecordsToShow,
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
