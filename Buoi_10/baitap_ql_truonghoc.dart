import 'dart:io';
import 'dart:mirrors';

List<Teacher> dsTeacher = [];
List<Student> dsStudent = [];
List<Classroom> dsClassroom = [];
bool? running;

class Person {
  int? id;
  String? name;
  int? age;
  String? gender;

  Person(this.id, this.name, this.age, this.gender);

  void Info() {
    stdout.write('ID: $id, Name: $name, Age: $age, Gender: $gender');
  }
}

class Student extends Person {
  String? grade;
  double toan;
  double ly;
  double hoa;
  double dtb; // Biến lưu giá trị

  Student(
    int? id,
    String? name,
    int? age,
    String? gender,
    this.grade,
    this.toan,
    this.ly,
    this.hoa,
  ) : dtb =
          ((toan + ly + hoa) / 3 * 10).ceil() /
          10, // Tính và gán điểm trung bình
      super(id, name, age, gender);

  @override
  void Info() {
    super.Info();
    print(', Grade: $grade, Toan: $toan, Ly: $ly, Hoa: $hoa, ĐTB: $dtb');
  }
}

class Teacher extends Person {
  String? subject;
  int? salary;
  String? classname;

  Teacher(
    int? id,
    String? name,
    int? age,
    String? gender,
    this.subject,
    this.salary,
  ) : super(id, name, age, gender);

  @override
  void Info() {
    super.Info();
    stdout.write(', Subject: $subject, Salary: $salary\n');
  }
}

class Classroom {
  int id;
  String name;
  List<Student> students = [];
  Teacher? teacher;

  Classroom(this.id, this.name);

  void addStudent(Student student) {
    students.add(student);
  }

  void assignTeacher(Teacher teacher) {
    this.teacher = teacher;
  }

  void Info() {
    print('Class ID: $id, Name: $name');
    if (teacher != null) {
      print('Teacher: ${teacher!.name}');
    }
    print('Students:');
    for (var student in students) {
      student.Info();
    }
  }
}

void main() {
  running = true;

  // Tạo dữ liệu ban đầu cho giáo viên
  Teacher teacher1 = Teacher(1, 'thay Hung', 40, 'Nam', 'Toan', 10000000);
  Teacher teacher2 = Teacher(2, 'co Ngan', 30, 'Nu', 'Ly', 12000000);
  dsTeacher.add(teacher1);
  dsTeacher.add(teacher2);

  // Tạo dữ liệu ban đầu cho học sinh
  Student student1 = Student(3, 'Hoai Thu', 15, 'Nu', '10A', 8.5, 10.0, 6.5);
  Student student2 = Student(4, 'Dong', 16, 'Nam', '10A', 9.0, 8.5, 7.0);
  Student student3 = Student(5, 'Thu', 17, 'Nu', '12B', 8.5, 7.0, 9.0);
  Student student4 = Student(6, 'Minh', 18, 'Nam', '12B', 9.0, 6.5, 7.5);
  dsStudent.add(student1);
  dsStudent.add(student2);
  dsStudent.add(student3);
  dsStudent.add(student4);

  // Tạo dữ liệu ban đầu cho lớp học
  Classroom classroom1 = Classroom(1, '10A');
  classroom1.assignTeacher(teacher1);
  classroom1.addStudent(student1);
  classroom1.addStudent(student2);

  Classroom classroom2 = Classroom(2, '12B');
  classroom2.assignTeacher(teacher2);
  classroom2.addStudent(student3);
  classroom2.addStudent(student4);

  dsClassroom.add(classroom1);
  dsClassroom.add(classroom2);

  while (running == true) {
    hienMenu();
  }
}

