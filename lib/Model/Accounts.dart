class Accounts{
  int? id;
  String? name;
  double? income;
  double? expense;
  String? date;
  String? transactionType;

  Accounts(this.id, this.name, this.income, this.expense, this.date, this.transactionType);

  Accounts.fromJson(Map<String, dynamic> Json){
    id=Json['id'];
    name=Json['name'];
    income=Json['income'];
    expense=Json['expense'];
    date=Json['date'];
    transactionType=Json['transactionType'];
  }
}