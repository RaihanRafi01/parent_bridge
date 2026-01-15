// Use this as is in your models folder
class StripeCheckoutResponse {
  final bool success;
  final String message;
  final String checkoutUrl;

  StripeCheckoutResponse({
    required this.success,
    required this.message,
    required this.checkoutUrl,
  });

  factory StripeCheckoutResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    return StripeCheckoutResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      checkoutUrl: data['checkout_url'] ?? '',
    );
  }
}