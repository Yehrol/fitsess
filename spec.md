# Features

- there shouldnt be any validation button. everything should be auto saved/registered
- add new session (button)
  - a session should be name by the date. ex : "2025.04.18 session"
  - change the name of the new session button if a session already exist for the day (rename to something like "continue {date} session")
  - select an exercise (dropdown ?)
    - should be able to change the exercise (dropdown)
    - entering a value for this exercise (input)
      - value could be anything. do not restrict (can serve as note)
      - retrieve the last value for this exercise if possible and show it next to the field with the date (text)
    - add a way to select the metric ? keep it simple in the beginning. causing tons of issue otherwise for multi value exercise (ex: running which can have speed and tilt)
      - kg for weight, speed for running, etc..
    - add a way to say if the exercise was easy or not. indicator for next time (ex: garmin note after running)
  - add new exercise (dropdown or button ? maybe add if couldnt find or something like that)
    - should all exercise only be a label and a value ? cannot find a reason why it shouldnt be
    - only need a name/label to add a new exercise
    - should bring back to the session after adding
  - what should happen if we create a new session the same day ?
    - open the previous one ? probably. in case the app crashed or you want to change something
- check session history (button)
  - add a way to export everything to csv (or anything else)
- creation of presets
- check exercise ?
  - show some chart ?

---

- comment gerer le multi page avec elm capacitor ? genre si je fais back en swipant il se passe quoi ?
- chopper les infos de la derniere fois d'un exo risque d'etre compliqué au bout d'un moment. quand y aura pas de data c'est ez, mais ça va ralentir au fur et a mesure des sessions. trouver un autre moyen de sauvegarder les données ?
  - je pense que dans tous les cas fucked et du coup voir pour stocker les data dans 2 formats ?
    - mmh en vrai pas si complexe au final et me semble pas necessaire du tout. il faudra juste faire 1 check par session (O(n)) puisque nom exo stocké dans dict et pas besoin d'algo de distance
