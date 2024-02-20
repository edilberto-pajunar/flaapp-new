import 'package:flaapp/models/data.dart';
import 'package:flaapp/models/user.dart';
import 'package:flaapp/services/networks/providers/user.dart';
import 'package:flaapp/views/screens/mobile/flashcard/level_screen.dart';
import 'package:flaapp/views/widgets/body/stream_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserWrapperScreen extends StatefulWidget {
  static String route = "/userStream";
  const UserWrapperScreen({
    required this.id,
    super.key,
  });

  final String id;

  @override
  State<UserWrapperScreen> createState() => _UserWrapperScreenState();
}

class _UserWrapperScreenState extends State<UserWrapperScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.updateDataStream(id: widget.id);
      userProvider.updateUserStream(id: widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return StreamWrapper<UserModel>(
      stream: userProvider.userStream,
      child: (data) {

        final UserModel userModel = data;

        return StreamWrapper<DataModel>(
          stream: userProvider.dataStream,
          child: (data) {

            final DataModel dataModel = data;

            return LevelsScreen(
              dataModel: dataModel,
            );
          },
        );
      },
    );
  }
}
