Set-PSReadLineKeyHandler -Key "Ctrl+w" -Function BackwardKillword
Set-PSReadLineKeyHandler -Key "Ctrl+u" -Function BackwardDeleteLine
Set-PSReadLineKeyHandler -Key "Ctrl+a" -Function BeginningOfLine
Set-PSReadLineKeyHandler -Key "Ctrl+u" -Function EndOfLine
Set-PSReadLineKeyHandler -Key "Ctrl+p" -Function PreviousSuggestion
Set-PSReadLineKeyHandler -Key "Ctrl+n" -Function NextSuggestion
Set-PSReadLineKeyHandler -Key "Ctrl+y" -Function AcceptSuggestion
Set-PSReadLineKeyHandler -Key "Alt+p" -Function PreviousHistory
Set-PSReadLineKeyHandler -Key "Alt+n" -Function NextHistory
Set-PSReadLineOption -PredictionViewStyle ListView

Set-Alias lg lazygit.exe
Set-Alias g git.exe
