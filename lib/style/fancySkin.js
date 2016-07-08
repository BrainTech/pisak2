.pragma library

.import "defaultSkin.js" as DefaultSkin

.import"../js/lodash.js" as Lodash


var style = Lodash._.cloneDeep(DefaultSkin.style);

style.button.normal.border = "#C99E10";
style.button.normal.background = "#8D230F";
style.button.normal.foreground = "#C99E10";

style.button.focusable.border = "#8D230F";
style.button.focusable.background = "#C99E10";
style.button.focusable.foreground = "#8D230F";

style.button.focus.border = "#1E434C";
style.button.focus.background = "#1E434C";
style.button.focus.foreground = "#9B4F0F";

style.button.active.border = "#9B4F0F";
style.button.active.background = "#9B4F0F";
style.button.active.foreground = "#8D230F";
