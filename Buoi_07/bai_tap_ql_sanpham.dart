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
  print('\n-------------------------------------------');
  print('|             THÊM SẢN PHẨM               |');
  print('-------------------------------------------');
  String? stt, tenSanPham, giaTien, soLuong;
  tenSanPham = nhapThongTin('Tên sản phẩm');
  giaTien = nhapThongTin('Giá tiền');
  soLuong = nhapThongTin('Số lượng');

  stt = (danhSach.length + 1).toString();
  danhSach.add([stt, tenSanPham, giaTien, soLuong]);
  print("\nThông tin sản phẩm \'$tenSanPham\' đã được thêm thành công.");
}

// Hiển thị danh sách sản phẩm
hienDanhSach() {
  print('\n-------------------------------------------');
  print('|           DANH SÁCH SẢN PHẨM            |');
  print('-------------------------------------------');

  if (danhSach.length == 0) {
    print(
      'Thông báo: Danh sách Sản phẩm chưa có dữ liệu. Hãy thêm sản phẩm vào danh sách.',
    );
  } else {
    inBangDuLieu(
      headers: ['STT', 'Tên sản phẩm', 'Giá tiền', 'Số lượng'],
      data: danhSach,
      khoangCachCot: 4,
    );
  }

  hienMenu();
}

// Hiển thị sản phẩm điểm trung bình cao nhất
timSanPham() {
  print('\n-------------------------------------------');
  print('|            TÌM KIẾM SẢN PHẨM            |');
  print('-------------------------------------------');
  if (danhSach.length == 0) {
    print(
      'Thông báo: Danh sách Sản phẩm chưa có dữ liệu nên không thể tìm kiếm sản phẩm. Hãy thêm sản phẩm vào danh sách.',
    );
  } else {
    var timSanPham = nhapThongTin('Tên sản phẩm cần tìm');
    var dsSanPhamTimThay = [];

    for (var sp in danhSach) {
      if (chuaNoiDung(timSanPham, sp[1])) {
        dsSanPhamTimThay.add(sp);
      }
    }

    print('\n-------------------------------------------');
    print('|            KẾT QUẢ TÌM KIẾM             |');
    print('-------------------------------------------');

    if (dsSanPhamTimThay.length == 0) {
      print('Thông báo: Không tìm thấy sản phẩm nào.');
    } else {
      inBangDuLieu(
        headers: ['STT', 'Tên sản phẩm', 'Giá tiền', 'Số lượng'],
        data: dsSanPhamTimThay,
        khoangCachCot: 4,
      );
    }
  }

  hienMenu();
}

banSanPham() {
  print('\n-------------------------------------------');
  print('|              BÁN SẢN PHẨM               |');
  print('-------------------------------------------');
  if (danhSach.length == 0) {
    print(
      'Thông báo: Danh sách Sản phẩm chưa có dữ liệu nên không thể bán sản phẩm. Hãy thêm sản phẩm vào danh sách.',
    );
  } else {
    var timSanPham = nhapThongTin('tên Sản phẩm cần bán');
    var dsSanPhamCanBan = [];

    for (var sp in danhSach) {
      if (chuaNoiDung(timSanPham, sp[1])) {
        dsSanPhamCanBan.add(sp);

        print('\n-------------------------------------------');
        print('|       THÔNG TIN SẢN PHẨM CẦN BÁN        |');
        print('-------------------------------------------');

        inBangDuLieu(
          headers: ['STT', 'Tên sản phẩm', 'Giá tiền', 'Số lượng'],
          data: dsSanPhamCanBan,
          khoangCachCot: 4,
        );

        stdout.write(
          '\nBạn muốn bán sản phẩm \'${sp[1]}\' này? Nếu ĐÚNG nhấn [Y] để tiếp tục. Nếu SAI nhấn [N] để nhập lại tên sản phẩm cần bán.\nĐể quay về màn hình chính, nhấn nút bất kỳ rồi nhấn Enter.\n👉 Câu trả lời của bạn: ',
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
                soLuongBan = nhapThongTin('Số lượng \'$tenSP\' cần bán');
                if (int.parse(soLuongBan) > int.parse(soLuongSP)) {
                  print(
                    '\nThông báo: Số lượng sản phẩm \'$tenSP\' trong kho không đủ. Hãy nhập số lượng bán thấp hơn, tối đa là $soLuongSP.\n',
                  );
                } else {
                  // Cập nhật số lượng sản phẩm
                  var soLuongCon =
                      (int.parse(soLuongSP) - int.parse(soLuongBan)).toString();
                  sp[3] = soLuongCon;
                  print(
                    'Thông báo: Đã bán $soLuongBan sản phẩm \'$tenSP\'. Số lượng \'$tenSP\' còn lại $soLuongCon.',
                  );
                }
              } while (int.parse(soLuongBan) > int.parse(soLuongSP));
            } else {
              print(
                '\nThông báo: Sản phẩm \'$tenSP\' đã hết nên không thể bán!',
              );
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
  print('\n===========================================');
  print('|| PHẦN MỀM QUẢN LÝ SẢN PHẨM - CYPERSOFT ||');
  print('===========================================');
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
