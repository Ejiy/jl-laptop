export const isEnvBrowser = (): boolean => !(window as any).invokeNative;

export let currentDate: any;

export function setCurrentDate(date: any) {
  currentDate = date;
}
