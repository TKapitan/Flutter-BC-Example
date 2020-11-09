import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tka_demo/model/item_model.dart';
import 'package:tka_demo/page/lookupItem/bloc/lookup_item_event.dart';
import 'package:tka_demo/page/lookupItem/bloc/lookup_item_state.dart';
import 'package:tka_demo/programability/rest/rest_data.dart';
import 'package:tka_demo/programability/rest/rest_filter.dart';
import 'package:tka_demo/programability/rest/rest_manager.dart';

class LookupItemBloc extends Bloc<LookupItemEvent, LookupItemState> {
  LookupItemStateLoaded lastLoadedState;

  @override
  get initialState => LookupItemStateLoaded(
        itemToFind: '',
        noOfRecordsToShow: 0,
      );

  @override
  Stream<LookupItemState> mapEventToState(LookupItemEvent event) async* {
    if (event is LookupItemSearchFieldFilled) {
      print("Yield LookupItemStateLoading(" + event.itemToFind + ")");
      yield LookupItemStateLoading(
        itemToFind: event.itemToFind,
      );

      RestFilters filters;
      if (event.itemToFind != '') {
        filters = RestFilters().filter(
          field: 'number',
          value: event.itemToFind,
        );
      }

      List<RestData> testData = await RestManager.fetchMultiple(
        sourceRestData: ItemModel(
          fromBloc: this,
        ),
        filters: filters,
      );
      yield lastLoadedState = LookupItemStateLoaded(
        itemToFind: state.itemToFind,
        noOfRecordsToShow: testData.length,
        dataEntities: testData,
      );
    } else if (event is LookupItemBlockItemPushed) {
      await RestManager.update(
        sourceRestData: event.onItem,
        newValues: <String, String>{
          'blocked': 'true',
        },
        recordIdentification:
            event.onItem.asKeyFieldsODataRecordIdentificationString(),
      );
      event.onItem.blocked = true;
      yield LookupItemStateBlockedChanged(
        itemNo: event.onItem.number,
        newValue: event.onItem.blocked,
        lastLoadedState: lastLoadedState,
      );
    } else if (event is LookupItemUnBlockItemPushed) {
      await RestManager.update(
        sourceRestData: event.onItem,
        newValues: <String, String>{
          'blocked': 'false',
        },
        recordIdentification:
            event.onItem.asKeyFieldsODataRecordIdentificationString(),
      );
      event.onItem.blocked = false;
      yield LookupItemStateBlockedChanged(
        itemNo: event.onItem.number,
        newValue: event.onItem.blocked,
        lastLoadedState: lastLoadedState,
      );
    }
  }
}
