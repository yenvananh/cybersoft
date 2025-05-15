import 'dart:io';

void main() {
  String? bienTenSP, bienSoLuong, bienDonGia;

  do {
    stdout.write('Nhập tên sản phẩm: ');
    bienTenSP = stdin.readLineSync();

    if (bienTenSP == null || bienTenSP.isEmpty) {
      print('Bạn chưa nhập tên sản phẩm hợp lệ, hãy nhập lại.\n');
    }
  } while (bienTenSP == null || bienTenSP.trim().isEmpty);

  do {
    stdout.write('Nhập số lượng mua: ');
    bienSoLuong = stdin.readLineSync();

    if (bienSoLuong == null || bienSoLuong.isEmpty) {
      print('Bạn chưa nhập số lượng mua hợp lệ, hãy nhập lại.\n');
    }
  } while (bienSoLuong == null || bienSoLuong.isEmpty);

  do {
    stdout.write('Nhập đơn giá: ');
    bienDonGia = stdin.readLineSync();

    if (bienDonGia == null || bienDonGia.isEmpty) {
      print('Bạn chưa nhập đơn giá hợp lệ, hãy nhập lại.\n');
    }
  } while (bienDonGia == null || bienDonGia.isEmpty);

  print('\n-----------------------------------------------------------------------------------');
  print('//                                    HÓA ĐƠN                                    //');
  print('-----------------------------------------------------------------------------------');
  print('Tên sản phẩm: ' + bienTenSP);
  print('Số lượng: ' + bienSoLuong);
  print('Đơn giá: ' + bienDonGia);
  print('-----------------------------------------------------------------------------------');

  double bienThanhTien = double.tryParse(bienSoLuong)! * double.tryParse(bienDonGia)!;
  print('(1) Thành tiền = ' + bienSoLuong.toString() + ' x ' + bienDonGia + ' = ' + bienThanhTien.toString());

  double bienGiamGia;
  String bienGiaGiam;
  if (bienThanhTien >= 1000000 ) {
    bienGiamGia = bienThanhTien * 10/100;
    bienGiaGiam = '10%';
  }
  else if (bienThanhTien >= 500000 ) {
    bienGiamGia = bienThanhTien * 5/100;
    bienGiaGiam = '5%';
  }
  else {
    bienGiamGia = 0;
    bienGiaGiam = '0%';
  }
  print('(2) Giảm giá = ' + bienThanhTien.toString() + ' x ' + bienGiaGiam + ' = ' + bienGiamGia.toString());

  double bienTienSauGiam = bienThanhTien - bienGiamGia;

  double bienThueVAT = bienTienSauGiam * 8/100;
  print('(3) Thuế VAT = (' + bienThanhTien.toString() + ' - ' + bienGiamGia.toString() + ') x 8% = ' + bienThueVAT.toString());

  double bienTongThanhToan = bienThanhTien - bienGiamGia + bienThueVAT;
  print('(4) Tổng thanh toán = (1) - (2) + (3) = ' + bienThanhTien.toString() + ' - ' + bienGiamGia.toString() + ' + ' + bienThueVAT.toString());
  print('-----------------------------------------------------------------------------------');
  print('(5) TỔNG THANH TOÁN: ' + bienTongThanhToan.toString() + '\n');
}