hienMenu() {
  print('\n==============================================================');
  print('|| PHẦN MỀM QUẢN LÝ TRƯỜNG HỌC - CYPERSOFT ||  Pro Version  ||');
  print('==============================================================');
  print('[==== MENU ====]   [0] Thoát chương trình');
  print(
    'QUẢN LÝ LỚP HỌC:   [1] DS lớp học    [2] Thêm lớp học    [3] Xóa lớp học    [4] Xem thông tin lớp học',
  );
  print(
    'QUẢN LÝ GIÁO VIÊN: [5] DS giáo viên  [6] Thêm giáo viên  [7] Xóa giáo viên  [8] Gán giáo viên vào lớp',
  );
  print(
    'QUẢN LÝ HỌC SINH:  [9] DS sinh viên [10] Thêm sinh viên [11] Xóa sinh viên [12] Gán sinh viên vào lớp\n',
  );

  stdout.write('👉 Nhập lựa chọn của bạn: ');
  String? input = stdin.readLineSync();

  switch (input) {
    case '1':
      print('\n---------------------------------------------------------');
      print('|                   DANH SÁCH LỚP HỌC                   |');
      print('---------------------------------------------------------');
      printList(dsClassroom);
      break;
    case '2':
      print('\n---------------------------------------------------------');
      print('|                      THÊM LỚP HỌC                     |');
      print('---------------------------------------------------------');
      themLopHoc();
      break;
    case '3':
      print('\n---------------------------------------------------------');
      print('|                       XÓA LỚP HỌC                     |');
      print('---------------------------------------------------------');
      xoaLopHoc();
      break;
    case '4':
      print('\n---------------------------------------------------------');
      print('|                 XEM THÔNG TIN LỚP HỌC                 |');
      print('---------------------------------------------------------');
      xemLopHoc();
      break;
    case '5':
      print('\n---------------------------------------------------------');
      print('|                  DANH SÁCH GIÁO VIÊN                  |');
      print('---------------------------------------------------------');
      capnhatLopDay();
      printList(dsTeacher);
      break;
    case '6':
      print('\n---------------------------------------------------------');
      print('|                    THÊM GIÁO VIÊN                     |');
      print('---------------------------------------------------------');
      themGiaoVien();
      break;
    case '7':
      print('\n---------------------------------------------------------');
      print('|                     XÓA GIÁO VIÊN                     |');
      print('---------------------------------------------------------');
      xoaGiaoVien();
      break;
    case '8':
      print('\n---------------------------------------------------------');
      print('|               GÁN GIÁO VIÊN VÀO LỚP HỌC               |');
      print('---------------------------------------------------------');
      ganGiaoVien();
      break;
    case '9':
      print('\n---------------------------------------------------------');
      print('|                  DANH SÁCH SINH VIÊN                  |');
      print('---------------------------------------------------------');
      printList(dsStudent);
      break;
    case '10':
      print('\n---------------------------------------------------------');
      print('|                    THÊM SINH VIÊN                     |');
      print('---------------------------------------------------------');
      themSinhVien();
      break;
    case '11':
      print('\n---------------------------------------------------------');
      print('|                     XÓA SINH VIÊN                     |');
      print('---------------------------------------------------------');
      xoaSinhVien();
      break;
    case '12':
      print('\n---------------------------------------------------------');
      print('|               GÁN SINH VIÊN VÀO LỚP HỌC               |');
      print('---------------------------------------------------------');
      ganSinhVien();
      break;
    case '0':
      running = false;
      print('Thông báo: Đã thoát chương trình!\n');
      exit(0);
    default:
      print('❌ Lựa chọn không hợp lệ. Vui lòng lựa chọn lại.');
  }
}

// Hàm chuyển đổi tên thuộc tính thành chữ hoa chữ cái đầu
String capitalize(String text) {
  if (text.isEmpty) return text;
  return text[0].toUpperCase() + text.substring(1);
}

String nhapThongTin(
  String thongtin, {
  bool number = false,
  bool gender = false,
}) {
  String? value;
  do {
    stdout.write('Nhập $thongtin: ');
    value = stdin.readLineSync();

    if (value == null || value.trim().isEmpty) {
      print('Bạn chưa nhập $thongtin hợp lệ, hãy nhập lại.\n');
    } else if (number && !RegExp(r'^\d+$').hasMatch(value.trim())) {
      print('Bạn phải nhập một số hợp lệ.\n');
      value = null;
    } else if (gender &&
        value.toUpperCase() != 'NAM' &&
        value.toUpperCase() != 'NU') {
      print('Bạn phải nhập "Nam" hoặc "Nu".\n');
      value = null;
    } else if (gender &&
        (value.toUpperCase() == 'NAM' || value.toUpperCase() == 'NU')) {
      value = capitalize(value.toLowerCase());
    }
  } while (value == null || value.trim().isEmpty);

  return value;
}

