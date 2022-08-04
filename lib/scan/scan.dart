import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class Scan extends StatefulWidget {
  const Scan({Key? key}) : super(key: key);

  @override
  State<Scan> createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  late final QRViewController? qrViewController;
  final qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? barcode;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    qrViewController!.dispose();
  }

  void reasemmble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await qrViewController?.pauseCamera();
    }
    qrViewController?.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(alignment: Alignment.center, children: [
        buildQrView(context),
        //   Positioned(bottom: 10, child: buildResult()),
        Positioned(bottom: 10, child: buildButton())
      ]),
    );
  }

  Widget buildQrView(BuildContext context) {
    return QRView(
        overlay: QrScannerOverlayShape(
          borderRadius: 10,
          borderWidth: 10,
          borderLength: 20,
          cutOutSize: MediaQuery.of(context).size.width * 0.8,
        ),
        key: qrKey,
        onQRViewCreated: onQRViewCreated);
  }

  void onQRViewCreated(QRViewController controller) {
    setState(() {
      controller = qrViewController!;
    });
    qrViewController?.scannedDataStream.listen((data) {
      setState(() {
        data = barcode!;
      });
    });
  }

  buildResult() {
    Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Colors.white24),
      child: Text(
        barcode == null ? 'Result : ' : 'Scan a Code',
        maxLines: 3,
      ),
    );
  }

  buildButton() {
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Colors.white24),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () async {
              await qrViewController?.toggleFlash();
              setState(() {});
            },
            icon: FutureBuilder<bool?>(
              future: qrViewController?.getFlashStatus(),
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  return Icon(
                    snapshot.data! ? Icons.flash_on : Icons.flash_off,
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
          IconButton(
              onPressed: () async {
                await qrViewController?.flipCamera();
                setState(() {});
              },
              icon: FutureBuilder(
                  future: qrViewController?.getCameraInfo(),
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      return const Icon(Icons.switch_camera);
                    } else {
                      return Container();
                    }
                  }))
        ],
      ),
    );
  }
}
