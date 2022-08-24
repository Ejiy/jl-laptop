<script lang="ts">
  import { modals } from "../../../../store/modals";

  export let name = "Cooler Lazzy";
  export let cid = "CBS32PEN";
  export let grades = "Cadet";
  export let profile =
    "https://cdn3.emoji.gg/emojis/3394-cursed-sad-cowboy.png";

  function IsValidImageURL(url: string) {
    const Regex = new RegExp(/(http(s?):)([/|.|\w|\s|-])*\.(?:jpg|gif|png)/g);
    return Regex.test(url);
  }

  function handleProfileChange() {
    modals.show({
      onCancel: (e) => {
        console.log("cancel");
      },
      onOk: (e) => {
        if (IsValidImageURL(e)) {
          profile = e;
        } else {
          console.log("invalid url");
        }
      },
      show: true,
      okText: "Save",
      title: "Change Profile",
      cancelText: "Cancel",
      description: "",
      input: true,
      inputPlaceholder: "URL",
      inputType: "text",
      inputValue: profile,
    });
  }
</script>

<div class="management">
  <div class="top">
    <div class="profile">
      <div class="photo-icon">
        <ion-icon name="camera-outline" on:click={handleProfileChange} />
      </div>
      <img src={profile} alt="profile" />
    </div>
    <div class="name">
      <span>{name}</span>
    </div>
  </div>
  <div class="info">
    <div class="cid">
      <span><b> CID </b> {cid}</span>
    </div>
    <div class="grades">
      <span><b> Grades </b> {grades}</span>
    </div>
    <div class="number">
      <span><b>Grades</b> 6969</span>
    </div>
  </div>
  <div class="buttons">
    <div class="fire">
      <button> Fire </button>
    </div>
    <div class="promote">
      <button> Promote </button>
    </div>
    <div class="demote">
      <button> Demote </button>
    </div>
  </div>
</div>

<style>
  .photo-icon:hover {
    cursor: pointer;
    opacity: 70%;
  }
  .photo-icon {
    transition: all 0.3s ease-in-out;
    opacity: 1%;
    display: flex;
    justify-content: center;
    align-items: center;
    background-color: rgba(0, 0, 0, 0.441);
    font-size: 3rem;
    overflow: hidden;
    border-radius: 50%;
    position: absolute;
    width: 60px;
    height: 60px;
  }
  .info div {
    text-align: center;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 5px;
  }
  .info {
    font-size: 17px;
    display: flex;
    align-items: center;
    justify-content: space-around;
  }
  button {
    cursor: pointer;
    border-radius: 3px;
    font-size: 17px;
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 3px;
    background-color: transparent;
    box-shadow: -2px 2px 7px 2px #00000026;
    border: none;
    width: 5rem;
    height: 1.9rem;
  }
  .buttons {
    display: flex;
    justify-content: space-between;
  }
  .name {
    font-size: 20px;
    font-weight: 500;
  }
  .profile img {
    width: 100%;
  }
  .profile {
    overflow: hidden;
    border-radius: 50%;
    background-color: white;
    width: 60px;
    height: 60px;
  }
  .top {
    padding: 0 10px;
    width: 100%;
    align-items: center;
    display: flex;
    justify-content: space-between;
  }
  .management {
    display: flex;
    justify-content: space-between;
    flex-direction: column;
    width: 19rem;
    height: 12rem;
    background-color: rgba(255, 255, 255, 0.065);
    box-shadow: -8px -6px 26px 3px rgba(0, 0, 0, 0.24);
    border-radius: 10px;
    padding: 10px;
  }
</style>
