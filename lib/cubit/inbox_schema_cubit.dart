import 'package:adamulti_mobile_clone_new/schema/inbox_schema.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'inbox_schema_state.dart';

class InboxSchemaCubit extends Cubit<InboxSchemaState> {
  InboxSchemaCubit() : super(const InboxSchemaInitial(inboxSchemaBoxState: null));

  void updateState(Box<InboxSchema>? box) {
    emit(InboxSchemaInitial(inboxSchemaBoxState: box));
  }
}
