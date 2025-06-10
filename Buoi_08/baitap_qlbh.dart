import 'dart:io';

List<Map<String, String>> danhsachSP = [];
bool? running;

void main() {
  running = true;

  while (running == true) {
    hienMenu();
  }
}

// Hiển thị Menu
hienMenu() {
  print('\n=========================================================');
  print('||        PHẦN MỀM QUẢN LÝ GIỎ HÀNG - CYPERSOFT        ||');
  print('=========================================================');
  print(
    '[1] Thêm sản phẩm. [2] Sửa sản phẩm. [3] Xóa sản phẩm. [4] Hiển thị giỏ hàng. [0] Thoát.',
  );
  stdout.write('👉 Nhập lựa chọn của bạn: ');
  String? input = stdin.readLineSync();

  switch (input) {
    case '1':
      themSP();
      break;
    case '2':
      suaSP();
      break;
    case '3':
      xoaSP();
      break;
    case '4':
      hienthiGioHang();
      break;
    case '0':
      running = false;
      print('Thông báo: Đã thoát chương trình!\n');
      exit(0);
    default:
      print('❌ Lựa chọn không hợp lệ. Vui lòng lựa chọn lại.');
  }
}

// Thêm sản phẩm vào giỏ hàng
themSP() {
  print('\n---------------------------------------------------------');
  print('|              THÊM SẢN PHẨM VÀO GIỎ HÀNG               |');
  print('---------------------------------------------------------');
  Map<String, String> sanpham = {};
  sanpham['STT'] = (danhsachSP.length).toString();
  sanpham['Tên sản phẩm'] = nhapThongTin('Tên sản phẩm');
  sanpham['Số lượng'] = nhapThongTin('Số lượng');
  sanpham['Đơn giá'] = nhapThongTin('Đơn giá');
  sanpham['Thành tiền'] = '0';

  danhsachSP.add(sanpham);
}

capnhatSP() {
  for (int i = 0; i < danhsachSP.length; i++) {
    danhsachSP[i]['STT'] = (i + 1).toString();
    danhsachSP[i]['Thành tiền'] =
        (int.parse(danhsachSP[i]['Đơn giá'] ?? '0') *
                int.parse(danhsachSP[i]['Số lượng'] ?? '0'))
            .toString();
  }
}

// Sửa sản phẩm trong giỏ hàng
suaSP() {
  capnhatSP();
  print('\n---------------------------------------------------------');
  print('|                SỬA THÔNG TIN SẢN PHẨM                 |');
  print('---------------------------------------------------------');

  if (danhsachSP.length == 0) {
    print(
      'Thông báo: Giỏ hàng chưa có sản phẩm nên không thể xóa. Hãy thêm sản phẩm vào giỏ hàng.',
    );
  } else {
    inBangDuLieu(
      headers: ['STT', 'Tên sản phẩm', 'Số lượng', 'Đơn giá', 'Thành tiền'],
      data: danhsachSP,
      khoangCachCot: 4,
    );
    print('---------------------------------------------------------');

    stdout.write('Nhập STT của sản phẩm bạn muốn sửa: ');
    String? value = stdin.readLineSync();
    // Tìm sản phẩm có STT khớp
    for (var sp in danhsachSP) {
      if (sp['STT'] == value) {
        // Tên sản phẩm
        stdout.write(
          'Nhập tên sản phẩm mới (Enter để giữ nguyên: "${sp['Tên sản phẩm']}"): ',
        );
        String? tenMoi = stdin.readLineSync();
        if (tenMoi != null && tenMoi.trim().isNotEmpty) {
          sp['Tên sản phẩm'] = tenMoi;
        }

        // Số lượng
        stdout.write(
          'Nhập số lượng mới (Enter để giữ nguyên: "${sp['Số lượng']}"): ',
        );
        String? soLuongMoi = stdin.readLineSync();
        if (soLuongMoi != null && soLuongMoi.trim().isNotEmpty) {
          sp['Số lượng'] = soLuongMoi;
        }

        // Đơn giá
        stdout.write(
          'Nhập đơn giá mới (Enter để giữ nguyên: "${sp['Đơn giá']}"): ',
        );
        String? donGiaMoi = stdin.readLineSync();
        if (donGiaMoi != null && donGiaMoi.trim().isNotEmpty) {
          sp['Đơn giá'] = donGiaMoi;
        }

        print('✅ Đã cập nhật sản phẩm có STT = $value');
      }
    }

    hienthiGioHang();
  }
}

