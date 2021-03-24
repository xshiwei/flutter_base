import 'package:flutter/material.dart';
import 'package:flutter_base/common/router/router_config.dart';
import 'package:flutter_base/common/router/router_delegate.dart';
import 'package:flutter_base/common/router/router_result_model.dart';
import 'package:flutter_base/pages/setting/setting_page.dart';
import 'package:flutter_base/common/utils/log_utils.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    LogUtils.d('home build');
    final result = context.read<RouterResultModel>().homeResult;
    LogUtils.d('result: ${result?.toString()}');

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 24,
              color: Colors.black,
            ),
            onPressed: () {
              context.read<RouterDelegateImpl>().popResult(context, "3");
            }),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            width: 200,
            height: 200,
            color: Colors.black,
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          context
              .read<RouterDelegateImpl>()
              .pushWidget(SettingPage(10), SettingPageConfig);
        },
        child: Text('增加'),
      ),
    );
  }
}
