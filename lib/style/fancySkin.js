.pragma library

.import "defaultSkin.js" as DefaultSkin

.import"../js/lodash.js" as Lodash


var style = Lodash._.clone(DefaultSkin.style);

style.button.normal.border = "yellow";

style.button.focus.border = "pink";
