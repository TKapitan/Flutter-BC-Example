import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tka_demo/page/components/list_footer.dart';
import 'package:tka_demo/page/components/padded_text_form_field.dart';
import 'package:tka_demo/page/components/standard_page_wrapper.dart';

import 'package:tka_demo/page/lookupItem/bloc/lookup_item_bloc.dart';
import 'package:tka_demo/page/lookupItem/bloc/lookup_item_event.dart';
import 'package:tka_demo/page/lookupItem/bloc/lookup_item_state.dart';

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
  }

  @override
  void dispose() {
    _lookupItemBloc.close();
    _scrollController.dispose();
    super.dispose();
  }

  String onSubmitItemIdentifier({
    @required String submittedValue,
  }) {
    print('Item Identifier field submitted: ' + submittedValue);
    _lookupItemBloc.add(LookupItemSearchFieldFilled(
      itemToFind: submittedValue,
    ));
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return StandardPageWrapper(
      pageTitle: 'Lookup Items',
      bodyBlocListener: BlocListener<LookupItemBloc, LookupItemState>(
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
                Padding(
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        PaddedTextFormField(
                          label: 'Item Identifier',
                          controller: null,
                          onFieldSubmitted: (value) =>
                              onSubmitItemIdentifier(submittedValue: value),
                        ),
                      ],
                    ),
                  ),
                  padding: EdgeInsets.all(16.0),
                ),
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
