<script>
    let shit = () => {
        console.log('shit')
    }
</script>

<div class="winmanager">
    <div class="left-icons">
        <div class="start-icon">
            <div class="icon-start">
                <img class="start" src="/images/logo.png" alt="icon">
            </div>
        </div>
    </div>
    <div class="right-icons">
        <i id="setting" class="fas fa-duotone fa-gear"></i>
        <i class="fas fa-solid fa-wifi"></i>
        <div class="times">
            <span id="time">4:05 PM</span>
            <span id="date">5/3/2022</span>
        </div>
        <!-- windows chat bubble -->
        <i class="fa-regular fa-message" style="cursor: pointer;"></i>
        <!-- 
        <i class="fas fa-wifi"></i>
        <i id="volume" class="fas fa-volume-up"></i>
        <i class="fas fa-battery-half"></i> -->
    </div>
</div>

<style>

    .times {
        display: flex;
        flex-direction: column;
        align-items: flex-end;
        font-size: 12px;
        font-family: "Segoe UI", sans-serif;
        margin: 0 15px;
    }
    .right-icons {
        display: flex;
        justify-content: center;
        align-items: center;
        position: absolute;
        padding: 15px;
        right: 0;
    }

    .right-icons i {
        font-size: 15px;
        margin: 0 10px;
    }
    .icon-start {
        border-radius: 3px;
    }

    .start {
        height: 40px;
    }
    .winmanager {
        padding: 0 10px;
        width: 100%;
        height: 40px;
        position: absolute;
        bottom: 0;
        background: rgba(30, 34, 81, 0.508);
        backdrop-filter: blur(10px);
        /* border-top: 1px solid rgba(28, 27, 27, 0.3); */
        display: flex;
        bottom: 0;
        align-items: center;
        z-index: 98;
    }
</style>