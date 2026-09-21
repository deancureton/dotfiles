all:
	[ -f $(HOME)/.local/share/sketchybar_lua/sketchybar.so ] || (git clone --depth 1 https://github.com/FelixKratz/SbarLua.git /tmp/SbarLua && cd /tmp/SbarLua && $(MAKE) install && rm -rf /tmp/SbarLua) >/dev/null
	(cd event_providers && $(MAKE)) >/dev/null
	(cd menus && $(MAKE)) >/dev/null