void xoaLopHoc() {
  bool coLopHoc = false;
  Classroom? LopHoc;

  do {
    print('DANH SÁCH CÁC LỚP HỌC HIỆN TẠI:');
    printList(dsClassroom);
    print('');

    int id = int.parse(nhapThongTin('Id của lớp học cần xóa', number: true));
    try {
      LopHoc = dsClassroom.firstWhere((lop) => lop.id == id);
    } catch (e) {
      LopHoc = null;
    }

    if (LopHoc != null) {
      coLopHoc = true;
      String tenLopHoc = LopHoc.name;
      dsClassroom.removeWhere((lop) => lop.id == id);
      print("Đã xóa lớp học: $tenLopHoc");
    } else {
      print("Không tìm thấy lớp học với id: $id. Hãy nhập lại.\n");
    }
  } while (coLopHoc != true);
}

void xemLopHoc() {
  int? idLopHoc;
  String? tenLopHoc;
  String tenGiaoVien = 'Chưa có giáo viên';
  Classroom? lopHoc;
  bool coLopHoc = false;

  if (dsClassroom.length < 1) {
    print('Hiện chưa có lớp học nào. Hãy thêm lớp học mới.');
  } else {
    do {
      print('DANH SÁCH CÁC LỚP HỌC HIỆN TẠI:');
      printList(dsClassroom);
      print('');
      try {
        idLopHoc = int.parse(
          nhapThongTin('Id của lớp học cần xem', number: true),
        );
        lopHoc = dsClassroom.firstWhere((lop) => lop.id == idLopHoc);

        if (lopHoc.teacher?.name != null) {
          tenGiaoVien = lopHoc.teacher!.name!;
        } else {}
      } catch (e) {
        lopHoc = null;
      }

      if (lopHoc != null) {
        coLopHoc = true;
        tenLopHoc = lopHoc.name;
      } else {
        print('Không có lớp học có Id là $idLopHoc. Hãy nhập lại.\n');
      }
    } while (coLopHoc != true);

    if (lopHoc != null) {
      print('\nTHÔNG TIN LỚP HỌC $tenLopHoc');
      print('Tên giáo viên: $tenGiaoVien');
      print('Danh sách học sinh & thông tin chi tiết:');
      printList(dsStudent, filters: {'grade': tenLopHoc});
    } else {}
  }
}

void themSinhVien() {
  String id = idGenerator(dsStudent).toString();
  String name = nhapThongTin('Tên của sinh viên');
  String age = nhapThongTin('Tuổi của sinh viên', number: true);
  String gender = nhapThongTin(
    'Giới tính của sinh viên (Nam / Nu)',
    gender: true,
  );
  String gradeNhap = nhapThongTin('Lớp của sinh viên');
  String toan = nhapThongTin('điểm Toán của sinh viên', number: true);
  String ly = nhapThongTin('điểm Lý của sinh viên', number: true);
  String hoa = nhapThongTin('điểm Hóa của sinh viên', number: true);

  // Nếu lớp nhấp vào không tồn tại thì không đưa vào dữ liệu lớp cho sinh viên
  String grade = "___";
  Classroom? lopHoc;
  try {
    lopHoc = dsClassroom.firstWhere((lop) => lop.name == gradeNhap);
  } catch (e) {
    lopHoc = null;
  }

  if (lopHoc != null) {
    grade = gradeNhap;
  } else {
    print(
      "Lớp học $gradeNhap không tồn tại nên thông tin lớp học của sinh viên được để trống.",
    );
  }

  Student newStudent = Student(
    int.parse(id),
    name,
    int.parse(age),
    gender,
    grade,
    double.parse(toan),
    double.parse(ly),
    double.parse(hoa),
  );
  dsStudent.add(newStudent);
  print('Đã thêm học sinh mới!');
}

void xoaSinhVien() {
  print('\nDANH SÁCH SINH VIÊN HIỆN TẠI:');
  printList(dsStudent);
  print('');

  int id = int.parse(nhapThongTin('Id của sinh viên cần xóa', number: true));

  Student? sinhVien;
  try {
    sinhVien = dsStudent.firstWhere((sv) => sv.id == id);
  } catch (e) {
    sinhVien = null;
  }

  if (sinhVien != null) {
    String? tenSinhVien = sinhVien.name;
    dsStudent.removeWhere((sv) => sv.id == id);
    print("Đã xóa sinh viên: $tenSinhVien");
  } else {
    print("Không tìm thấy sinh viên có id: $id");
  }
}

