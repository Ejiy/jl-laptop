local Translations = {
    boosting = {
        error = {
            disable_fail = "You failed to disable the tracker",
            no_tracker = "This vehicle doesn't have a tracker",
            get_away = "Get away before anyone sees you!",
            cancelboost = "You failed to deliver the vehicle and contract has been terminated.",
        },
        success = {
            tracker_off = "The tracker has been deactivated for %{time} seconds, There will be %{tracker_left} trackers left",
            youllbepaid = "You will be paid when I sucessfully retracted the vehicle",
            gps_dropoff = "GPS updated with the drop-off location. Bring the car there.",
            received_reward = "You have received your reward of %{reward} crypto",
            disable_tracker = "Successfully removed tracker",
            vin_dropoff = "GPS updated with vin location, go there to scratch the vin"
        },
        blip = {
            dropoff = "Boost Drop-off",
            vinscratch = "Vin Location"
        },
        info = {
            tracker_backon = "Tracker back online!",
            phonenotify = "Boosting..",
            bought_boost = "Bought boost",
            rewardboost = "Finished boost",
        },
        command = {
            command_desc = "Give a boost to a player",
            command_name_ID = "ID",
            command_help_ID = "Player ID",
            command_name_tier = "Tier",
            command_help_tier = "D/C/B/A/A+/S/S+",
            command_name_vehicle = "Vehicle",
            command_help_vehicle = "vehicles's name",
            incorrect_type = "Incorrect type",
            incorrect_vehicle = "Incorrect Vehicle",
            incorrect_tier = "Incorrect Tier",
            created = "Boost created",
            player_offline = "Player not online.",
            not_inqueue = "Player not in boost queue!",
            incorrect_format = "ID Format Incorrect (must be a number)",
            missingarg = "You forgot an argument!",
            command_tier_desc = "Sets the player's boosting Tier"
        },

        laptop = {
            boosting = {
                success = "You started a boost!",
                cops = "Not enough cops on Duty!",
                running = "You already have a contract running!",
                notfound = "Contract not found!",
                notenough = "Not enough GNE to start the contract!",
                busy = "Couldn't locate the car try again later!",
                error = "Error 69420 Try Again!",
                no_group = "You need to create a group job first",
                group_leader = "You must be the group leader to start the job"
            },
            queue = {
                success = "You joined the Queue!",
                successquit = "You Left the Queue!",
                running = "You cannot join queue while doing a contract!",
                inqueue = "You are already in the queue!",
                error = "Error 404 Try again!",
            },
            transfer = {
                success = "Transferred Contract to State ID: %{id}",
                self = "You cannot transfer the contract to yourself!",
                notfound = "Player not found!",
                full = "State ID has too many contracts!",
                error = "Error 404 Try again!",
            },
            must_wait = "You must wait 10 seconds to deny another contract!",
            declinedboost = "You declined the boost!",
            try_again = "Error! Try Again"
        },
    },
    bennys = {
        warehouse = "View Warehouse Stock",
    },
    darkweb = {
        target = {
            breakcrateopen = "Break Open Crate",
            opencrate = "Open Crate",
        },
        need_drill = "You don't have the appropriate tools",
    },
    main = {
        checkout = {
            bank = "You do not have enough money in your bank account!!",
            full = "You have unclaimed items at the Warehouse already!",
            spaces = "Seems like we can't find a place to drop your crate..",
            crypto = "You do not have enough crypto!",
            done_darkweb = "Go fast!, pickup the crate before anyone else get it",
            done_else = "You can now pickup the items at the warehouse",

        }
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
