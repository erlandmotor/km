part of 'inbox_schema_cubit.dart';

sealed class InboxSchemaState extends Equatable {
  const InboxSchemaState({ required this.inboxSchemaBox });

  final Box<InboxSchema>? inboxSchemaBox;

  @override
  List<Object> get props => [

  ];
}

final class InboxSchemaInitial extends InboxSchemaState {

  final Box<InboxSchema>? inboxSchemaBoxState;

  const InboxSchemaInitial({ required this.inboxSchemaBoxState }) : super(inboxSchemaBox: inboxSchemaBoxState);
}
