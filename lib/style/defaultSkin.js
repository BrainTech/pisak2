.pragma library

.import"../js/lodash.js" as Lodash


var _ = Lodash._;

var style = {
    button: {},
    textArea: {}
};

var defaults = {
    fontFamily: "Helvetica",
    fontPixelSize: 20
};

style.button.normal = {
    background: "white",
    foreground: "black",
    border: "black",
    radius: 8,
    borderWidth: 4,
    fontFamily: defaults.fontFamily,
    fontPixelSize: defaults.fontPixelSize
};

style.button.active = _.clone({border: "cyan",
                               background: "cyan",
                               foreground: "white"},
                              style.button.normal);

style.button.focus = _.defaultsDeep({border: "purple",
                                     background: "purple",
                                     foreground: "white"},
                                    style.button.normal);

style.button.focusable = _.defaultsDeep({border: "black",
                                         background: "black",
                                         foreground: "white"},
                                        style.button.normal);

style.button.disabled =  _.defaultsDeep({border: "grey",
                                         foreground: "grey"},
                                        style.button.normal);

style.textArea.cursorColor = "black"
