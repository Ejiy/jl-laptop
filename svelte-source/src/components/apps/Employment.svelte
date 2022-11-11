<script lang="ts">
    import Notification from "@components/base/Notification.svelte";
    import Apps from "@components/shared/Apps.svelte";
    import { groupname, stages } from "@store/employment";
    import { notifications } from "@store/notifications";
    import { fetchNui } from "@utils/eventHandler";
    import { onMount } from "svelte";
    import { backOut, bounceOut } from "svelte/easing";
    import { scale } from "svelte/transition";
    const cssCode = `background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' version='1.1' xmlns:xlink='http://www.w3.org/1999/xlink' xmlns:svgjs='http://svgjs.com/svgjs' width='1440' height='560' preserveAspectRatio='none' viewBox='0 0 1440 560'%3e%3cg mask='url(%26quot%3b%23SvgjsMask1014%26quot%3b)' fill='none'%3e%3crect width='1440' height='560' x='0' y='0' fill='rgba(48%2c 48%2c 48%2c 1)'%3e%3c/rect%3e%3cpath d='M74.93 85.85 a32.95 32.95 0 1 0 65.9 0 a32.95 32.95 0 1 0 -65.9 0z' stroke='rgba(189%2c 113%2c 113%2c 1)'%3e%3c/path%3e%3cpath d='M1061.43 150.52a43.41 43.41 0 1 0-13.06 85.83z' fill='rgba(189%2c 113%2c 113%2c 1)'%3e%3c/path%3e%3cpath d='M149.76 502.74 a40.92 40.92 0 1 0 81.84 0 a40.92 40.92 0 1 0 -81.84 0z' stroke='rgba(189%2c 113%2c 113%2c 1)'%3e%3c/path%3e%3cpath d='M149.51 182.41a28.32 28.32 0 1 0 6.67 56.25z' fill='rgba(189%2c 113%2c 113%2c 1)'%3e%3c/path%3e%3cpath d='M1033.34 388.58 a49.54 49.54 0 1 0 99.08 0 a49.54 49.54 0 1 0 -99.08 0z' fill='rgba(189%2c 113%2c 113%2c 1)'%3e%3c/path%3e%3cpath d='M1373.57 179.81L1402.94 179.81L1402.94 204.4L1373.57 204.4z' stroke='rgba(189%2c 113%2c 113%2c 1)'%3e%3c/path%3e%3cpath d='M1011.36 533.51L1042.68 533.51L1042.68 564.83L1011.36 564.83z' fill='rgba(189%2c 113%2c 113%2c 1)'%3e%3c/path%3e%3cpath d='M1121.68 250.35a28.92 28.92 0 1 0 36.47 44.89z' stroke='rgba(189%2c 113%2c 113%2c 1)'%3e%3c/path%3e%3cpath d='M187.58 142.62 a44.17 44.17 0 1 0 88.34 0 a44.17 44.17 0 1 0 -88.34 0z' stroke='rgba(189%2c 113%2c 113%2c 1)'%3e%3c/path%3e%3cpath d='M978.23 38.04L1014.19 38.04L1014.19 85.67L978.23 85.67z' stroke='rgba(189%2c 113%2c 113%2c 1)'%3e%3c/path%3e%3cpath d='M255.25 328.8a35.16 35.16 0 1 0-49.15 50.29z' stroke='rgba(189%2c 113%2c 113%2c 1)'%3e%3c/path%3e%3cpath d='M224.78 128.47 a9.08 9.08 0 1 0 18.16 0 a9.08 9.08 0 1 0 -18.16 0z' fill='rgba(189%2c 113%2c 113%2c 1)'%3e%3c/path%3e%3cpath d='M361.55 487.74L371.44 487.74L371.44 497.63L361.55 497.63z' stroke='rgba(189%2c 113%2c 113%2c 1)'%3e%3c/path%3e%3cpath d='M911.6 554.29L932.32 554.29L932.32 575.01L911.6 575.01z' stroke='rgba(189%2c 113%2c 113%2c 1)'%3e%3c/path%3e%3cpath d='M1249.04 425.43a47.04 47.04 0 1 0 19.8 91.98z' stroke='rgba(189%2c 113%2c 113%2c 1)'%3e%3c/path%3e%3cpath d='M479.86 306.63L526.53 306.63L526.53 353.3L479.86 353.3z' fill='rgba(189%2c 113%2c 113%2c 1)'%3e%3c/path%3e%3cpath d='M1201.18 158.72 a1.05 1.05 0 1 0 2.1 0 a1.05 1.05 0 1 0 -2.1 0z' stroke='rgba(189%2c 113%2c 113%2c 1)'%3e%3c/path%3e%3cpath d='M995.18 126.16L1035.77 126.16L1035.77 166.75L995.18 166.75z' fill='rgba(189%2c 113%2c 113%2c 1)'%3e%3c/path%3e%3cpath d='M646.1 99.3L673.64 99.3L673.64 128.16L646.1 128.16z' fill='rgba(189%2c 113%2c 113%2c 1)'%3e%3c/path%3e%3cpath d='M1330.93 342.36 a0.9 0.9 0 1 0 1.8 0 a0.9 0.9 0 1 0 -1.8 0z' stroke='rgba(189%2c 113%2c 113%2c 1)'%3e%3c/path%3e%3cpath d='M1016.19 473.7 a23.59 23.59 0 1 0 47.18 0 a23.59 23.59 0 1 0 -47.18 0z' fill='rgba(189%2c 113%2c 113%2c 1)'%3e%3c/path%3e%3cpath d='M1175.19 463.56a16.07 16.07 0 1 0-7.38-31.28z' stroke='rgba(189%2c 113%2c 113%2c 1)'%3e%3c/path%3e%3cpath d='M1385.46 462.05L1429.48 462.05L1429.48 479.22L1385.46 479.22z' stroke='rgba(189%2c 113%2c 113%2c 1)'%3e%3c/path%3e%3cpath d='M392.54 79.22L441.88 79.22L441.88 128.56L392.54 128.56z' stroke='rgba(189%2c 113%2c 113%2c 1)'%3e%3c/path%3e%3cpath d='M372.55 395.2a50.26 50.26 0 1 0-30.17-95.88z' stroke='rgba(189%2c 113%2c 113%2c 1)'%3e%3c/path%3e%3cpath d='M331.93 286.83L363.7 286.83L363.7 318.6L331.93 318.6z' stroke='rgba(189%2c 113%2c 113%2c 1)'%3e%3c/path%3e%3cpath d='M333.8 46.48 a7.1 7.1 0 1 0 14.2 0 a7.1 7.1 0 1 0 -14.2 0z' fill='rgba(189%2c 113%2c 113%2c 1)'%3e%3c/path%3e%3cpath d='M1129.89 72.15L1136.38 72.15L1136.38 78.64L1129.89 78.64z' fill='rgba(189%2c 113%2c 113%2c 1)'%3e%3c/path%3e%3cpath d='M802.37 48.65L818.82 48.65L818.82 65.1L802.37 65.1z' fill='rgba(189%2c 113%2c 113%2c 1)'%3e%3c/path%3e%3cpath d='M389.7 451.89 a17.96 17.96 0 1 0 35.92 0 a17.96 17.96 0 1 0 -35.92 0z' stroke='rgba(189%2c 113%2c 113%2c 1)'%3e%3c/path%3e%3cpath d='M1417.15 266.02 a12.58 12.58 0 1 0 25.16 0 a12.58 12.58 0 1 0 -25.16 0z' stroke='rgba(189%2c 113%2c 113%2c 1)'%3e%3c/path%3e%3cpath d='M1310.34 492.17 a19.33 19.33 0 1 0 38.66 0 a19.33 19.33 0 1 0 -38.66 0z' fill='rgba(189%2c 113%2c 113%2c 1)'%3e%3c/path%3e%3cpath d='M65.36 366.23L113.51 366.23L113.51 404.66L65.36 404.66z' stroke='rgba(189%2c 113%2c 113%2c 1)'%3e%3c/path%3e%3c/g%3e%3cdefs%3e%3cmask id='SvgjsMask1014'%3e%3crect width='1440' height='560' fill='white'%3e%3c/rect%3e%3c/mask%3e%3c/defs%3e%3c/svg%3e");`;
    let page = "main";
    let topdata = {
        background: {
            css: cssCode,
        },
        color: "black",
        title: "Employment",
        blur: false,
    };

    let subpage = "job";
    function GetData() {
        fetchNui("getGroup").then((x) => {
            if (x) {
                groupname.set;
            }
        });
    }

    let name: string;
    let password: string;

    function Action(action: "create" | "join") {
        if (!name || name.length < 4)
            return notifications.send(
                "You must fill the group name (minimum 4 chars)",
                "employment"
            );

        if (!password || password.length < 4)
            return notifications.send(
                "You must fill the password, (minimum 4 chars)",
                "employment"
            );
        if (action == "create") {
            CreateGroup();
        } else if (action == "join") {
            JoinGroup();
        }
    }
    function CreateGroup() {
        fetchNui("creategroup", {
            name,
            password,
        }).then((x) => {
            if (!x.success) {
                return notifications.send(x.msg, "employment");
            } else {
                groupname.set(name);
                page = "group";
                name = null;
                password = null;
                return notifications.send(x.msg, "employment");
            }
        });
    }
    function JoinGroup() {}
    function ChangePage(to: string) {
        page = to;
    }

    function SetSubPage(sub: "job" | "member") {
        subpage = sub;
    }
    onMount(GetData);
