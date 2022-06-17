import { writable, derived } from "svelte/store";
import oldNotifications, { oldNotificationsType } from "./oldnotification";
import { apps, appType } from "./desktop";
import popsound from "../assets/audio/pop.ogg";
let appsdata: appType[];

const app = apps.subscribe((d) => {
  appsdata = d;
});

function newNotifStore() {
  const _notifications: any = writable([]);
  function send(message: string, app: string, timeout?: number) {
    _notifications.update((v: string[]) => {
      const data: unknown = {
        id: randomID(),
        message,
        app: getAppData(app),
        timeout: timeout ? timeout : 3000,
      };
      const audio = new Audio(popsound);
      audio.play();
      audio.volume = 0.5;
      audio.onended = () => {
        audio.remove();
      };
      oldNotifications.add(data as oldNotificationsType);
      return [...v, data];
    });
  }

  let timers: any;

  const notifications = derived(_notifications, ($_notifications: any, set) => {
    set($_notifications);
    if ($_notifications.length > 0) {
      timers = setTimeout(() => {
        _notifications.update((state: string[]) => {
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

function getAppData(app: string) {
  let filtered = appsdata.filter((d: appType) => d.name === app);
  console.log(filtered[0]);
  if (filtered.length > 0) return filtered[0];
}

function randomID() {
  return (
    Math.random().toString(36).substring(2, 15) +
    Math.random().toString(36).substring(2, 15)
  );
}

export const notifications = newNotifStore();
