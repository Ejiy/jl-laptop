local Translations = {
    boosting = {
        error = {
            disable_fail = "Tracker'ı devre dışı bırakamadınız.",
            no_tracker = "Bu araç bir tracker'a sahip değil.",
            get_away = "Birisi seni görmeden buradan uzaklaş!",
            cancelboost = "Aracı teslim edemediniz ve sözleşme feshedildi.",
        },
        success = {
            tracker_off = "Tracker %{time} saniyeliğine devre dışı bırakıldı. Geriye sadece %{tracker_left} tracker kaldı.",
            youllbepaid = "Aracı buradan çıkardığım zaman sana ödeme yapacağım.",
            gps_dropoff = "Drop-off lokasyonu belirlendi. Aracı oraya götür.",
            received_reward = "%{reward} kripto ödülünü aldınız.",
            disable_tracker = "Tracker'ı başarıyla kaldırdın.",
        },
        blip = {
            dropoff = "Boost Drop-off",
        },
        info = {
            tracker_backon = "Tracker tekrardan aktif!",
            phonenotify = "Boosting..",
            bought_boost = "Satın alınan boost",
            rewardboost = "Tamamlanan boost",
        },
        command = {
            command_desc = "Give a boost to a player",
            command_name_ID = "ID",
            command_help_ID = "Player ID",
            command_name_tier = "Seviye",
            command_help_tier = "D/C/B/A/A+/S/S+",
            command_name_vehicle = "Araç",
            command_help_vehicle = "araç ismi",
            incorrect_type = "Yanlış tür",
            incorrect_vehicle = "Yanlış Araç",
            incorrect_tier = "Yanlış Seviye",
            created = "Boost oluşturuldu",
            player_offline = "Oyuncu online değil.",
            not_inqueue = "Oyuncu boost sırasında değil!",
            incorrect_format = "ID Format'ı yanlış (bir sayı olmalı)",
            missingarg = "Bir argüman unuttun!",
            command_tier_desc = "Oyunun boost seviyesini ayarla"
        },

        laptop = {
            boosting = {
                success = "Bir boost başlattın!",
                cops = "Mesaide yeterli polis yok!",
                running = "Zaten devam eden bir sözleşmeniz var!",
                notfound = "Sözleşme bulunamadı!",
                notenough = "Sözleşmeyi başlatmak için yeterli GNE yok!",
                busy = "Araba bulunamadı, daha sonra tekrar deneyin!",
                error = "Hata 69420 Tekrar deneyin!",
            },
            queue = {
                success = "Sıraya girdin!",
                successquit = "Sıradan çıktın!<",
                running = "Sözleşme yaparken sıraya giremezsiniz!",
                inqueue = "Zaten sıradasın!",
                error = "Hata 404 Tekrar deneyin!",
            },
            transfer = {
                success = "Sözleşme transfer etme State ID: %{id}",
                self = "Kendine sözleşme transfer edemezsin!",
                notfound = "Oyuncu bulunamadı!",
                full = "State ID çok fazla sözleşmesi var!",
                error = "Hata 404 Tekrar deneyin!",
            },
            must_wait = "Başka bir sözleşmeyi reddetmek için 10 saniye beklemelisiniz!",
            declinedboost = "Boost'u reddettiniz!",
            try_again = "Hata! Tekrar deneyin"
        },
    },
    bennys = {
        warehouse = "Depo Stokunu Görüntüle",
    },
    darkweb = {
        target = {
            breakcrateopen = "Açık Sandığı Kır",
            opencrate = "Kutuyu aç",
        },
        need_drill = "Uygun eşyalara sahip değilsiniz",
    },
    main = {
        checkout = {
            bank = "Banka hesabınızda yeterli paranız yok!!",
            full = "Depoda zaten sahipsiz öğeleriniz var!",
            spaces = "Sandığınızı bırakacak bir yer bulamıyoruz gibi görünüyor..",
            crypto = "Yeterli kriptonuz yok!",
            done_darkweb = "Hızlı git!, sandığı kimse almadan önce al",
            done_else = "Artık eşyaları depodan teslim alabilirsiniz.",

        }
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
