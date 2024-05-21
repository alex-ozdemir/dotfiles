function witcher_saves {
    for save_path in \
        "$HOME/.local/share/cdprojektred/witcher2/GameDocuments/Witcher 2/gamesaves" \
        "$HOME/.local/share/Steam/steamapps/compatdata/20920/pfx/drive_c/users/steamuser/Documents/Witcher 2/gamesaves" \
        "$HOME/.local/share/Steam/userdata/84785672/20920/remote/";
        do
        pattern="DOESNTAPPEAR"
        for f in $(ls "$save_path" -s modified | rg 'AutoSave.*sav' | head -n -5 | rg -o 'AutoSave_\d*')
        do
            pattern+="|$f"
        done
        for f in $(ls "$save_path" | rg $pattern)
        do
            rm "$save_path/$f"
        done
    done
}
