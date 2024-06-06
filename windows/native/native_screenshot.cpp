#include <windows.h>
#include <iostream>

extern "C" __declspec(dllexport) unsigned char* capture_screen(int x, int y, int width, int height, int* size) {
    HDC hScreenDC = GetDC(NULL);
    HDC hMemoryDC = CreateCompatibleDC(hScreenDC);

    HBITMAP hBitmap = CreateCompatibleBitmap(hScreenDC, width, height);
    HBITMAP hOldBitmap = (HBITMAP)SelectObject(hMemoryDC, hBitmap);

    BitBlt(hMemoryDC, 0, 0, width, height, hScreenDC, x, y, SRCCOPY);

    BITMAPINFOHEADER bi;
    bi.biSize = sizeof(BITMAPINFOHEADER);
    bi.biWidth = width;
    bi.biHeight = -height;
    bi.biPlanes = 1;
    bi.biBitCount = 32;
    bi.biCompression = BI_RGB;
    bi.biSizeImage = 0;
    bi.biXPelsPerMeter = 0;
    bi.biYPelsPerMeter = 0;
    bi.biClrUsed = 0;
    bi.biClrImportant = 0;

    int bmpSize = ((width * bi.biBitCount + 31) / 32) * 4 * height;
    unsigned char* bmpData = new unsigned char[bmpSize];
    GetDIBits(hMemoryDC, hBitmap, 0, height, bmpData, (BITMAPINFO*)&bi, DIB_RGB_COLORS);

    *size = bmpSize;

    SelectObject(hMemoryDC, hOldBitmap);
    DeleteObject(hBitmap);
    DeleteDC(hMemoryDC);
    ReleaseDC(NULL, hScreenDC);

    return bmpData;
}