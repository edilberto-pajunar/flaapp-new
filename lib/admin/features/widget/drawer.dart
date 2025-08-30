import 'package:flutter/material.dart';

class AdminDrawer extends StatelessWidget {
  const AdminDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 240,
          decoration: const BoxDecoration(
            color: Color(0xFFF3F4F6),
            border: Border(
              right: BorderSide(
                width: 2.0,
              ),
            ),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: DrawerHeader(
                  child: Text("Admin"),
                ),
              ),
              Divider(),
              // ListTile(
              //   onTap: () => context
              //       .read<AdminBloc>()
              //       .add(const AdminTypeChanged(
              //         adminType: AdminType.levels,
              //       )),
              //   title: const Text("Levels"),
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
