import { writable, derived } from "svelte/store";
import { onDestroy } from "svelte";
import oldNotifications from "./oldnotification";
import { apps } from "./config";
const TM = 1000;

let appsdata = [];
const app = apps.subscribe((d) => {
  appsdata = d;
});

function newNotifStore(timeout) {
  const _notifications = writable([]);
  function send(message, app, timeout) {
    _notifications.update((n) => {
      const data = {
        id: randomID(),
        message,
        app: getAppData(app),
        timeout,
      };
      const audio = new Audio("./audio/pop.ogg");
      audio.play();
      audio.volume = 0.5;
      audio.onended = () => {
        audio.remove();
      };
      oldNotifications.update((old) => {
        return [...old, data];
      });
      return [...n, data];
    });
  }

  let timers = [];

  const notifications = derived(_notifications, ($_notifications, set) => {
    set($_notifications);
    if ($_notifications.length > 0) {
      timers = setTimeout(() => {
        _notifications.update((state) => {
          state.shift();
          return state;
        });
      }, $_notifications[0].timeout);
    }
    return () => {
      clearTimeout(timers);
    };
  });
  const { subscribe } = notifications;
  return {
    subscribe,
    send,
  };
}

function getAppData(app) {
  let filtered = appsdata.filter((d) => d.name === app);
  if (filtered.length > 0) return filtered[0];
}

function randomID() {
  return (
    Math.random().toString(36).substring(2, 15) +
    Math.random().toString(36).substring(2, 15)
  );
}

export const notifications = newNotifStore();
