import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'scan_utils.dart';

///
/// 物理按钮监听 工具类
/// 针对 EC500/EC500P
///
/// @author David
/// @date 2019-11-16
///

/// 需要获取 条码扫码器 的扫码按钮键值时可以添加，请不要在release版本中使用
typedef KeyEventListener = void Function(int keyCode);

class TceKeyEventUtils {
  /// 条码扫码器：首先设置条码，然后再追加一个回车符，
  /// 所以会触发两次onChanged事件，所以判断scanCount = 2时，删除回车符，并且触发查询事件
  int _scanCount = -1;

  /// 保存 callback 栈，在扫码时，只执行栈顶的方法
  List<VoidCallback> _callback = <VoidCallback>[];

  /// 在使用第一次使用时，可以设置这个监听，获取 条码扫码器 的按钮键值
  KeyEventListener _keyEventListener;

  static final TceKeyEventUtils instance = TceKeyEventUtils._();

  TceKeyEventUtils._() {
    // 添加全局监听
    ValueChanged<RawKeyEvent> listener = (RawKeyEvent keyEvent) {
      if (_callback?.isNotEmpty == true) {
        // 判断是否按下扫码按钮
        if (keyEvent.runtimeType.toString() == 'RawKeyDownEvent') {
          RawKeyEventDataAndroid key = keyEvent.data;

          /// 返回键值
          if (_keyEventListener != null) {
            _keyEventListener(key.keyCode);
          }

          /// 判断扫码键值是否是 扫码键
          if (ScanUtils.isOnScan(key.keyCode)) {
            _scanCount = 0;

            /// on Scan: 执行栈顶的方法
            _callback[0]();
          } else {
            // --防止无限等待
//            scanCount = -1;
          }
        }
      }
    };
    RawKeyboard.instance.addListener(listener);
  }

  /// 判断检测两次,并且 text.endsWith('\n')
  /// return true:  条码扫码器扫码结束
  /// return false: 非条码扫码器扫码
  TextEditingValue textChangedListener(String text) {
    if (_callback[0] != null) {
      if (instance._scanCount >= 0) {
        instance._scanCount += 1;
        if (instance._scanCount == 2) {
          instance._scanCount = -1;
          if (text.endsWith('\n')) {
            // 删除回车符
            String filter = text.substring(0, text.length - 1);
            // 重新更新输入框值
            return TextEditingValue(
              text: filter,
              selection: TextSelection.collapsed(offset: filter.length),
            );
          }
        }
      }
    }
    return null;
  }

  /// 监听 条码扫码器 点击事件，返回按钮键值
  void setKeyEventListener(KeyEventListener listener) {
    _keyEventListener = listener;
  }

  /// 设置监听扫码按钮的键值列表
  void setKeyCode(List<int> keyCodes) {
    ScanUtils.setKeyCodes(keyCodes);
  }

  /// 入栈顶
  void push(VoidCallback callback) {
    _callback.insert(0, callback);
  }

  /// 出栈
  void pop() {
    if (_callback.length > 0) {
      _callback.removeAt(0);
    }

    /// 自动关闭
    if (_keyEventListener != null) {
      _keyEventListener = null;
    }
  }
}
