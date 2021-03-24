import 'package:flutter/material.dart';
import 'package:flutter_base/common/router/router_delegate.dart';
import 'package:flutter_base/common/router/router_result_model.dart';
import 'package:flutter_base/common/utils/log_utils.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  final int id;

  const SettingPage(this.id);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    LogUtils.d('id: ${widget.id}');

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            width: 200,
            height: 200,
            color: Colors.green,
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(
        child: Icon(
          Icons.arrow_back,
          size: 36,
          color: Colors.amberAccent,
        ),
        onPressed: () => context
            .read<RouterDelegateImpl>()
            .popResult(context, HomeResult("哈哈哈")),
      ),
    );
  }
}
