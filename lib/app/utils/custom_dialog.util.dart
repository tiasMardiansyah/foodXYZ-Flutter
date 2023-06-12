import 'package:food_xyz_project/repositories.dart';

Future<void> showWarningDialog({
  String title = 'Peringatan',
  Image? icon,
  required List<String> texts,
}) async {
  icon ??= Image.asset('assets/images/warning_sign.png');
  final warningTexts = <Widget>[];
  for (var n = 0; n < texts.length; n++) {
    warningTexts.add(
      Text(
        texts[n],
        style: const TextStyle(fontSize: 16),
        textAlign: TextAlign.center,
      ),
    );
  }

  return Get.defaultDialog(
    title: title,
    textConfirm: "Tutup Notifikasi",
    confirmTextColor: Colors.white,
    onConfirm: () => Get.back(),
    content: Column(
      children: [
        SizedBox(
          width: 100,
          height: 100,
          child: FittedBox(
            fit: BoxFit.contain,
            child: icon,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Column(
          children: warningTexts,
        )
      ],
    ),
  );
}

Future<bool> showConfirmDialog({
  String title = 'Peringatan',
  String textConfirm = 'ya',
  String textCancel = 'tidak',
  Image? icon,
  required List<String> texts,
}) async {
  icon ??= Image.asset('assets/images/warning_sign.png');
  final warningTexts = <Widget>[];
  for (var n = 0; n < texts.length; n++) {
    warningTexts.add(
      Text(
        texts[n],
        style: const TextStyle(fontSize: 16),
        textAlign: TextAlign.center,
      ),
    );
  }

  final completer = Completer<bool>();
  Get.defaultDialog(
    title: title,
    textConfirm: textConfirm,
    confirmTextColor: Colors.white,
    onConfirm: () {
      Get.back();
      completer.complete(true);
    },
    textCancel: textCancel,
    onCancel: () {
      completer.complete(false);
    },
    barrierDismissible: false,
    content: Column(
      children: [
        SizedBox(
          width: 100,
          height: 100,
          child: FittedBox(
            fit: BoxFit.contain,
            child: icon,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Column(
          children: warningTexts,
        )
      ],
    ),
  );

  return completer.future;
}
