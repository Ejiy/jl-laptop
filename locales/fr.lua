local Translations = {
    boosting = {
        error = {
            disable_fail = "Vous n'avez pas réussi à désactiver le traqueur",
            no_tracker = "Ce véhicule n'est pas traqué",
            get_away = "Fuyez avant que quelqu'un vous ne vous voit!",
            cancelboost = "Vous n'avez pas réussi a livrer le véhicule et la mission a été terminée.",
        },
        success = {
            tracker_off = "Le traqueur est désactivé pendant %{time} secondes, Il restera %{tracker_left} traqueurs",
            youllbepaid = "Vous serez payé quand j'aurais récupéré le véhicule",
            gps_dropoff = "GPS mis-à-jour avec la position de livraison. Ramène-y la voiture.",
            received_reward = "Vous avez reçu votre récompense de %{reward} crypto",
            disable_tracker = "Traqueur désactivé avec succès!",
        },
        blip = {
            dropoff = "Livraison Boost",
        },
        info = {
            tracker_backon = "Traqueur réactivé!",
            phonenotify = "Boost..",
            bought_boost = "Acheté un boost",
            rewardboost = "Finis un boost",
        },
        command = {
            command_desc = "Donne un contrat à un joueur",
            command_name_ID = 'ID',
            command_help_ID = 'ID Joueur',
            command_name_tier = 'Tier',
            command_help_tier = 'D/C/B/A/A+/S/S+',
            command_name_vehicle = "Véhicule",
            command_help_vehicle = 'Nom du véhicule',
            incorrect_type = "Type incorrect",
            incorrect_vehicle = "Véhicule incorrect",
            incorrect_tier = "Tier incorrect",
            created = "Boost créé",
            player_offline = "Joueur introuvable",
            not_inqueue = "Le joueur n'est pas dans la queue!",
            incorrect_format = "Format d'ID Incorrect (doit être un nombre)",
            missingarg = "Vous avez oublié un argument!",
            command_tier_desc = "Défini le Tier du joueur"
        },

        laptop = {
            boosting = {
                success = "Vous avez commencé un boost!",
                cops = "Pas assez de policiers en service!",
                running = "Vous avez déjà un contrat actif!",
                notfound = "Contrat introuvable!",
                notenough = "Pas assez de crypto pour lancer le contrat!",
                busy = "Impossible de trouver la voiture, réessayez plus tard!",
                error = "Erreur 69420 Réessayez!",
            },
            queue = {
                success = "Vous avez rejoint la queue!",
                successquit = "Vous avez quitté la queue!<",
                running = "Vous ne pouvez pas rejoindre la queue pendant un contrat!",
                inqueue = "Vous êtes déjà dans la queue!",
                error = "Erreur 404 réessayez!",
            },
            transfer = {
                success = "Contrat transferé à l'ID: %{id}",
                self = "Vous ne pouvez pas transferer le contrat a vous-même!",
                notfound = "Joueur introuvable!",
                full = "L'ID à trop de contrats!",
                error = "Erreur 404 réessayez!",
            },
            must_wait = "Vous devez attendre 10 secondes avant de décliné un autre contrat!",
            declinedboost = "Vous avez décliné le contrat!",
            try_again = "Erreur! Réessayez"
        },
    },
    bennys = {
        warehouse = "Voir le stock de l'entrepôt",
    },
    darkweb = {
        target = {
            breakcrateopen = "Enfoncer la caisse",
            opencrate = "Ouvrir la caisse",
        },
        need_drill = "Vous n'avez pas les outils apropriés",
    },
    main = {
        checkout = {
            bank = "Vous n'avez pas assez d'argent dans votre comtpe en banque!!",
            full = "Vous avez déjà trop d'objets a l'entrepôt!",
            spaces = "Nous n'avons pas trouvé d'endroit oû livrer votre caisse..",
            crypto = "Vous n'avez pas assez de crypto!",
            done_darkweb = "Allez-vite! Récuperez la caisse avant les autres!",
            done_else = "Vous pouvez récuperer les objets a l'entrpôt",

        }
    }
}

if GetConvar('qb_locale', 'en') == 'fr' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
