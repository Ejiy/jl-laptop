local Translations = {
    boosting = {
        error = {
            disable_fail = "Você falhou em desabilitar o rastreador",
            no_tracker = "Este veículo não tem nenhum rasterador",
            get_away = "Saia antes que algueém veja você!",
            cancelboost = "Você falhou em entregar o veículo e o contrato foi cancelado.",
        },
        success = {
            tracker_off = "O rastreador foi desabilitado por %{time} segundos, Ainda faltam %{tracker_left} rastreadores",
            youllbepaid = "Você será pago quando eu receber com sucesso o veículo",
            gps_dropoff = "GPS atualizado com o local de entrega. Leve o carro até lá.",
            received_reward = "Você recebeu sua recompensa de %{reward} crypto",
            disable_tracker = "Removeu o rastreador com sucesso",
            vin_dropoff = "GPS atualizado com o local de raspagem, leve até lá para raspar"
        },
        blip = {
            dropoff = "Local de Entrega",
            vinscratch = "Local de Raspagem"
        },
        info = {
            tracker_backon = "Rastreador habilitado novamente!",
            phonenotify = "Boosting..",
            bought_boost = "Comprou boost",
            rewardboost = "Terminou boost",
        },
        command = {
            command_desc = "Dar boost para outro jogador",
            command_name_ID = "ID",
            command_help_ID = "ID do jogador",
            command_name_tier = "Tier",
            command_help_tier = "D/C/B/A/A+/S/S+",
            command_name_vehicle = "Veículo",
            command_help_vehicle = "Nome do Veículo",
            incorrect_type = "Tipo Incorreto",
            incorrect_vehicle = "Veículo Incorreto",
            incorrect_tier = "Incorrect Tier",
            created = "Boost Criado",
            player_offline = "Jogador não esta online.",
            not_inqueue = "Jogador não esta na fila!",
            incorrect_format = "Formato do ID Incorreto (deve ser número)",
            missingarg = "Falta argumento!",
            command_tier_desc = "Define um Tier específico de Boost"
        },

        laptop = {
            boosting = {
                success = "Você iniciou o boost!",
                cops = "Policiais insuficientes em serviço!",
                running = "Você já tem um contrato ativo!",
                notfound = "Contrato não encontrado!",
                notenough = "Crypto insuficiente para iniciar o contrato!",
                busy = "Veículo não localizado, tente novamente!",
                error = "Erro 69420 Tente novamente!",
                no_group = "Você precisa criar um grupo de trabalho primeiro",
                group_leader = "Você deve ser o líder do grupo para iniciar o trabalho"
            },
            queue = {
                success = "Você entrou na fila!",
                successquit = "Você saiu da fila!",
                running = "Você não pode entrar na fila com um contrato ativo!",
                inqueue = "Você já esta na fila!",
                error = "Erro 404 Tente novamente!",
            },
            transfer = {
                success = "Transferiu o contrato para o ID: %{id}",
                self = "Você não pode transferir o contrato para você mesmo!",
                notfound = "Jogador não encontrado!",
                full = "ID já tem muitos contratos disponíveis!",
                error = "Erro 404 Tente novamente!",
            },
            must_wait = "Você deve esperar 10 segundos para cancelar outro contrato!",
            declinedboost = "Você recusou um contrato!",
            try_again = "Erro! Tente novamente"
        },
    },
    bennys = {
        warehouse = "Veja o estoque do armazém",
    },
    darkweb = {
        target = {
            breakcrateopen = "Quebre para abrir a caixa",
            opencrate = "Abrir caixa",
        },
        need_drill = "Você não tem as ferramentas certas",
    },
    main = {
        checkout = {
            bank = "Você não tem dinheiro suficiente no banco!",
            full = "Você tem itens que não pegou no armazém!",
            spaces = "Não foi possível achar um lugar para deixar a caixa..",
            crypto = "Você não tem crypto suficiente!",
            done_darkweb = "Rápido!, pegue a caixa antes que alguem pegue!",
            done_else = "Agora você pode pegar os itens no armazém",

        }
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