void themGiaoVien() {
  print('DANH SÁCH GIÁO VIÊN HIỆN TẠI:');
  capnhatLopDay();
  printList(dsTeacher);
  print('');

  String id = idGenerator(dsTeacher).toString();
  String name = nhapThongTin('Tên của giáo viên');
  String age = nhapThongTin('Tuổi của giáo viên', number: true);
  String gender = nhapThongTin(
    'Giới tính của giáo viên (Nam / Nu)',
    gender: true,
  );
  String subject = nhapThongTin('Môn giảng dạy');
  String salary = nhapThongTin('Lương của giáo viên', number: true);

  Teacher newTeacher = Teacher(
    int.parse(id),
    name,
    int.parse(age),
    gender,
    subject,
    int.parse(salary),
  );
  dsTeacher.add(newTeacher);
  print('Đã thêm giáo viên mới!');
}

void xoaGiaoVien() {
  print('\nDANH SÁCH GIÁO VIÊN HIỆN TẠI:');
  capnhatLopDay();
  printList(dsTeacher);
  print('');

  int id = int.parse(nhapThongTin('Id của giáo viên cần xóa', number: true));

  // Tìm giáo viên có id đã chọn
  Teacher? giaoVien;
  try {
    giaoVien = dsTeacher.firstWhere((gv) => gv.id == id);
  } catch (e) {
    giaoVien = null;
  }

  // Xóa thuộc tính lớp của giáo viên
  if (giaoVien != null) {
    String? tenGiaoVien = giaoVien.name;
    dsTeacher.removeWhere((gv) => gv.id == id);
    print("Đã xóa giáo viên: $tenGiaoVien");
  } else {
    print("Không tìm thấy giáo viên có id: $id");
  }

  // Xóa thuộc tính teacher của lớp
  dsClassroom.where((lop) => lop.teacher == giaoVien).forEach((lop) {
    lop.teacher = null;
  });
}

void themLopHoc() {
  bool daCoTen = false;
  int id = idGenerator(dsClassroom);
  Classroom? lopHoc;
  String tenLopHoc;

  do {
    print('DANH SÁCH LỚP HỌC HIỆN TẠI:');
    printList(dsClassroom);
    print('');
    tenLopHoc = nhapThongTin('tên lớp học mới').toUpperCase();

    try {
      lopHoc = dsClassroom.firstWhere((lop) => lop.name == tenLopHoc);
    } catch (e) {
      lopHoc = null;
    }

    if (lopHoc != null) {
      daCoTen = true;
      print('Đã có lớp học có tên là $tenLopHoc. Hãy chọn tên khác.\n');
    } else {
      daCoTen = false;
    }
  } while (daCoTen);

  Classroom newClassroom = Classroom(id, tenLopHoc);
  dsClassroom.add(newClassroom);
  print('Đã thêm lớp học mới $tenLopHoc.');
}

void ganSinhVien() {
  Student? sinhVien;
  bool coSinhVien = false;
  int? idSinhVien;
  String? tenSinhVien;

  Classroom? lopHoc;
  bool coLopHoc = false;
  int idLopHoc;
  String tenLopHoc = "___";

  do {
    print('\nDANH SÁCH SINH VIÊN:');
    printList(dsStudent);
    print('');

    idSinhVien = int.parse(
      nhapThongTin('Id của sinh viên cần gán vào lớp học', number: true),
    );

    // Tìm đối tượng sinh viên có Id này
    try {
      sinhVien = dsStudent.firstWhere((sv) => sv.id == idSinhVien);
    } catch (e) {
      sinhVien = null;
    }

    if (sinhVien != null) {
      coSinhVien = true;
      tenSinhVien = sinhVien.name;
    } else {
      print('Không tìm thấy sinh viên có Id: $idSinhVien. Hãy nhập lại.\n');
    }
  } while (!coSinhVien);

  do {
    print('\nDANH SÁCH CÁC LỚP HỌC HIỆN TẠI:');
    printList(dsClassroom);
    print('');

    idLopHoc = int.parse(
      nhapThongTin(
        'Id của lớp học cần gán sinh viên $tenSinhVien vào',
        number: true,
      ),
    );

    // Tìm đối tượng lớp học có Id này
    try {
      lopHoc = dsClassroom.firstWhere((lop) => lop.id == idLopHoc);
    } catch (e) {
      lopHoc = null;
    }

    if (lopHoc != null) {
      coLopHoc = true;
      tenLopHoc = lopHoc.name;
    } else {
      print('Không tìm thấy lớp học có Id: $idLopHoc. Hãy nhập lại.\n');
    }
  } while (!coLopHoc);

  if (sinhVien != null && lopHoc != null) {
    sinhVien.grade = lopHoc.name;
    print(
      'Đã gán sinh viên có tên là $tenSinhVien, và có Id là $idSinhVien vào lớp học $tenLopHoc.',
    );
  }
}