// Xóa sản phẩm trong giỏ hàng
xoaSP() {
  capnhatSP();
  print('\n---------------------------------------------------------');
  print('|                     XÓA SẢN PHẨM                      |');
  print('---------------------------------------------------------');

  if (danhsachSP.length == 0) {
    print(
      'Thông báo: Giỏ hàng chưa có sản phẩm nên không thể xóa. Hãy thêm sản phẩm vào giỏ hàng.',
    );
  } else {
    inBangDuLieu(
      headers: ['STT', 'Tên sản phẩm', 'Số lượng', 'Đơn giá', 'Thành tiền'],
      data: danhsachSP,
      khoangCachCot: 4,
    );
    print('---------------------------------------------------------');

    stdout.write('Nhập STT của sản phẩm bạn muốn xóa: ');
    String? value;
    value = stdin.readLineSync();
    danhsachSP.removeWhere((sp) => sp['STT'] == value);
    hienthiGioHang();
  }
}

// Hiển thị giỏ hàng
hienthiGioHang() {
  capnhatSP();
  print('\n---------------------------------------------------------');
  print('|                       GIỎ HÀNG                        |');
  print('---------------------------------------------------------');

  if (danhsachSP.length == 0) {
    print(
      'Thông báo: Giỏ hàng chưa có sản phẩm. Hãy thêm sản phẩm vào giỏ hàng.',
    );
  } else {
    inBangDuLieu(
      headers: ['STT', 'Tên sản phẩm', 'Số lượng', 'Đơn giá', 'Thành tiền'],
      data: danhsachSP,
      khoangCachCot: 4,
    );

    inTongTien();
  }

  hienMenu();
}

// Hàm nhập thông tin
String nhapThongTin(String thongtin) {
  String? value;
  do {
    stdout.write('Nhập $thongtin: ');
    value = stdin.readLineSync();

    if (value == null || value.isEmpty) {
      print('Bạn chưa nhập $thongtin hợp lệ, hãy nhập lại.\n');
    }
  } while (value == null || value.trim().isEmpty);

  return value;
}

// Hàm in bảng dữ liệu theo cột
void inBangDuLieu({
  required List<String> headers,
  required List<Map<String, String>> data,
  int khoangCachCot = 3,
}) {
  // Tính độ dài hiển thị thực tế của chuỗi
  int visibleLength(String text) {
    return text.runes.fold(0, (int prev, int rune) {
      bool isControlChar = (rune <= 0x1F || (rune >= 0x7F && rune <= 0x9F));
      bool isCombiningChar = (rune >= 0x0300 && rune <= 0x036F);
      return prev + (isControlChar || isCombiningChar ? 0 : 1);
    });
  }

  // Căn lề phải chuỗi
  String padTextRight(String text, int width) {
    int padLength = width - visibleLength(text);
    return text + ' ' * (padLength > 0 ? padLength : 0);
  }

  // Tính chiều rộng tối đa cho từng cột
  List<int> colWidths = List.generate(headers.length, (i) {
    String header = headers[i];
    int maxLen = visibleLength(header);
    for (var row in data) {
      String cell = row[header] ?? '';
      int len = visibleLength(cell);
      if (len > maxLen) maxLen = len;
    }
    return maxLen + khoangCachCot;
  });

  // In dòng tiêu đề
  for (int i = 0; i < headers.length; i++) {
    stdout.write(padTextRight(headers[i], colWidths[i]));
  }
  print('');

  // In dữ liệu từng dòng
  for (var row in data) {
    for (int i = 0; i < headers.length; i++) {
      String cell = row[headers[i]] ?? '';
      stdout.write(padTextRight(cell, colWidths[i]));
    }
    print('');
  }
}

inTongTien() {
  // In tổng tiền thanh toán
  int tong = 0;

  for (var sp in danhsachSP) {
    String? giaStr = sp['Thành tiền'];
    if (giaStr != null) {
      int gia = int.tryParse(giaStr) ?? 0;
      tong += gia;
    }
  }
  print('---------------------------------------------------------');
  print('TỔNG TIỀN: $tong');
}
