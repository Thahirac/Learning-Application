class CardInfoModel {
  String? cardNumber;
  String? expiryMonth;
  String? expiryYear;
  String? cvv;
  String? cardHolderName;
  String? mobileNumber;
  String? email;

  CardInfoModel(this.cardNumber, this.expiryMonth, this.expiryYear, this.cvv,
      this.cardHolderName, this.mobileNumber, this.email);
}

class NetBankingModel {
  String? bankKey;
  String? bankName;

  NetBankingModel(this.bankKey, this.bankName);
}

class WalletModel {
  String? walletName;

  WalletModel({this.walletName});
}
