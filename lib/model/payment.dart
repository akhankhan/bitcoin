class PaymentModel {
  String? id;
  String? amount;
  String? dateTime;

  PaymentModel({
    this.id,
    this.amount,
    this.dateTime,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      id: json["id"],
      amount: json["amount"],
      dateTime: json["date_time"] ?? "",
    );
  }
}
