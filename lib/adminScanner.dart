import 'package:flutter/material.dart';
import 'package:ftp/addDataAdmin.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class AdminScanner extends StatefulWidget {
  const AdminScanner({super.key});

  @override
  State<AdminScanner> createState() => _AdminScannerState();
}

class _AdminScannerState extends State<AdminScanner> {
  @override
  bool _screenOpened = false;

  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 400,
              height: 400,
              child: MobileScanner(
                allowDuplicates: true,
                // controller: cameraController,
                onDetect: _foundBarcode,
              ),
            ),
            Text('Put barCode inside Camera only')
          ],
        ),
      ),
    );
  }

  void _foundBarcode(Barcode barcode, MobileScannerArguments? args) {
    /// open screen
    if (!_screenOpened) {
      final String code = barcode.rawValue ?? "---";
      // debugPrint('Barcode found! $code');
      _screenOpened = true;
      setState(() {
        // debugPrint('Barcode found! $code');
        _screenOpened = false;
      });
      Get.to(AddDataAdmin(), arguments: [
        {'codevalue': '$code'}
      ]);
    }
  }

  void _screenWasClosed() {
    _screenOpened = false;
  }
}
