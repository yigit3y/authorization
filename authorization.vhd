 Authorization System
  module authorization_system(
    input [7:0] username,       // 8-bit kullanıcı adı
    input [7:0] password,       // 8-bit şifre
    output reg authorized       // Yetkilendirme sinyali
);
    // Sabit kullanıcı adı ve şifre belirleyelim
    parameter [7:0] USERNAME = 8'h55;  // Örneğin, kullanıcı adı: 0x55
    parameter [7:0] PASSWORD = 8'hAA;  // Örneğin, şifre: 0xAA
    // Yetkilendirme işlemi
    always @(*) begin
        if (username == USERNAME && password == PASSWORD)
            authorized = 1'b1;  // Kullanıcı adı ve şifre doğru ise yetkilendir
        else
            authorized = 1'b0;  // Yanlış ise yetkilendirme yok
    end
endmodule
## General Managament System
      module general_management_system(
    input [7:0] user_id,             // 8-bit kullanıcı kimliği
    input [1:0] role,                // 2-bit rol (00: User, 01: Admin, 10: Supervisor)
    input [1:0] operation,           // 2-bit işlem türü (00: Read, 01: Write, 10: Delete)
    output reg access_granted,       // Erişim izni
    output reg operation_success     // İşlem başarısı
);
    // Önceden tanımlanmış kullanıcı kimliği ve rolleri
    parameter [7:0] VALID_USER_ID = 8'hA5; // Sabit kullanıcı kimliği
    parameter [1:0] USER = 2'b00;
    parameter [1:0] ADMIN = 2'b01;
    parameter [1:0] SUPERVISOR = 2'b10;
    // Erişim kontrolü ve işlemi gerçekleştirme
    always @(*) begin
        // Varsayılan olarak izinleri kapat
        access_granted = 1'b0;
        operation_success = 1'b0;
        // Kimlik doğrulama
        if (user_id == VALID_USER_ID) begin
            access_granted = 1'b1;  // Kimlik doğrulandı, erişim izni ver
            case (role)
                USER: begin
                    // USER sadece okuma yapabilir
                    if (operation == 2'b00)
                        operation_success = 1'b1;  // Okuma başarılı
                end
                ADMIN: begin
                    // ADMIN okuma ve yazma yapabilir
                    if (operation == 2'b00 || operation == 2'b01)
                        operation_success = 1'b1;  // İşlem başarılı
                end
                SUPERVISOR: begin
                    // SUPERVISOR tüm işlemleri yapabilir (okuma, yazma, silme)
                    operation_success = 1'b1;  // İşlem başarılı
                end
                default: begin
                    // Geçersiz rol durumunda işlem başarısız
                    operation_success = 1'b0;
                end
            endcase
        end
    end
endmodule
      ## Smart Lighting System
      module smart_lighting_system(
    input light_sensor,            // Ortam ışık sensörü (1: karanlık, 0: aydınlık)
    input motion_sensor,           // Hareket sensörü (1: hareket var, 0: hareket yok)
    input manual_switch,           // Manuel açma-kapama düğmesi (1: açık, 0: kapalı)
    input [3:0] hour,              // Saat bilgisi (0-23 arası)
    output reg light               // Işık durumu (1: açık, 0: kapalı)
);
    // Belirli saatler için zamanlayıcı sınırları
    parameter NIGHT_START = 4'd18; // Akşam 18:00
    parameter NIGHT_END = 4'd6;    // Sabah 6:00
    // Akıllı aydınlatma kontrolü
    always @(*) begin
        // Manuel düğme açık ise ışığı aç
        if (manual_switch) begin
            light = 1'b1;
        end
        // Manuel düğme kapalı ve ışık sensörü karanlıkta ise
        else if (light_sensor) begin
            // Hareket varsa ışığı aç (harekete duyarlı)
            if (motion_sensor) begin
                light = 1'b1;
            end
            // Zamanlayıcıya bağlı ışık kontrolü (sadece gece saatlerinde açılır)
            else if ((hour >= NIGHT_START) || (hour < NIGHT_END)) begin
                light = 1'b1;
            end
            else begin
                light = 1'b0;
            end
        end
        // Diğer durumlarda ışığı kapat
        else begin
            light = 1'b0;
        end
    end
endmodule
      ## White Goods Control
      module white_goods_control(
    input manual_laundry,           // Çamaşır makinesi manuel açma (1: açık, 0: kapalı)
    input manual_dishwasher,        // Bulaşık makinesi manuel açma (1: açık, 0: kapalı)
    input manual_oven,              // Fırın manuel açma (1: açık, 0: kapalı)
    input [3:0] hour,               // Günün saat bilgisi (0-23)
    output reg laundry_on,          // Çamaşır makinesi durumu
    output reg dishwasher_on,       // Bulaşık makinesi durumu
    output reg oven_on              // Fırın durumu
);
    // Otomatik başlatma saatleri
    parameter LAUNDRY_AUTO_START = 4'10d;     // Çamaşır makinesi için otomatik başlatma saati (10:00)
    parameter DISHWASHER_AUTO_START = 4'd20; // Bulaşık makinesi için otomatik başlatma saati (20:00)
    parameter OVEN_AUTO_START = 4'd17;       // Fırın için otomatik başlatma saati (17:00)
    // Beyaz eşya kontrol sistemi
    always @(*) begin
        // Çamaşır Makinesi Kontrolü
        if (manual_laundry || (hour == LAUNDRY_AUTO_START)) begin
            laundry_on = 1'b1;  // Manuel açılmış veya otomatik saatinde
        end else begin
            laundry_on = 1'b0;  // Diğer durumlarda kapalı
        end
        // Bulaşık Makinesi Kontrolü
        if (manual_dishwasher || (hour == DISHWASHER_AUTO_START)) begin
            dishwasher_on = 1'b1;  // Manuel açılmış veya otomatik saatinde
        end else begin
            dishwasher_on = 1'b0;  // Diğer durumlarda kapalı
        end
        // Fırın Kontrolü
        if (manual_oven || (hour == OVEN_AUTO_START)) begin
            oven_on = 1'b1;  // Manuel açılmış veya otomatik saatinde
        end else begin
            oven_on = 1'b0;  // Diğer durumlarda kapalı
        end
    end
endmodule
     // Perde, Panjur ve Kapı Sontrol Sistemi
      module CurtainWindowDoorControl (
    input wire curtain_open,
    input wire window_open,
    input wire door_open,
    output wire curtain_status,
    output wire window_status,
    output wire door_status
);
    assign curtain_status = curtain_open;
    assign window_status = window_open;
    assign door_status = door_open;
endmodule

    // Klima Kontrol Sistemi
          module ClimateControl (
    input wire ac_on,
    input wire [1:0] ac_mode,
    input wire heater_on,
    input wire [1:0] heater_mode,
    output wire ac_status,
    output wire [1:0] current_ac_mode,
    output wire heater_status,
    output wire [1:0] current_heater_mode
);
    assign ac_status = ac_on;
    assign current_ac_mode = ac_mode;
    assign heater_status = heater_on;
    assign current_heater_mode = heater_mode;
endmodule


    // Güvenlik Sistemi
          module SafetySystem (
    input wire fire_detected,
    input wire burglar_detected,
    input wire activate_fire_extinguisher,
    input wire lock_door,
    output wire fire_alarm,
    output wire burglar_alarm,
    output wire fire_extinguisher_status,
    output wire door_locked
);
    assign fire_alarm = fire_detected;
    assign burglar_alarm = burglar_detected;
    assign fire_extinguisher_status = activate_fire_extinguisher;
    assign door_locked = lock_door;
endmodule

    //Sistem logicini tanımlayalım

              always(motion_sensor or arm_system) begin
                if (arm_system && motion_sensor) begin
                  alarm <= 1;        // Güvenlik sistemi aktif hareket algıladıysa alarm çalsın
                end else begin
                  alarm <= 0;       // Aksi durumda alarm kapalı olsun
                  end
          end

    endmodule 
            
                   
