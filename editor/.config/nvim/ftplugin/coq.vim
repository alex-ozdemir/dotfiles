command! CoqLaunch call CoqLaunch()
command! CoqNext call CoqNext()
command! CoqUndo call CoqUndo()
command! CoqToCursor call CoqToCursor()
command! CoqStop call CoqStop()
command! CoqCancel call CoqCancel()
command! CoqDebug call CoqDebug()
command! CoqVersion call CoqVersion()
command! CoqBuild call CoqBuild()
command! -nargs=1 CoqQuery call CoqQuery(<f-args>)
command! -nargs=1 CoqCheck call CoqCheck(<f-args>)
command! -nargs=1 CoqLocate call CoqLocate(<f-args>)
command! -nargs=1 CoqPrint call CoqPrint(<f-args>)
command! -nargs=1 CoqSearch call CoqSearch(<f-args>)
command! -nargs=1 CoqSearchAbout call CoqSearchAbout(<f-args>)

hi default CheckedByCoq cterm=italic
hi default SentToCoq ctermbg=12 guibg=LimeGreen
set sts=2
set sw=2
