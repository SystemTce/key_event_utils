///
/// 扫码
///
/// @author David
/// @date 2019-11-11
///
class ScanUtils {
  // EC500 左扫描键
  static final int LEFT_SCAN_KEY = 132;

  // 500 右扫描键
  static final int RIGHT_SCAN_KEY = 133;

  // 500P 扫码键
  static final int SCAN_KEY = 165;

  //针对EC500的长按返回桌面的扫码键
  static final int CENTER_SCAN_KEY = 84;

  //STX 113：会导致键盘连续弹出
  //F7   88：会导致键盘连续弹出
  //F8   85: 会导致音乐播放
  static final int BLUETOOTH_SCAN_KEY = 113;

  static final List<int> _defaultKeyCode = [];

  static bool isOnScan(int keyCode) {
    return _defaultKeyCode.contains(keyCode);
//    return keyCode == LEFT_SCAN_KEY ||
//        keyCode == RIGHT_SCAN_KEY ||
//        keyCode == SCAN_KEY ||
//        keyCode == CENTER_SCAN_KEY ||
//        keyCode == BLUETOOTH_SCAN_KEY;
  }

  /// 根据 条码扫码器 的扫码按钮键值进行设置，
  /// 获取 扫码按钮的keyCode 可以通过 KeyEventUtils.setKeyEventListener方法
  static void setKeyCodes(List<int> keyCodes) {
    _defaultKeyCode.clear();
    _defaultKeyCode.addAll(keyCodes);
  }

  /// 取消监听
  static void removeKeyCodes(int keyCode) {
    _defaultKeyCode.remove(keyCode);
  }

  /// 测试
  static List<int> getKeyCodes() {
    return _defaultKeyCode;
  }

  /// 默认测试
  static List<int> getDefaultKeyCodes() {
    return [
      LEFT_SCAN_KEY,
      RIGHT_SCAN_KEY,
      SCAN_KEY,
      CENTER_SCAN_KEY,
      BLUETOOTH_SCAN_KEY,
    ];
  }

//  static Future<String> toScanPage(BuildContext context) {
  /// IOS扫码 库
//    try {
//      return MajaScan.startScan(
//          title: "扫码",
//          titleColor: Colors.blue[200],
//          qRCornerColor: Colors.blue,
//          qRScannerColor: Colors.blue);
//    } on PlatformException catch (ex) {
//      if (ex.code == MajaScan.CameraAccessDenied) {
//        UiUtils.toast('摄像许可被拒绝');
//        return null;
//      } else {
//        UiUtils.toast('未知的错误 $ex');
//        return null;
//      }
//    } on FormatException {
//      UiUtils.toast('你在扫描之前按了后退键');
//      return null;
//    } catch (ex) {
//      UiUtils.toast('未知的错误 $ex');
//      return null;
//    }
  /// Android 扫码库
//    return scanner.scanPhoto();
//    return scanner.scan();

//    if (PreferencesManager.canUserGoogleScan()) {
  /// 跳转google 扫码
//      return search.push(context).then((barcode) {
//        if (barcode != null) {
//          Barcode code = barcode;
//          return code.displayValue;
//        }
//        return null;
//      });
//    } else {
  /// Google 扫码不可用时，使用其他扫码
//      return scanner.scan().then((cameraScanResult) {
//        return cameraScanResult;
//      });
//    }

// if (Platform.isAndroid) {
//      /// 安卓使用的扫码库功能完善：可以从图库选择图片
//      return scanner.scan();
//
//      /// import 'package:qrscan/qrscan.dart' as scanner;
//      ///
//      /// Select Bar-Code or QR-Code photos for analysis
//      /// String photoScanResult = await scanner.scanPhoto();
//      ///
//      /// Generating QR-Code
//      /// Uint8List result = await scanner.generateBarCode('https://github.com/leyan95/qrcode_scanner');
//      ///
//      /// Scanning the image of the specified path
//      /// String barcode = await scanner.scanPath(path);
//      ///
//      /// Parse to code string with uint8list
//      /// File file = await ImagePicker.pickImage(source: ImageSource.camera);
//      /// Uint8List bytes = file.readAsBytesSync();
//      /// String barcode = await scanner.scanBytes(uint8list);
//    } else {
//      /// IOS只能扫码、闪光灯
//    }
//  }
}