void ganGiaoVien() {
  bool coGiaoVien = false;
  bool coLopHoc = false;
  int idGiaoVien, idLopHoc;
  String? tenGiaoVien;
  String tenLopHoc = "Chưa có lớp học";
  Teacher? giaoVien;
  Classroom? lopHoc;

  do {
    print('\DANH SÁCH GIÁO VIÊN HIỆN TẠI:');
    capnhatLopDay();
    printList(dsTeacher);
    print('');
    idGiaoVien = int.parse(
      nhapThongTin('Id của giáo viên cần gán vào lớp học', number: true),
    );

    try {
      giaoVien = dsTeacher.firstWhere((gv) => gv.id == idGiaoVien);
    } catch (e) {
      giaoVien = null;
    }

    if (giaoVien != null) {
      coGiaoVien = true;
    } else {
      print('Không tìm thấy giáo viên có Id: $idGiaoVien. Hãy nhập lại.\n');
    }
  } while (coGiaoVien != true);

  do {
    print('\nDANH SÁCH LỚP HỌC:');
    printList(dsClassroom);
    print('');

    idLopHoc = int.parse(
      nhapThongTin('Id lớp học cần gán giáo viên vào', number: true),
    );

    try {
      lopHoc = dsClassroom.firstWhere((lop) => lop.id == idLopHoc);
      tenLopHoc = lopHoc.name;
    } catch (e) {
      giaoVien = null;
    }

    if (lopHoc != null) {
      coLopHoc = true;
    } else {
      print('Không tìm thấy lớp học có Id: $idLopHoc. Hãy nhập lại.\n');
    }
  } while (coLopHoc != true);

  // Xóa thuộc tính lớp học cho giáo viên nào đang được gán cho lớp này
  dsTeacher.where((gv) => gv.classname == tenLopHoc).forEach((gv) {
    gv.classname = "___";
  });

  // Tìm đối tượng giáo viên có Id này
  try {
    giaoVien = dsTeacher.firstWhere((gv) => gv.id == idGiaoVien);
  } catch (e) {
    giaoVien = null;
  }

  if (giaoVien != null) {
    // Gán thuộc tính lớp cho giáo viên này
    giaoVien.classname = tenLopHoc;

    // Xóa thông tin giáo viên ở lớp học cũ
    dsClassroom.where((lop) => lop.teacher == giaoVien).forEach((lop) {
      lop.teacher = null;
    });

    // Gán giáo viên vào lớp học mới
    try {
      lopHoc = dsClassroom.firstWhere((lop) => lop.id == idLopHoc);
    } catch (e) {
      lopHoc = null;
    }

    if (lopHoc != null) {
      lopHoc.teacher = giaoVien;

      print(
        "Đã gán giáo viên tên là $tenGiaoVien, có Id là $idGiaoVien vào lớp $tenLopHoc",
      );
    }

    // Không cần thêm lại giáo viên vào dsTeacher vì đã có sẵn
    capnhatLopDay();
  } else {
    print("Không tìm thấy giáo viên có Id là: $idGiaoVien");
  }
}

void capnhatLopDay() {
  for (Classroom lophoc in dsClassroom) {
    Teacher? gvLop = lophoc.teacher;
    if (gvLop != null) {
      for (Teacher gv in dsTeacher) {
        if (gv.id == gvLop.id) {
          gv.classname = lophoc.name;
          break;
        }
      }
    }
  }
}

// Hàm kiểm tra một thuộc tính có phải là danh sách hay không
bool isListType(VariableMirror variableMirror) {
  return variableMirror.type.isAssignableTo(reflectType(List));
}