</script>

<Apps {topdata} appname="employment">
    {#if page === "main"}
        <div class="create">
            <div class="box">
                <div class="top">
                    <img
                        style="width: 170px;"
                        src="https://media.discordapp.net/attachments/995214046414508094/995214463223464036/Comission_Alit_20220204211842.png"
                        alt="logo"
                    />
                    <div class="title">Employment</div>
                </div>
                <div class="input">
                    <div class="name">
                        <input
                            type="text"
                            placeholder="group name"
                            bind:value={name}
                        />
                    </div>
                    <div class="password">
                        <input
                            type="password"
                            placeholder="group password"
                            bind:value={password}
                        />
                    </div>
                </div>
                <div class="buttons">
                    <button class="create" on:click={() => Action("create")}
                        >Create</button
                    >
                    <button class="join" on:click={() => Action("join")}
                        >Join</button
                    >
                </div>
            </div>
        </div>
    {:else if page === "group"}
        <div class="navbar">
            <button
                class:selected={subpage == "job"}
                on:click={() => SetSubPage("job")}>Job</button
            >
            <button
                class:selected={subpage == "member"}
                on:click={() => SetSubPage("member")}>Member</button
            >
        </div>
        {#if subpage == "member"}
            Member
        {:else if subpage == "job"}
            <div style="padding: 0 30px; height: auto; overflow: hidden;">
                <div class="title">{$groupname}</div>
                <div
                    style="height: 100%; overflow-x: hidden; width: 100%; padding: 0 10px; "
                >
                    <div class="job-list">
                        {#each $stages as stage (stage.id)}
                            <div class="job-wrap">
                                <div class="some-left">
                                    <div
                                        class="batang"
                                        class:done={stage.done}
                                    />
                                    <div class="circle" />
                                </div>
                                <div class="stage">
                                    <div class="stage-title">
                                        {#if stage.done}
                                            <div
                                                in:scale|local={{
                                                    duration: 200,
                                                    easing: backOut,
                                                }}
                                                style="display: flex; justify-content: center;"
                                            >
                                                <ion-icon
                                                    name="checkmark-circle"
                                                    style="color: green; font-size: 25px;"
                                                />
                                            </div>
                                        {:else}
                                            <div
                                                style="display: flex; justify-content: center;"
                                            >
                                                <ion-icon
                                                    name="radio-button-on-sharp"
                                                    style="color: rgb(102, 160, 226); font-size: 25px;"
                                                />
                                            </div>
                                        {/if}
                                        {stage.name}
                                    </div>
                                    <div class="stage-description">
                                        {stage.description}
                                    </div>
                                </div>
                            </div>
                        {:else}
                            <div class="title" style="text-align:center;">
                                Waiting For Job...
                            </div>
                        {/each}
                    </div>
                </div>
            </div>
        {/if}
    {/if}
</Apps>

<style>
    .job-list {
        height: 100%;
        overflow-x: hidden;
        margin-bottom: 170px;
        display: flex;
        flex-direction: column;
        gap: 10px;
    }
    .some-left .circle {
        width: 8px;
        height: 8px;
        border-radius: 50%;
        background-color: rgb(255, 255, 255);
    }
    .some-left .batang.done {
        background-color: rgb(112, 226, 102);
    }
    .some-left .batang {
        width: 5px;
        height: 90%;
        background-color: rgb(102, 160, 226);
    }
    .some-left {
        display: flex;
        text-align: center;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        overflow: hidden;
        box-sizing: border-box;
        gap: 4px;
    }
    .stage {
        width: 100%;
        min-height: 55px;
        background-color: rgba(255, 255, 255, 0.822);
        backdrop-filter: blur(2px);
        box-sizing: border-box;
        border-radius: 2px;
        box-shadow: 1px 1px 1px 3px rgba(0, 0, 0, 0.53);
        padding: 1px 5px;
    }
    .stage-description {
        color: black;
        letter-spacing: 0.5px;
        font-size: large;
    }
    .stage-title {
        color: black;
        gap: 4px;
        font-size: 25px;
        display: flex;
        align-items: center;
    }
    .job-wrap {
        display: flex;
        height: auto;
        width: 100%;
        gap: 5px;
    }
    .navbar button.selected {
        background-color: rgb(216, 68, 68);
        transform: scale(1.03);
        cursor: default;
    }
    .navbar button {
        transition: transform 0.2s ease, background-color 0.2s ease;
        padding: 2px;
        box-sizing: border-box;
        text-align: center;
        min-width: 130px;
        height: 35px;
        border-radius: 35px;
        border: none;
        color: white;
        font-size: 25px;
        cursor: pointer;
        background-color: #cf4d4d;
    }
    .navbar {
        width: 100%;
        display: flex;
        gap: 15px;
        padding: 15px 30px;
    }
    .title {
        font-size: 45px;
    }
    .top {
        text-align: center;
    }
    * {
        font-family: "Bebas Neue", cursive;
    }
    .create {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100%;
    }
    .input {
        display: flex;
        flex-direction: column;
        gap: 10px;
        align-items: center;
    }
    input {
        width: 300px;
        height: 40px;
        color: black;
        font-size: 20px;
        box-sizing: border-box;
        padding: 5px;
        border: none;
        border-radius: 4px;
    }
    input:focus {
        outline: none;
        border: none;
    }
    .box {
        width: 350px;
        height: 450px;
        background-color: #cf4d4d;
        border-radius: 15px;
        box-shadow: 0px 21px 34px 5px rgba(0, 0, 0, 0.53);
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        overflow: hidden;
        padding: 20px 5px;
        box-sizing: border-box;
    }

    .buttons {
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 10px;
    }

    .buttons button {
        width: 145px;
        height: 40px;
        border-radius: 4px;
        border: none;
        font-size: 25px;
        letter-spacing: 1px;
        text-align: center;
        cursor: pointer;
    }
    button.join {
        background-color: #6a94ff;
    }
    button.create {
        background-color: #4f9d56;
    }
</style>
