function change_price(price)
{
  document.getElementById("premprice").innerHTML = price / 100;
  StripeCheckout.__app.configurations.button0.amount = price
}