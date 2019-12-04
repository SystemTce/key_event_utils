import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:key_event_utils/key_event_utils.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController controller;
  FocusNode focusNode;

  List<int> keyCodes;
  List<String> barcodeList;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    focusNode = FocusNode();
    keyCodes = [];
    barcodeList = [];

    /// 入栈
    TceKeyEventUtils.instance.push(() {
      if (!focusNode.hasFocus) {
        // 聚焦
        focusNode.requestFocus();
      }
      // 清除
      controller.clear();
    });

    /// 在不清楚条码扫码器的扫码按钮键值时，可以通过setKeyEventListener获取键值
    TceKeyEventUtils.instance.setKeyEventListener((keyCode) {
      if (!keyCodes.contains(keyCode)) {
        setState(() {
          keyCodes.add(keyCode);
        });
      }
    });

    /// 在清楚知道条码扫码器的扫码按钮键值时，可以直接设置需要监听的键值
//    TceKeyEventUtils.instance.setKeyCode(ScanUtils.getDefaultKeyCodes());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    /// 出栈
    TceKeyEventUtils.instance.pop();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                Text('获取扫码按钮键值：'),
                TextField(
                  controller: controller,
                  focusNode: focusNode,
                  autofocus: true,

                  /// 请注意这里必须要设置null 或者 设置 minLines:1,maxLines:2,
                  /// 如果不设置，条码扫码起追加的 回车符 \n 就不会出现
                  maxLines: null,
//                  minLines: 1,
//                  maxLines: 2,
                  onChanged: (text) {
                    print('onChanged :$text');
                    TextEditingValue value =
                        TceKeyEventUtils.instance.textChangedListener(text);
                    if (value != null) {
                      setState(() {
                        barcodeList.add(text);
                        controller.value = value;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    hintText: '请使用条码扫码器扫码',
                  ),
                ),
                const Divider(),
                Text('条码扫码器-扫码按钮键值列表：'),
                Container(
                  height: 100,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Container(
                          height: 20,
                          child: Row(
                            children: <Widget>[
                              Expanded(child: Text('${keyCodes[index]}')),
                              FlatButton(
                                onPressed: () {
                                  setState(() {
                                    if (ScanUtils.isOnScan(keyCodes[index])) {
                                      /// 取消监听
                                      ScanUtils.removeKeyCodes(keyCodes[index]);
                                    } else {
                                      /// 设置监听
                                      ScanUtils.setKeyCodes(keyCodes);
                                    }
                                  });
                                },
                                child: Text(
                                    '${ScanUtils.isOnScan(keyCodes[index]) ? '取消监听' : '添加到扫码监听'}'),
                              )
                            ],
                          ));
                    },
                    itemCount: keyCodes?.length ?? 0,
                  ),
                ),
                const Divider(),
                Text('已扫条码列表：'),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Container(child: Text('${barcodeList[index]}'));
                    },
                    itemCount: barcodeList?.length ?? 0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
