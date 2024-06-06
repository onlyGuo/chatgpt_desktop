import 'dart:ffi';
import 'dart:io';

typedef PrScrnFunc = Int32 Function();
typedef PrScrn = int Function();

class WXDLL {
  static DynamicLibrary? _lib;
  static bool isInitialized = false;

  static void initialize() {
    if (isInitialized) {
      return;
    }
    if (Platform.isWindows) {
      // 替换为实际的DLL路径
      _lib = DynamicLibrary.open('windows/native/pr_scrn.dll');
      isInitialized = true;
    } else {
      throw UnsupportedError('This platform is not supported.');
    }
  }

  static int prScrn() {
    if (!isInitialized) {
      initialize();
    }
    final PrScrn prScrn = _lib!
        .lookup<NativeFunction<PrScrnFunc>>('PrScrn')
        .asFunction();
    return prScrn();
  }
}