//import 'dart:ffi';
import 'dart:io';

void main() {
  String? bienTen, bienGio, bienLuong;

  do {
    stdout.write('Nhập họ & tên của sinh viên: ');
    bienTen = stdin.readLineSync();

    if (bienTen == null || bienTen.isEmpty) {
      print('Bạn chưa nhập họ tên hợp lệ, hãy nhập lại.\n');
    }
  } while (bienTen == null || bienTen.trim().isEmpty);

  do {
    stdout.write('Nhập số giờ làm việc: ');
    bienGio = stdin.readLineSync();

    if (bienGio == null || bienGio.isEmpty) {
      print('Bạn chưa nhập số giờ hợp lệ, hãy nhập lại.\n');
    }
  } while (bienGio == null || bienGio.isEmpty);

  do {
    stdout.write('Nhập lương mỗi giờ: ');
    bienLuong = stdin.readLineSync();

    if (bienLuong == null || bienLuong.isEmpty) {
      print('Bạn chưa nhập lương hợp lệ, hãy nhập lại.\n');
    }
  } while (bienLuong == null || bienLuong.isEmpty);

  stdout.write('\nHọ tên nhân viên: ' + bienTen);

  double tongLuong = double.tryParse(bienGio)! * double.tryParse(bienLuong)!;
  stdout.write(
    '\nTổng lương = ' +
        double.parse(bienGio).toString() +
        ' x ' +
        double.parse(bienLuong).toString() +
        ' = ' +
        tongLuong.toString(),
  );

  double tongPhuCap = 0;
  if (tongLuong > 40) {
    tongPhuCap = tongLuong * 20 / 100;
  }
  stdout.write(
    '\nTổng phụ cấp = 20% x ' +
        tongLuong.toString() +
        ' = ' +
        tongPhuCap.toString(),
  );

  tongLuong += tongPhuCap;

  double tongThueTN;
  String? thongtinThue;
  if (tongLuong > 10000000) {
    tongThueTN = tongLuong * 10 / 100;
    thongtinThue = '10% x ' + tongLuong.toString() + ' = ';
  } else if (tongLuong >= 7000000) {
    tongThueTN = tongLuong * 5 / 100;
    thongtinThue = '5% x ' + tongLuong.toString() + ' = ';
  } else {
    tongThueTN = 0;
    thongtinThue = '';
  }
  stdout.write('\nThuế thu nhập = ' + thongtinThue + tongThueTN.toString());

  double luongThucLanh = tongLuong + tongPhuCap - tongThueTN;
  stdout.write(
    '\nLương thực lãnh = ' +
        tongLuong.toString() +
        ' + ' +
        tongPhuCap.toString() +
        ' - ' +
        tongThueTN.toString() +
        ' = ' +
        luongThucLanh.toString() +
        '\n\n',
  );
}
