import "package:adamulti_mobile_clone_new/components/inbox_applikasi_item_component.dart";
import "package:adamulti_mobile_clone_new/components/no_notification_component.dart";
import "package:adamulti_mobile_clone_new/cubit/inbox_schema_cubit.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:hive_flutter/adapters.dart";

class InboxActivityTab extends StatelessWidget {
  const InboxActivityTab({ super.key });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: locator.get<InboxSchemaCubit>().state.inboxSchemaBox!.listenable(), 
      builder: (context, value, child) {
        if(value.isEmpty) {
          return const NoNotificationComponent(label: "Tidak Ada Data Inbox Aktifitas");
        } else {
          return ListView.separated(
            padding: const EdgeInsets.all(8),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final box = value;
              final getData = box.getAt(index);

              return InboxApplikasiItemComponent(
                data: getData!, 
                onTapAction: () {
                  context.pushNamed("inbox-activity-detail", extra: {
                    "data": getData
                  });
                },
                onDeleteAction: () {
                  box.deleteAt(index);
                },
              );
            }, 
            separatorBuilder: (context, index) {
              return const SizedBox(height: 6,);
            }, 
            itemCount: value.length
          );
        }
      }
    );
  }
}