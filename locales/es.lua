local Translations = {
    boosting = {
        error = {
            disable_fail = "No has podido desactivar el rastreador",
            no_tracker = "Este vehículo no tiene un rastreador",
            get_away = "Aléjate antes de que te vean!",
            cancelboost = "No ha entregado el vehículo y se ha terminado el contrato.",
        },
        success = {
            tracker_off = "El rastreador ha sido desactivado durante %{time} segundos, quedarán %{tracker_left} rastreadores",
            youllbepaid = "Se le pagará cuando haya retirado con éxito el vehículo",
            gps_dropoff = "GPS actualizado con el lugar de entrega. Lleva el coche allí.",
            received_reward = "Has recibido tu recompensa de %{reward} crypto",
            disable_tracker = "Eliminado con éxito el rastreador",
        },
        blip = {
            dropoff = "Boost Drop-off",
        },
        info = {
            tracker_backon = "El rastreador vuelve a estar en línea!",
            phonenotify = "Boosting..",
            bought_boost = "Boost Comprado",
            rewardboost = "Boost Finalizado",
        },

        command = {
            command_desc = "Dar contrato a un jugador",
            command_name_ID = "ID",
            command_help_ID = "ID Jugador",
            command_name_tier = "Tier",
            command_help_tier = "D/C/B/A/A+/S/S+",
            command_name_vehicle = "Vehículo",
            command_help_vehicle = "Nombre del vehículo",
            incorrect_type = "Tipo incorrecto",
            incorrect_vehicle = "Vehículo incorrecto",
            incorrect_tier = "Tier incorrecto",
            created = "Boost creado",
            player_offline = "Jugador no conectado.",
            not_inqueue = "Jugador que no está en la cola!",
            incorrect_format = "ID Formato incorrecto (debe ser un número)",
            missingarg = "Has olvidado un argumento!",
            command_tier_desc = "Elige boosting Tier de los jugadores",
        },

        laptop = {
            boosting = {
                success = "Has iniciado un boost!",
                cops = "No hay suficientes policías de servicio!",
                running = "Ya tienes un contrato en marcha!",
                notfound = "Contrato no encontrado!",
                notenough = "No hay suficiente GNE para iniciar el contrato!",
                busy = "No se ha podido localizar el coche, inténtelo más tarde!",
                error = "Error 69420 Inténtelo de nuevo!",
            },
            queue = {
                success = "Te has unido a la cola!",
                successquit = "Has dejado la cola!<",
                running = "No se puede entrar en la cola mientras se hace un contrato!",
                inqueue = "Ya está en la cola de espera!",
                error = "Error 404 Inténtelo de nuevo!",
            },
            transfer = {
                success = "Contrato transferido al ID del Estado: %{id}",
                self = "No puedes transferirte el contrato a ti mismo!",
                notfound = "Jugador no encontrado!",
                full = "El DNI estatal tiene demasiados contratos!",
                error = "Error 404 Inténtelo de nuevo!",
            },
            must_wait = "Debe esperar 10 segundos para denegar otro contrato!",
            declinedboost = "Has rechazado el boost!",
            try_again = "Error! Inténtelo de nuevo"
        },
    },
    bennys = {
        warehouse = "View Warehouse Stock",
    },
    darkweb = {
        target = {
            breakcrateopen = "Romper la caja",
            opencrate = "Abrir Caja",
        },
        need_drill = "No tienes las herramientas adecuadas",
    },
    main = {
        checkout = {
            bank = "No tiene suficiente dinero en su cuenta bancaria!!",
            full = "Ya tiene artículos sin reclamar en el almacén!",
            spaces = "Parece que no podemos encontrar un lugar para dejar tu caja..",
            crypto = "No tiene suficiente crypto!",
            done_darkweb = "¡Ve rápido!, recoge la caja antes de que alguien más la consiga",
            done_else = "Ahora puede recoger los artículos en el almacén",

        }
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
