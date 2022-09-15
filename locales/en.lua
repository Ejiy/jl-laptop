local Translations = {
    boosting = {
        error = {
            disable_fail = "You failed to disable the tracker",
            must_wait = "You must wait atleast %{time} Seconds",
            no_tracker = "This vehicle doesn't have a tracker",
            get_away = "Get away before anyone sees you!",
            cancelboost = "You failed to deliver the vehicle and contract has been terminated.",
        },
        success = {
            tracker_off = "There is %{tracker_left} trackers left",
            youllbepaid = "You will be paid when I sucessfully retracted the vehicle",
            gps_dropoff = "GPS updated with the drop-off location. Bring the car there.",
            received_reward = "You have received your reward of %{reward} crypto",
        },
        blips = {
            dropoff = "Boost Drop-off",
        },
        info = {
            tracker_backon = "Tracker back online!",
            phonenotify = "Boosting..",
            bought_boost = "Bought boost",
            rewardboost = "Finished boost",
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
            },
            queue = {
                success = "You joined the Queue!",
                successquit = "You Left the Queue!<",
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