# authorization
module home_authorization_system(
input [7:0] username, // 8-bit kullanıcı adı
input [7:0] password // 8-bit şifre
output reg authorized // Yetkilendirme sinyali
);

