class CommonResponse {
  
  final String responseMsg;
  final int responseCode;


  CommonResponse({this.responseCode, this.responseMsg});

  factory CommonResponse.fromJson(Map<String, dynamic> json){
    return CommonResponse(
      responseMsg: json["responseMessage"]?? "Some error occured. Please try again.",
      responseCode: json["responseCode"]?? 404);
  }
}