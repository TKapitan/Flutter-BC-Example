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
      yield* _itemBlockedChanged(
        itemModel: event.onItem,
        toValue: true,
      );
    } else if (event is LookupItemUnBlockItemPushed) {
      yield* _itemBlockedChanged(
        itemModel: event.onItem,
        toValue: false,
      );
    }
  }

  Stream<LookupItemState> _itemBlockedChanged({
    ItemModel itemModel,
    bool toValue,
  }) async* {
    await RestManager.update(
      sourceRestData: itemModel,
      newValues: <String, String>{
        'blocked': toValue.toString(),
      },
      recordIdentification:
          itemModel.asKeyFieldsODataRecordIdentificationString(),
    );
    itemModel.blocked = toValue;
    yield LookupItemStateBlockedChanged(
      itemNo: itemModel.number,
      newValue: itemModel.blocked,
      lastLoadedState: lastLoadedState,
    );
  }
}
