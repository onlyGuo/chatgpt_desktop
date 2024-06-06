import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'package:ffi/ffi.dart';

typedef CaptureScreenFunc = Pointer<Uint8> Function(Pointer<Int32> width, Pointer<Int32> height, Pointer<Int32> size);
typedef CaptureScreen = Pointer<Uint8> Function(Pointer<Int32> width, Pointer<Int32> height, Pointer<Int32> size);

typedef FreeMemoryFunc = Void Function(Pointer<Uint8> data);
typedef FreeMemory = void Function(Pointer<Uint8> data);

class NativeScreenshot {
  static DynamicLibrary? _lib;
  static bool isInitialized = false;

  static void initialize() {
    if (isInitialized) {
      return;
    }
    if (Platform.isWindows) {
      // 替换为实际的DLL路径
      _lib = DynamicLibrary.open('windows/native/native_screenshot.dll');
      isInitialized = true;
    } else {
      throw UnsupportedError('This platform is not supported.');
    }
  }

  static Uint8List captureScreen() {
    if (!isInitialized) {
      initialize();
    }
    final CaptureScreen captureScreen = _lib!
        .lookup<NativeFunction<CaptureScreenFunc>>('capture_screen')
        .asFunction();
    final FreeMemory freeMemory = _lib!
        .lookup<NativeFunction<FreeMemoryFunc>>('free_memory')
        .asFunction();

    final Pointer<Int32> width = calloc<Int32>();
    final Pointer<Int32> height = calloc<Int32>();
    final Pointer<Int32> size = calloc<Int32>();

    final Pointer<Uint8> result = captureScreen(width, height, size);
    final int dataSize = size.value;
    final Uint8List bytes = result.asTypedList(dataSize);

    // 释放分配的内存
    freeMemory(result);
    calloc.free(width);
    calloc.free(height);
    calloc.free(size);

    return bytes;
  }
}