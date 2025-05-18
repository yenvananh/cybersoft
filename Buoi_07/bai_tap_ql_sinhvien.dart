import 'dart:io';

List<List<dynamic>> danhSach = [];
bool? running;

void main() {
  running = true;

  while (running == true) {
    hienMenu();
  }
}

// Thêm sinh viên vào danh sách
themSinhVien() {
  print('');
  String? stt, ten, diemToan, diemLy, diemHoa, diemTB, xepLoai;
  ten = nhapThongTin('HỌ & TÊN');
  diemToan = nhapThongTin('điểm TOÁN');
  diemLy = nhapThongTin('điểm LÝ');
  diemHoa = nhapThongTin('điểm HÓA');

  diemTB = ((double.parse(diemToan) +
              double.parse(diemLy) +
              double.parse(diemHoa)) /
          3)
      .toStringAsFixed(2);

  if (double.parse(diemTB) < 5) {
    xepLoai = "Kém";
  } else if (double.parse(diemTB) < 7) {
    xepLoai = "Khá";
  } else if (double.parse(diemTB) < 9) {
    xepLoai = "Giỏi";
  } else {
    xepLoai = "Xuất sắc";
  }

  stt = (danhSach.length + 1).toString();
  danhSach.add([stt, ten, diemToan, diemLy, diemHoa, diemTB, xepLoai]);
  print("Thông tin của sinh viên $ten đã được thêm thành công.");
}

// Hiển thị danh sách sinh viên
hienDanhSach() {
  print('\nDANH SÁCH SINH VIÊN');
  List<String> headers = [
    'STT',
    'Họ & tên',
    'Toán',
    'Lý',
    'Hóa',
    'ĐTB',
    'Xếp loại',
  ];

  // Tính chiều rộng lớn nhất cho mỗi cột (bao gồm tiêu đề và dữ liệu)
  List<int> colWidths = List.generate(headers.length, (i) {
    int maxLen = visibleLength(headers[i]);
    for (var sv in danhSach) {
      String cell = sv[i].toString();
      int len = visibleLength(cell);
      if (len > maxLen) maxLen = len;
    }
    return maxLen + 3; //khoảng cách cột
  });

  // In tiêu đề
  for (int i = 0; i < headers.length; i++) {
    stdout.write(padTextRight(headers[i], colWidths[i]));
  }
  print('');

  // In từng dòng dữ liệu của sinh viên
  for (var sv in danhSach) {
    for (int i = 0; i < sv.length; i++) {
      stdout.write(padTextRight(sv[i].toString(), colWidths[i]));
    }
    print('');
  }

  hienMenu();
}

// Hiển thị sinh viên điểm trung bình cao nhất
timSinhVienGioiNhat() {
  var svGioiNhat;
  if (danhSach.length > 0) {
    for (var sv in danhSach) {
      if (svGioiNhat == null) {
        svGioiNhat = sv;
      } else if (double.parse(svGioiNhat[5]) < double.parse(sv[5])) {
        svGioiNhat = sv;
      }
    }
    print(
      '\nSinh viên có ĐTB cao nhất là: ${svGioiNhat[1]} - STT[${svGioiNhat[0]}]',
    );
  } else {
    print('Thông báo: Danh sách sinh viên chưa có dữ liệu.');
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

// Hiển thị Menu
hienMenu() {
  print('\n========== MENU ==========');
  print(
    '[1] Thêm sinh viên. [2] Danh sách sinh viên. [3] Sinh viên có ĐTB cao nhất. [+] Thoát.',
  );
  stdout.write('👉 Nhập lựa chọn của bạn: ');
  String? input = stdin.readLineSync();

  switch (input) {
    case '1':
      themSinhVien();
      break;
    case '2':
      hienDanhSach();
      break;
    case '3':
      timSinhVienGioiNhat();
      break;
    case '+':
      running = false;
      print('Thông báo: Đã thoát chương trình!\n');
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
