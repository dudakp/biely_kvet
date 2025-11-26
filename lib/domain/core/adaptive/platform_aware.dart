import 'dart:io';

import 'package:flutter/cupertino.dart';

class PlatformAware {
  static final PlatformAware _instance = PlatformAware._internal();

  factory PlatformAware() {
    return _instance;
  }

  late bool isIOS;

  PlatformAware._internal() {
    isIOS = Platform.isIOS;
  }
}

abstract class PlatformAwareWidget {
  Widget buildIos(BuildContext context);

  Widget buildAndroid(BuildContext context);
}

abstract class PlatformAwareStatelessWidget extends StatelessWidget
    implements PlatformAwareWidget {
  final PlatformAware platformAware;

  PlatformAwareStatelessWidget({super.key}) : platformAware = PlatformAware();

  @override
  Widget build(BuildContext context) {
    return platformAware.isIOS ? buildIos(context) : buildAndroid(context);
  }
}

abstract class PlatformAwareStatefulWidget extends StatefulWidget {
  final PlatformAware platformAware;

  PlatformAwareStatefulWidget({super.key}) : platformAware = PlatformAware();

  @override
  State<PlatformAwareStatefulWidget> createState() =>
      PlatformAwareStatefulWidgetState();
}

class PlatformAwareStatefulWidgetState<T extends PlatformAwareStatefulWidget>
    extends State<T> implements PlatformAwareWidget {
  @override
  Widget build(BuildContext context) {
    return widget.platformAware.isIOS
        ? buildIos(context)
        : buildAndroid(context);
  }

  @override
  Widget buildAndroid(BuildContext context) {
    // TODO: implement buildAndroid
    throw UnimplementedError();
  }

  @override
  Widget buildIos(BuildContext context) {
    // TODO: implement buildIos
    throw UnimplementedError();
  }
}