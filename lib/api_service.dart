import 'package:dio/dio.dart';
import 'package:intern_project/models/bank_nodels.dart';
import 'package:intern_project/models/performace.dart';

class ApiService {
  static Future<Bank?> getBankDetail() async {
    final res = await Dio().get(
        'https://api.stockedge.com/Api/SecurityDashboardApi/GetCompanyEquityInfoForSecurity/5051?lang=en');

    return Bank.fromJson(res.data as Map<String, dynamic>);
  }

  static Future<List<Performance>?> getPerformance() async {
    final res = await Dio().get(
        'https://api.stockedge.com/Api/SecurityDashboardApi/GetTechnicalPerformanceBenchmarkForSecurity/5051?lang=en');

    return (res.data as List)
        .map((e) => Performance.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
