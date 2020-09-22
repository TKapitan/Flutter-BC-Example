import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tka_demo/model/rest_test_data.dart';
import 'package:tka_demo/page/lookupItem/bloc/lookup_item_event.dart';
import 'package:tka_demo/page/lookupItem/bloc/lookup_item_state.dart';
import 'package:tka_demo/programability/rest/rest_data.dart';
import 'package:tka_demo/programability/rest/rest_manager.dart';

class LookupItemBloc extends Bloc<LookupItemEvent, LookupItemState> {
  @override
  get initialState => LookupItemStateLoaded(
        itemToFind: '',
        noOfRecordsToShow: 0,
      );

  @override
  Stream<LookupItemState> mapEventToState(LookupItemEvent event) async* {
    if (event is LookupItemSearchFieldFilled) {
      yield LookupItemStateLoading(
        itemToFind: event.itemToFind,
      );
    }

    List<RestData> testData = await RestManager.fetchMultiple(RESTTestData());
    yield LookupItemStateLoaded(
      itemToFind: state.itemToFind,
      noOfRecordsToShow: testData.length,
      dataEntities: testData,
    );
  }
}