// Hàm trả về chuỗi rỗng nếu dữ liệu là null, nếu dữ liệu là object thì trả về object.name
String safeToString(dynamic value) {
  if (value == null) return "";
  if (value is String || value is num || value is bool) {
    return value.toString();
  }
  if (value is Map && value.containsKey('name')) {
    return value['name']?.toString() ?? "";
  }
  try {
    var nameValue = value.name;
    return nameValue != null ? nameValue.toString() : "";
  } catch (e) {
    return "";
  }
}

// Hàm sinh ra số id mới cho một danh sách chứa các đối tượng có các thuộc tính id khác nhau
int idGenerator(List<dynamic> ds) {
  // Tập hợp lưu các id đã tồn tại
  final existingIds = <int>{};

  for (var obj in ds) {
    try {
      var id = obj.id;
      if (id is int && id > 0) {
        existingIds.add(id);
      }
    } catch (e) {
      // Nếu obj không có thuộc tính id thì bỏ qua
      continue;
    }
  }

  // Tìm số nguyên dương nhỏ nhất chưa có
  int i = 1;
  while (existingIds.contains(i)) {
    i++;
  }

  return i;
}

// Hàm in danh sách thông tin của các đối tượng trên một bảng
void printList<T>(List<T> items, {Map<String, dynamic>? filters}) {
  if (items.isEmpty) {
    stdout.writeln('Danh sách trống.');
    return;
  }

  // Áp dụng lọc nếu có filters
  if (filters != null && filters.isNotEmpty) {
    items = items.where((item) {
      final itemMirror = reflect(item);
      for (var entry in filters.entries) {
        final fieldSymbol = Symbol(entry.key.toLowerCase());
        try {
          var fieldValue = itemMirror.getField(fieldSymbol).reflectee;
          if (fieldValue.toString() != entry.value.toString()) {
            return false;
          }
        } catch (_) {
          return false; // Bỏ qua nếu không có trường này
        }
      }
      return true;
    }).toList();
  }

  if (items.isEmpty) {
    stdout.writeln('Không có dữ liệu.');
    return;
  }

  InstanceMirror instanceMirror = reflect(items.first);
  ClassMirror? classMirror = instanceMirror.type;

  List<String> personHeaders = [];
  List<String> childHeaders = [];

  while (classMirror != null && classMirror.simpleName != #Object) {
    var attributes = classMirror.declarations.entries
        .where(
          (entry) =>
              entry.value is VariableMirror &&
              !isListType(entry.value as VariableMirror),
        )
        .map((entry) => capitalize(MirrorSystem.getName(entry.key)))
        .toList();

    if (classMirror.superclass == null ||
        classMirror.superclass!.simpleName == #Object) {
      personHeaders.insertAll(0, attributes);
    } else {
      childHeaders.addAll(attributes);
    }

    classMirror = classMirror.superclass;
  }

  personHeaders = personHeaders.toSet().toList();
  childHeaders = childHeaders.toSet().toList();

  List<List<String>> table = [];

  List<String> headers = ['STT'] + personHeaders + childHeaders;
  table.add(headers);

  int stt = 1;
  for (var item in items) {
    InstanceMirror itemMirror = reflect(item);
    List<String> row =
        [stt.toString()] +
        personHeaders
            .map(
              (header) => safeToString(
                itemMirror.getField(Symbol(header.toLowerCase())).reflectee,
              ),
            )
            .toList() +
        childHeaders
            .map(
              (header) => safeToString(
                itemMirror.getField(Symbol(header.toLowerCase())).reflectee,
              ),
            )
            .toList();

    table.add(row);
    stt++;
  }

  List<int> columnWidths = List.generate(table[0].length, (index) {
    return table
        .map((row) => row[index].length)
        .reduce((a, b) => a > b ? a : b);
  });

  stdout.writeln(
    table[0]
        .asMap()
        .entries
        .map((entry) => entry.value.padRight(columnWidths[entry.key]))
        .join('   '),
  );

  stdout.writeln(
    '-'.padRight(
      columnWidths.reduce((a, b) => a + b) + (columnWidths.length - 1) * 3,
      '-',
    ),
  );

  for (int i = 1; i < table.length; i++) {
    stdout.writeln(
      table[i]
          .asMap()
          .entries
          .where((entry) => entry.value.trim().isNotEmpty)
          .map((entry) => entry.value.padRight(columnWidths[entry.key]))
          .join('   '),
    );
  }
}
