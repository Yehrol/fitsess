import { Elm } from "./src/Main.elm";
import { Preferences } from "@capacitor/preferences";

try {
  Promise.all([getObject()]).then(function ([state]) {
    let app = Elm.Main.init({
      flags: {},
    });

    // app.ports.setStorage.subscribe(function (state) {
    //   Preferences.set({
    //     key: "user",
    //     value: JSON.stringify(state),
    //   });
    // });
  });
} catch (e) {
  console.log(e);
}

async function getObject() {
  const ret = await Preferences.get({ key: "user" });
  return ret.value ? JSON.parse(ret.value) : null;
}
