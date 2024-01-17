import 'package:gsheets/gsheets.dart';
import 'package:user_data/models/user.dart';

class GSheetsService {
  // google sheets credentials json
  static const _credentialsJson = r'''
{
  "type": "service_account",
  "project_id": "gsheets-411414",
  "private_key_id": "446ecf8da8ceac857389463da82e668bc76987e4",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDZImXHdD9PQ8ct\nSUlONqJh3D89MZ2OD5gTJXnlpc0VaZ5kDsufz4l7TcbkfNwd+jZ2kaNn9JxbZZlS\nDrKLqyBjMuLPX+wSpXlYQIwkiTN5MQAAIv7dSQOaxO0IHE1zJ6WeJaelJ5aRMsoH\nP1nmVDTzVJorhNlg7woKGhrmaWpIyko6mnB3I+qxM0p8Q8AxOu9r8rMUR0Xs5AVU\nXREndjGZlEpifetUEhWs5HgpTQG5SZ6Vow+tjPyyAy+U5yx0OxLbakrm5YFdGghL\nLNGJbWcO1Ra0f41mirYtA6YIA2pKF3wDvsTjFiQLuhat9wRUtuq0Ilb1pPm9/1Xk\nImkTrp5nAgMBAAECgf8ozVHO/nmwzGTyrRyJ0C7KqT9X9sCoeRcmQ9jt1kXWZwZg\naes2u63nmOheTRg2qOk9w31pkzw7F0zqxVRi8kVGrFylAC8DI3JBPlwAFP5sha2F\n+/Y95Lx3Nfa5i5A4i6sylGS57ejszJqWydDJc41JYq/jZl0lSnCcZdcNEE2ubyMO\nmzoBPWGXvOGI3LnXWZfs8hjKCLT1duF4hRQj+b77lP0t3CXTf7flH/gIjizFxszm\njAW63E4vH6zy2fT0cPm461Awo2YVNfZgr3JNd+DpK95ASPDI7o4j/pn9ziHjcpDi\nUzxlLIzfDxgqNCVqOcy6rSaUv+MOCwYTLbaLZmUCgYEA9LUypNIMS08BMs6cq76h\nPs6SaW/0EsR9I+/3ptblVAK/+9PD4kd8S1b0lJ/FaZU4vcyVrkZohRTN223ZqIOR\ngvVN3Ef7t4A8i/QVyohFInGnGRHxmQU5/Vhq7Kff/OjsJHbukwuWwaObdXyCjW4b\nXUHuvDns0QYC+Wb8RJvcAx0CgYEA4yd3inf1EwLnFdNNe/EwQEhDtMIv/Elvjh++\npr1zO6oMLDC1ty/Yozr0Pc6AHbFYkq4MGOT7zZHk4ZhvqUEwbHAQoc3bIBa9J3Mr\nUHEfPa2auig7A7tAZgqD16+7j+gfKuPoocr+0+8oaDTJfI7/17Q0FQy4AcRfR3Yv\nvKORTFMCgYEA2+ZczUpIbABiFlMe7SMQaY1eest1LMxPnFTPWqkwSe9ysI1bMOOG\naXmJrmlpEHldFQpc09BHqpfIadBsUQdyYpmnzzUMmZjuT+IXFvqgDdTOETRTxGuy\n8dxbsbEmEnMJibcqqw81+WrZj5lFBG0WwBY4wALZsfhSAecu+USKUG0CgYEAsl6d\naegEU6dl2ieQopCj+PZF5DzP/WWU6Z9X0ArX37QJ1vFw36X8kUCL5bSvuaE3EgcF\njM7SQ3wapGNU2y1LXvsotEW3mZ0Bb2bqTkJl68LUyvUoUifJy9bZ7JYbzEbTopRQ\naivCqp0Tt7Arv1ly4OiqNRVFsG2I+858cb5nK+0CgYA8j3EY1hDGyd4k0+ntfPw7\na8//WhHLLN/wXt4jWHV8Qy3A+/1b2FaWn9WdQy36T+YZcdCAWNLbK/Jg7knOksyq\nlBSzSCeuYm+oCnPIZ67V02BMwMUG3GBHVnPX5AHZzqjiiHwfk8HWG0+LTR0+dQnd\nE8aM5n8pBtJcxkTUg2qKmg==\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheets@gsheets-411414.iam.gserviceaccount.com",
  "client_id": "105971717672790536847",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheets%40gsheets-411414.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}
''';

  // id
  static const _spreadsheetId = '1BgE5IO4R3DTF447UAEWwXXSbpAr1p7irZFthLGQtZEY';

  //gsheet obj
  static final _gsheets = GSheets(_credentialsJson);

  static Worksheet? _userSheets;

  //init
  static Future<void> init() async {
    try {
      final spreadsheet = await _gsheets.spreadsheet(_spreadsheetId);
      _userSheets = await _getWorkSheet(spreadsheet, title: 'users');

      //menambahkan header pada worksheet
      final header = UserHeader.getHeader();
      _userSheets!.values.insertRow(1, header);
    } catch (e) {
      throw Exception(e);
    }
  }

  //get worksheets
  //create atau get worksheet ketika aplikasi dijalankan
  static Future<Worksheet> _getWorkSheet(
    Spreadsheet spreadsheet, {
    required String title,
  }) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  //insert rows data
  static Future<void> insert(List<Map<String, dynamic>> rowLists) async {
    // jika data kosong return null
    if (_userSheets == null) return;

    _userSheets!.values.map.appendRows(rowLists);
  }
}
