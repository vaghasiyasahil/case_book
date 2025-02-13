import 'package:case_book/Page/Main_Page.dart';
import 'package:case_book/Services/preferences.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class dbHelper{

  static late Database database;

  static Future<void> createTable() async {

    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'case_book');

    // Delete the database
    // await deleteDatabase(path);

    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(
              'CREATE TABLE transactionHistory (id INTEGER PRIMARY KEY, income double, expense double, notes text, transactionType text, date text, time text, userAcName text)'
          );
          await db.execute(
              'CREATE TABLE account (id INTEGER PRIMARY KEY, name text, income double, expense double, date text, transactionType text)'
          );
        }
    );
  }

  static void insertTransaction({required double income, required double expense, required String notes,required String transactionType,required String date,required String time,required String userAcName}){
    database.rawQuery("INSERT INTO transactionHistory (income, expense, notes, transactionType, date, time, userAcName) VALUES ($income, $expense, '$notes', '$transactionType', '$date', '$time', '$userAcName')");
  }

  static Future<List> selectTransactionAll(){
    String order=ascending?'ASC':'DESC';
    if(caseType=="All"){
      Future<List<Map<String, Object?>>> data=database.rawQuery("SELECT * FROM transactionHistory WHERE userAcName = '${preferences.getAccount()}' ORDER BY date $order");
      return data;
    }else if(caseType=="CashIn"){
      Future<List<Map<String, Object?>>> data=database.rawQuery("SELECT * FROM transactionHistory WHERE userAcName = '${preferences.getAccount()}' and income!=0.0 ORDER BY date $order");
      return data;
    }else{
      Future<List<Map<String, Object?>>> data=database.rawQuery("SELECT * FROM transactionHistory WHERE userAcName = '${preferences.getAccount()}' and income=0.0 ORDER BY date $order");
      return data;
    }
  }

  static Future<List> selectTransactionToday({required String date}){
    String order=ascending?'ASC':'DESC';
    if(caseType=="All"){
      Future<List<Map<String, Object?>>> data=database.rawQuery("SELECT * FROM transactionHistory WHERE date = '$date' and userAcName='${preferences.getAccount()}' ORDER BY date $order");
      return data;
    }else if(caseType=="CashIn"){
      Future<List<Map<String, Object?>>> data=database.rawQuery("SELECT * FROM transactionHistory WHERE date = '$date' and userAcName='${preferences.getAccount()}' and income!=0.0 ORDER BY date $order");
      return data;
    }else{
      Future<List<Map<String, Object?>>> data=database.rawQuery("SELECT * FROM transactionHistory WHERE date = '$date' and userAcName='${preferences.getAccount()}' and income=0.0 ORDER BY date $order");
      return data;
    }
  }

  static Future<List> selectTransactionRange({required String startDate,required String endDate}){
    String order=ascending?'ASC':'DESC';
    if(caseType=="All"){
      Future<List<Map<String, Object?>>> data=database.rawQuery("SELECT * FROM transactionHistory WHERE date BETWEEN '$startDate' AND '$endDate' and userAcName='${preferences.getAccount()}' ORDER BY date $order");
      return data;
    }else if(caseType=="CashIn"){
      Future<List<Map<String, Object?>>> data=database.rawQuery("SELECT * FROM transactionHistory WHERE date BETWEEN '$startDate' AND '$endDate' and userAcName='${preferences.getAccount()}' and income!=0.0 ORDER BY date $order");
      return data;
    }else{
      Future<List<Map<String, Object?>>> data=database.rawQuery("SELECT * FROM transactionHistory WHERE date BETWEEN '$startDate' AND '$endDate' and userAcName='${preferences.getAccount()}' and income=0.0 ORDER BY date $order");
      return data;
    }
  }

  static updateTransaction({required int id,required double income, required double expense, required String notes,required String transactionType,required String date,required String time,required String userAcName}){
    database.rawQuery("UPDATE transactionHistory SET income = $income, expense = $expense, notes = '$notes', transactionType = '$transactionType', date = '$date', time = '$time' WHERE userAcName = '$userAcName' and id='$id'");
  }

  static deleteTransaction(int id) {
    database.rawDelete("DELETE FROM transactionHistory WHERE id = $id");
  }

  static void insertAccount({required String name, required double income, required double expense,required String date,required String transactionType}){
    database.rawQuery("INSERT INTO account (name, income, expense, date, transactionType) VALUES ('$name', $income, $expense, '$date', '$transactionType')");
  }
  static Future<List<Map<String, Object?>>> selectAccount(){
    Future<List<Map<String, Object?>>> data=database.rawQuery("select * from account");
    return data;
  }

  static Future<List> selectTransactionAllUser(){
    Future<List<Map<String, Object?>>> data=database.rawQuery("select * from transactionHistory");
    return data;
  }

  static Future<List> selectTransactionTodayUser({required String date}){
    Future<List<Map<String, Object?>>> data=database.rawQuery("SELECT * FROM transactionHistory WHERE date = '$date'");
    return data;
  }

  static Future<List> selectTransactionRangeUser({required String startDate,required String endDate}){
    Future<List<Map<String, Object?>>> data=database.rawQuery("SELECT * FROM transactionHistory WHERE date BETWEEN '$startDate' AND '$endDate'");
    return data;
  }

  static Future<double> getTotalIncomeAll() async {
    String query = "SELECT SUM(income) as totalIncome FROM transactionHistory WHERE userAcName='${preferences.getAccount()}'";
    if (caseType == "CashIn") {
      query += " AND income != 0.0";
    } else if (caseType == "CashOut") {
      query += " AND income = 0.0";
    }
    final result = await database.rawQuery(query);
    if(result[0]['totalIncome']!=null){
      return double.parse(result[0]['totalIncome'].toString());
    }else{
      return 0;
    }
  }
  static Future<double> getTotalExpenseAll() async {
    String query = "SELECT SUM(expense) as totalExpense FROM transactionHistory where userAcName='${preferences.getAccount()}'";
    if (caseType == "CashIn") {
      query += " AND income != 0.0";
    } else if (caseType == "CashOut") {
      query += " AND income = 0.0";
    }
    final result = await database.rawQuery(query);
    if(result[0]['totalExpense']!=null){
      return double.parse(result[0]['totalExpense'].toString());
    }else{
      return 0;
    }
  }
  static Future<double> getDiffrentIncomeAndExpenseAll() async {
    double totalIncome=await getTotalIncomeAll();
    double totalExpense=await getTotalExpenseAll();
    return totalIncome-totalExpense;
  }

  static Future<double> getTotalIncomeDaily({required String date}) async {
    String query="SELECT SUM(income) as totalIncome FROM transactionHistory WHERE date = '$date' and userAcName='${preferences.getAccount()}'";
    if (caseType == "CashIn") {
      query += " AND income != 0.0";
    } else if (caseType == "CashOut") {
      query += " AND income = 0.0";
    }
    final result = await database.rawQuery(query);
    if(result[0]['totalIncome']!=null){
      return double.parse(result[0]['totalIncome'].toString());
    }else{
      return 0;
    }
  }
  static Future<double> getTotalExpenseDaily({required String date}) async {
    String query="SELECT SUM(expense) as totalExpense FROM transactionHistory WHERE date = '$date' and userAcName='${preferences.getAccount()}'";
    if (caseType == "CashIn") {
      query += " AND income!=0.0";
    } else if (caseType == "CashOut") {
      query += " AND income=0.0";
    }
    final result = await database.rawQuery(query);
    if(result[0]['totalExpense']!=null){
      return double.parse(result[0]['totalExpense'].toString());
    }else{
      return 0;
    }
  }
  static Future<double> getDiffrentIncomeAndExpenseDaily({required String date}) async {
    double totalIncome=await getTotalIncomeDaily(date: date);
    double totalExpense=await getTotalExpenseDaily(date: date);
    return totalIncome-totalExpense;
  }

  static Future<double> getTotalIncomeRange({required String startDate,required String endDate}) async {
    String query="SELECT SUM(income) as totalIncome FROM transactionHistory WHERE date BETWEEN '$startDate' AND '$endDate' and userAcName='${preferences.getAccount()}'";
    if (caseType == "CashIn") {
      query += " AND income != 0.0";
    } else if (caseType == "CashOut") {
      query += " AND income = 0.0";
    }
    final result = await database.rawQuery(query);
    if(result[0]['totalIncome']!=null){
      return double.parse(result[0]['totalIncome'].toString());
    }else{
      return 0;
    }
  }
  static Future<double> getTotalExpenseRange({required String startDate,required String endDate}) async {
    String query="SELECT SUM(expense) as totalExpense FROM transactionHistory WHERE date BETWEEN '$startDate' AND '$endDate' and userAcName='${preferences.getAccount()}'";
    if (caseType == "CashIn") {
      query += " AND income != 0.0";
    } else if (caseType == "CashOut") {
      query += " AND income = 0.0";
    }
    final result = await database.rawQuery(query);
    if(result[0]['totalExpense']!=null){
      print("Amount=${double.parse(result[0]['totalExpense'].toString())}");
      return double.parse(result[0]['totalExpense'].toString());
    }else{
      return 0;
    }
  }
  static Future<double> getDiffrentIncomeAndExpenseRange({required String startDate,required String endDate}) async {
    double totalIncome=await getTotalIncomeRange(startDate: startDate,endDate: endDate);
    double totalExpense=await getTotalExpenseRange(startDate: startDate,endDate: endDate);
    return totalIncome-totalExpense;
  }

  static Future<double> getTotalIncomeAllAllUser() async {
    String query = "SELECT SUM(income) as totalIncome FROM transactionHistory";
    if (caseType == "CashIn") {
      query += " AND income != 0.0";
    } else if (caseType == "CashOut") {
      query += " AND income = 0.0";
    }
    final result = await database.rawQuery(query);
    if(result[0]['totalIncome']!=null){
      return double.parse(result[0]['totalIncome'].toString());
    }else{
      return 0;
    }
  }
  static Future<double> getTotalExpenseAllAllUser() async {
    String query = "SELECT SUM(expense) as totalExpense FROM transactionHistory";
    if (caseType == "CashIn") {
      query += " AND income != 0.0";
    } else if (caseType == "CashOut") {
      query += " AND income = 0.0";
    }
    final result = await database.rawQuery(query);
    if(result[0]['totalExpense']!=null){
      return double.parse(result[0]['totalExpense'].toString());
    }else{
      return 0;
    }
  }
  static Future<double> getDiffrentIncomeAndExpenseAllAllUser() async {
    double totalIncome=await getTotalIncomeAll();
    double totalExpense=await getTotalExpenseAll();
    return totalIncome-totalExpense;
  }

  static Future<double> getTotalIncomeDailyAllUser({required String date}) async {
    String query="SELECT SUM(income) as totalIncome FROM transactionHistory WHERE date = '$date'";
    if (caseType == "CashIn") {
      query += " AND income != 0.0";
    } else if (caseType == "CashOut") {
      query += " AND income = 0.0";
    }
    final result = await database.rawQuery(query);
    if(result[0]['totalIncome']!=null){
      return double.parse(result[0]['totalIncome'].toString());
    }else{
      return 0;
    }
  }
  static Future<double> getTotalExpenseDailyAllUser({required String date}) async {
    String query="SELECT SUM(expense) as totalExpense FROM transactionHistory WHERE date = '$date'";
    if (caseType == "CashIn") {
      query += " AND income!=0.0";
    } else if (caseType == "CashOut") {
      query += " AND income=0.0";
    }
    final result = await database.rawQuery(query);
    if(result[0]['totalExpense']!=null){
      return double.parse(result[0]['totalExpense'].toString());
    }else{
      return 0;
    }
  }
  static Future<double> getDiffrentIncomeAndExpenseDailyAllUser({required String date}) async {
    double totalIncome=await getTotalIncomeDaily(date: date);
    double totalExpense=await getTotalExpenseDaily(date: date);
    return totalIncome-totalExpense;
  }

  static Future<double> getTotalIncomeRangeAllUser({required String startDate,required String endDate}) async {
    String query="SELECT SUM(income) as totalIncome FROM transactionHistory WHERE date BETWEEN '$startDate' AND '$endDate'";
    if (caseType == "CashIn") {
      query += " AND income != 0.0";
    } else if (caseType == "CashOut") {
      query += " AND income = 0.0";
    }
    final result = await database.rawQuery(query);
    if(result[0]['totalIncome']!=null){
      return double.parse(result[0]['totalIncome'].toString());
    }else{
      return 0;
    }
  }
  static Future<double> getTotalExpenseRangeAllUser({required String startDate,required String endDate}) async {
    String query="SELECT SUM(expense) as totalExpense FROM transactionHistory WHERE date BETWEEN '$startDate' AND '$endDate'";
    if (caseType == "CashIn") {
      query += " AND income != 0.0";
    } else if (caseType == "CashOut") {
      query += " AND income = 0.0";
    }
    final result = await database.rawQuery(query);
    if(result[0]['totalExpense']!=null){
      print("Amount=${double.parse(result[0]['totalExpense'].toString())}");
      return double.parse(result[0]['totalExpense'].toString());
    }else{
      return 0;
    }
  }
  static Future<double> getDiffrentIncomeAndExpenseRangeAllUser({required String startDate,required String endDate}) async {
    double totalIncome=await getTotalIncomeRange(startDate: startDate,endDate: endDate);
    double totalExpense=await getTotalExpenseRange(startDate: startDate,endDate: endDate);
    return totalIncome-totalExpense;
  }

  static updateAccountName({required int id,required String uName}){
    database.update('account', {'name':uName},where: 'id=?',whereArgs: [id]);
  }

  static deleteAccount({required String acName}) async {
    await database.delete('account',where: 'name=?',whereArgs: [acName]);
    await database.delete('transactionHistory',where: 'userAcName=?',whereArgs: [acName]);
  }

  static updateAccountOpeningBalance({required int id,required double uBalance,required bool isAddMoney,required String date,required String userAcName}){
    if(isAddMoney){
      database.update('account',{
        'income':uBalance,
        'expense':0.0,
        'date':'$date'
      },where: 'id=?',whereArgs: [id]);

      database.update('transactionHistory', {
        'date':'$date',
        'income':uBalance,
        'expense':0.0,
      },where: 'notes=? and userAcName=?',whereArgs: ['Opening Balance',userAcName]);
    }else{
      database.update('account',{
        'income':0.0,
        'expense':uBalance,
        'date':'$date'
      },where: 'id=?',whereArgs: [id]);

      database.update('transactionHistory', {
        'date':'$date',
        'income':0.0,
        'expense':uBalance,
      },where: 'notes=? and userAcName=?',whereArgs: ['Opening Balance',userAcName]);
    }
  }

}
