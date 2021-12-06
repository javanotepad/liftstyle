class product {
  String? prdId;
  bool? isactive = true;
  bool? ispromoted = false;
  String? prddetails;
  String? prdimgurl;
  String? prdname;
  double? prdprice = 0.0;
  int? prdqty = 0;
  product(
      {this.prdId,
      this.isactive,
      this.ispromoted,
      this.prddetails,
      this.prdimgurl,
      this.prdname,
      this.prdprice,
      this.prdqty});
}
