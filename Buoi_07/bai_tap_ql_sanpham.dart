import 'dart:io';

List<List<dynamic>> danhSach = [];
bool? running;

void main() {
  running = true;

  while (running == true) {
    hienMenu();
  }
}

// Thêm sản phẩm vào danh sách
themSanPham() {
  print('');
  String? stt, tenSanPham, giaTien, soLuong;
  tenSanPham = nhapThongTin('Tên Sản phẩm');
  giaTien = nhapThongTin('Giá tiền');
  soLuong = nhapThongTin('Số lượng');

  stt = (danhSach.length + 1).toString();
  danhSach.add([stt, tenSanPham, giaTien, soLuong]);
  print("\nThông tin của sản phẩm $tenSanPham đã được thêm thành công.");
}

// Hiển thị danh sách sản phẩm
hienDanhSach() {
  print('\nDANH SÁCH SẢN PHẨM');

  inBangDuLieu(
    headers: ['STT', 'Tên sản phẩm', 'Giá tiền', 'Số lượng'],
    data: danhSach,
    khoangCachCot: 3,
  );

  hienMenu();
}

// Hiển thị sản phẩm điểm trung bình cao nhất
timSanPham() {
  if (danhSach.length == 0) {
    print(
      '\nThông báo: Danh sách Sản phẩm chưa có dữ liệu nên không thể tìm kiếm sản phẩm.',
    );
  } else {
    print('');
    var timSanPham = nhapThongTin('Tên Sản phẩm cần tìm');
    var dsSanPhamTimThay = [];

    for (var sp in danhSach) {
      if (chuaNoiDung(timSanPham, sp[1])) {
        dsSanPhamTimThay.add(sp);
      }
    }

    print('\nDanh sách Sản phẩm tìm được là:');

    inBangDuLieu(
      headers: ['STT', 'Tên sản phẩm', 'Giá tiền', 'Số lượng'],
      data: dsSanPhamTimThay,
      khoangCachCot: 3,
    );
  }

  hienMenu();
}

banSanPham() {
  if (danhSach.length == 0) {
    print(
      '\nThông báo: Danh sách Sản phẩm chưa có dữ liệu nên không thể bán sản phẩm.',
    );
  } else {
    print('');
    var timSanPham = nhapThongTin('Tên Sản phẩm cần bán');
    var dsSanPhamCanBan = [];

    for (var sp in danhSach) {
      if (chuaNoiDung(timSanPham, sp[1])) {
        dsSanPhamCanBan.add(sp);

        print('\nSản phẩm cần bán là:');

        inBangDuLieu(
          headers: ['STT', 'Tên sản phẩm', 'Giá tiền', 'Số lượng'],
          data: dsSanPhamCanBan,
          khoangCachCot: 3,
        );

        stdout.write(
          '\nBạn thực sự muốn bán sản phẩm này? Nếu đúng nhấn [Y]. Nếu không nhấn [N]. Để quay về menu, nhấn nút bất kỳ rồi Enter.\n👉 Câu trả lời của bạn: ',
        );

        String? input = stdin.readLineSync();
        input = input?.toUpperCase();
        switch (input) {
          case 'Y':
            var tenSP = sp[1];
            var soLuongSP = sp[3];
            // Nếu số lượng SP còn > 0 thì mới tiếp tục hỏi số lượng sản phẩm cần bán
            if (int.parse(soLuongSP) > 0) {
              var soLuongBan;
              do {
                soLuongBan = nhapThongTin('Số lượng bán');
                if (int.parse(soLuongBan) > int.parse(soLuongSP)) {
                  print(
                    '\nThông báo: Số lượng sản phẩm trong kho không đủ. Hãy nhập số lượng bán thấp hơn, tối đa là $soLuongSP.\n',
                  );
                } else {
                  // Cập nhật số lượng sản phẩm
                  sp[3] =
                      (int.parse(soLuongSP) - int.parse(soLuongBan)).toString();
                  print(
                    'Thông báo: Đã bán $soLuongBan sản phẩm $tenSP. Còn lại ${sp[3]}.',
                  );
                }
              } while (int.parse(soLuongBan) > int.parse(soLuongSP));
            } else {
              print('\nThông báo: Sản phẩm đã hết nên không thể bán!');
            }

            break;
          case 'N':
            banSanPham();
            break;
          default:
            hienMenu();
        }

        break;
      }
    }
  }
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

// Hiển thị Menu
hienMenu() {
  print('\n========== MENU ==========');
  print(
    '[1] Thêm Sản phẩm. [2] Danh sách Sản phẩm. [3] Tìm kiếm Sản phẩm. [4] Bán Sản phẩm. [+] Thoát.',
  );
  stdout.write('👉 Nhập lựa chọn của bạn: ');
  String? input = stdin.readLineSync();

  switch (input) {
    case '1':
      themSanPham();
      break;
    case '2':
      hienDanhSach();
      break;
    case '3':
      timSanPham();
      break;
    case '4':
      banSanPham();
      break;
    case '+':
      running = false;
      print('\nThông báo: Đã thoát chương trình!\n');
      exit(0);
    default:
      print('❌ Lựa chọn không hợp lệ. Vui lòng lựa chọn lại.');
  }
}

// Tính độ dài chuỗi text
int visibleLength(String text) {
  return text.runes.fold(0, (int prev, int rune) {
    bool isControlChar = (rune <= 0x1F || (rune >= 0x7F && rune <= 0x9F));
    bool isCombiningChar = (rune >= 0x0300 && rune <= 0x036F);
    return prev + (isControlChar || isCombiningChar ? 0 : 1);
  });
}

// Canh phải chuỗi text cho bằng độ dài width
String padTextRight(String text, int width) {
  int padLength = width - visibleLength(text);
  return text + ' ' * (padLength > 0 ? padLength : 0);
}

// Hàm tìm kiếm chuỗi có chứa ký tự
bool chuaNoiDung(String chuoiTim, String chuoiSoSanh) {
  // Chuyển cả hai chuỗi về chữ thường để không phân biệt hoa thường
  String tim = chuoiTim.toLowerCase();
  String soSanh = chuoiSoSanh.toLowerCase();

  // chuoiSoSanh có chứa nội dung chuoiTim thì trả về true
  return soSanh.contains(tim);
}

// Hàm in bảng dữ liệu theo cột
void inBangDuLieu({
  required var headers,
  required var data,
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

  // Canh phải chuỗi theo chiều rộng width
  String padTextRight(String text, int width) {
    int padLength = width - visibleLength(text);
    return text + ' ' * (padLength > 0 ? padLength : 0);
  }

  // Tính chiều rộng lớn nhất cho mỗi cột
  List<int> colWidths = List.generate(headers.length, (i) {
    int maxLen = visibleLength(headers[i]);
    for (var row in data) {
      String cell = row[i].toString();
      int len = visibleLength(cell);
      if (len > maxLen) maxLen = len;
    }
    return maxLen + khoangCachCot;
  });

  // In tiêu đề
  for (int i = 0; i < headers.length; i++) {
    stdout.write(padTextRight(headers[i], colWidths[i]));
  }
  print('');

  // In từng dòng dữ liệu
  for (var row in data) {
    for (int i = 0; i < row.length; i++) {
      stdout.write(padTextRight(row[i].toString(), colWidths[i]));
    }
    print('');
  }
}
