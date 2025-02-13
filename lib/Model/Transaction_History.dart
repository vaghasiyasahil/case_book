class TransactionHistory{
  int? id;
  double? income;
  double? expense;
  String? notes;
  String? transactionType;
  String? date;
  String? time;
  String? userAcName;

  TransactionHistory(this.id, this.income, this.expense, this.notes, this.transactionType,
      this.date, this.time, this.userAcName);

  TransactionHistory.fromJson(Map<String,dynamic> Json){
    id=Json['id'];
    income=Json['income'];
    expense=Json['expense'];
    notes=Json['notes'];
    transactionType=Json['transactionType'];
    date=Json['date'];
    time=Json['time'];
    userAcName=Json['userAcName'];
  }
}