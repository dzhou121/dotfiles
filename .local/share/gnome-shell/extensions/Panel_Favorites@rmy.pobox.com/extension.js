// Copyright (C) 2011-2012 R M Yorston
// Licence: GPLv2+

const Clutter = imports.gi.Clutter;
const Gio = imports.gi.Gio;
const Lang = imports.lang;
const Shell = imports.gi.Shell;
const St = imports.gi.St;
const Mainloop = imports.mainloop;

const AppFavorites = imports.ui.appFavorites;
const Main = imports.ui.main;
const Tweener = imports.ui.tweener;

const PANEL_LAUNCHER_LABEL_SHOW_TIME = 0.15;
const PANEL_LAUNCHER_LABEL_HIDE_TIME = 0.1;
const PANEL_LAUNCHER_HOVER_TIMEOUT = 300;

function PanelLauncher(app) {
    this._init(app);
}

PanelLauncher.prototype = {
    _init: function(app) {
        this.actor = new St.Button({ style_class: 'panel-launcher',
                                     reactive: true });
        let icon = app.create_icon_texture(18);
        this.actor.set_child(icon);
        this.actor._delegate = this;
        let text = app.get_name();
        if ( app.get_description() ) {
            text += '\n' + app.get_description();
        }

        this.label = new St.Label({ style_class: 'panel-launcher-label'});
        this.label.set_text(text);
        Main.layoutManager.addChrome(this.label);
        this.label.hide();
        this.actor.label_actor = this.label;

        this._app = app;
        this.actor.connect('clicked', Lang.bind(this, function() {
            this._app.open_new_window(-1);
        }));
        this.actor.connect('notify::hover',
                Lang.bind(this, this._onHoverChanged));
        this.actor.opacity = 207;
    },

    _onHoverChanged: function(actor) {
        actor.opacity = actor.hover ? 255 : 207;
    },

    showLabel: function() {
        this.label.opacity = 0;
        this.label.show();

        let [stageX, stageY] = this.actor.get_transformed_position();

        let itemHeight = this.actor.allocation.y2 - this.actor.allocation.y1;
        let itemWidth = this.actor.allocation.x2 - this.actor.allocation.x1;
        let labelWidth = this.label.get_width();

        let node = this.label.get_theme_node();
        let yOffset = node.get_length('-y-offset');

        let y = stageY + itemHeight + yOffset;
        let x = Math.floor(stageX + itemWidth/2 - labelWidth/2);

        let parent = this.label.get_parent();
        let parentWidth = parent.allocation.x2 - parent.allocation.x1;

        if ( Clutter.get_default_text_direction() == Clutter.TextDirection.LTR ) {
            // stop long tooltips falling off the right of the screen
            x = Math.min(x, parentWidth-labelWidth-6);
            // but whatever happens don't let them fall of the left
            x = Math.max(x, 6);
        }
        else {
            x = Math.max(x, 6);
            x = Math.min(x, parentWidth-labelWidth-6);
        }

        this.label.set_position(x, y);
        Tweener.addTween(this.label,
                         { opacity: 255,
                           time: PANEL_LAUNCHER_LABEL_SHOW_TIME,
                           transition: 'easeOutQuad',
                         });
    },

    hideLabel: function() {
        this.label.opacity = 255;
        Tweener.addTween(this.label,
                         { opacity: 0,
                           time: PANEL_LAUNCHER_LABEL_HIDE_TIME,
                           transition: 'easeOutQuad',
                           onComplete: Lang.bind(this, function() {
                               this.label.hide();
                           })
                         });
    },

    destroy: function() {
        this.label.destroy();
        this.actor.destroy();
    }
};

function PanelFavorites() {
    this._init();
}

PanelFavorites.prototype = {
    _init: function() {
        this._showLabelTimeoutId = 0;
        this._resetHoverTimeoutId = 0;
        this._labelShowing = false;

        this.actor = new St.BoxLayout({ name: 'panelFavorites',
                                        style_class: 'panel-favorites' });
        this._display();

        Shell.AppSystem.get_default().connect('installed-changed', Lang.bind(this, this._redisplay));
        AppFavorites.getAppFavorites().connect('changed', Lang.bind(this, this._redisplay));
    },

    _redisplay: function() {
        for ( let i=0; i<this._buttons.length; ++i ) {
            this._buttons[i].destroy();
        }

        this._display();
    },

    _display: function() {
        let launchers = global.settings.get_strv(AppFavorites.getAppFavorites().FAVORITE_APPS_KEY);

        this._buttons = [];
        let j = 0;
        for ( let i=0; i<launchers.length; ++i ) {
            let app = Shell.AppSystem.get_default().lookup_app(launchers[i]);

            if ( app == null ) {
                continue;
            }

            let launcher = new PanelLauncher(app);
            this.actor.add(launcher.actor);
            launcher.actor.connect('notify::hover',
                        Lang.bind(this, function() {
                            this._onHover(launcher);
                        }));
            this._buttons[j] = launcher;
            ++j;
        }
    },

    // this routine stolen from dash.js
    _onHover: function(launcher) {
        if ( launcher.actor.hover ) {
            if (this._showLabelTimeoutId == 0) {
                let timeout = this._labelShowing ?
                                0 : PANEL_LAUNCHER_HOVER_TIMEOUT;
                this._showLabelTimeoutId = Mainloop.timeout_add(timeout,
                    Lang.bind(this, function() {
                        this._labelShowing = true;
                        launcher.showLabel();
                        return false;
                    }));
                if (this._resetHoverTimeoutId > 0) {
                    Mainloop.source_remove(this._resetHoverTimeoutId);
                    this._resetHoverTimeoutId = 0;
                }
            }
        } else {
            if (this._showLabelTimeoutId > 0) {
                Mainloop.source_remove(this._showLabelTimeoutId);
                this._showLabelTimeoutId = 0;
            }
            launcher.hideLabel();
            if (this._labelShowing) {
                this._resetHoverTimeoutId = Mainloop.timeout_add(
                    PANEL_LAUNCHER_HOVER_TIMEOUT,
                    Lang.bind(this, function() {
                        this._labelShowing = false;
                        return false;
                    }));
            }
        }
    },

    enable: function() {
        Main.panel._leftBox.insert_child_at_index(this.actor, 1);
    },

    disable: function() {
        Main.panel._leftBox.remove_actor(this.actor);
    }
};

function init() {
    return new PanelFavorites();
}
