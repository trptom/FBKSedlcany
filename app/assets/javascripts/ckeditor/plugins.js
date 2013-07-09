function createAdderPlugin(options) {
    var ret = {
        requires : ['richcombo'], //, 'styles' ],
        init: function(editor) {
            var _this_adder = this;
            var pluginName = _this_adder.name;

            editor.addCommand( pluginName, {
                exec : _this_adder.exec,
                canUndo : true
            });

            editor.ui.addRichCombo( _this_adder.name, {
                label : _this_adder.label,
                title : _this_adder.title,
                voiceLabel : _this_adder.voiceLabel,
                multiSelect : _this_adder.multiSelect,

                className : 'cke_format',

                panel : {
                    css: [ CKEDITOR.skin.getPath( 'editor' ) ].concat( editor.config.contentsCss ),
                    voiceLabel : editor.lang.panelVoiceLabel
                },

                init : function()
                {
                    var _this_ui = this;

                    $.ajax({
                        dataType: "json",
                        url: _this_adder.dataURL,
                        type: _this_adder.dateType,
                        async: false,

                        success: function(response) {
                            _this_adder.success(_this_adder, _this_ui, response);
                        },
                        error: function() {
                            _this_adder.error(_this_adder, _this_ui);
                        }
                    });
                },

                onClick : function( value ) {
                    _this_adder.onClick(_this_adder, editor, value);
                }
            });
        },

        name: null,
        label: null,
        title: null,
        voiceLabel: null,
        multiSelect: false,
        dataURL: "/",
        dataType: "GET",
        loadItemIndex: "items",
        linkURL: "/[#v#]",

        success: function( adder , ui , response ) {
            var items = response[adder.loadItemIndex]
            for (var a=0; a<items.length; a++) {
                if (items[a].value) {
                    ui.add(items[a].value, items[a].label, items[a].title);
                } else {
                    ui.startGroup(items[a].label);
                }
            }
        },
        error: function( adder , ui ) {
            ui.startGroup("Chyba při načítání...");
        },
        onClick: function( adder , editor , value ) {
            if (value != "") {
                value = value.split("|");
                editor.focus();
                editor.fire( 'saveSnapshot' );
                editor.insertHtml("<a href=\"" + adder.linkURL.replace("[#v#]", value[0]) + "\">" + value[1] + "</a>");
                editor.fire( 'saveSnapshot' );
            }
        },
        exec: function( editor ){}
    }

    for (var index in options) {
        ret[index] = options[index];
    }

    return ret;
}


CKEDITOR_ADDPLAYER_PLUGIN = createAdderPlugin({
    name: "addplayer",
    label: "Přidat hráče",
    title: "Přidat hráče",
    voiceLabel: "Přidat hráče",
    dataURL: "/plugins/ckeditor_addplayer",
    linkURL: "/players/[#v#]"
});

CKEDITOR_ADDTEAM_PLUGIN = createAdderPlugin({
    name: "addteam",
    label: "Přidat tým",
    title: "Přidat tým",
    voiceLabel: "Přidat tým",
    dataURL: "/plugins/ckeditor_addteam",
    linkURL: "/teams/[#v#]"
});

CKEDITOR.plugins.add(CKEDITOR_ADDPLAYER_PLUGIN.name, CKEDITOR_ADDPLAYER_PLUGIN);
CKEDITOR.plugins.add(CKEDITOR_ADDTEAM_PLUGIN.name, CKEDITOR_ADDTEAM_PLUGIN);
