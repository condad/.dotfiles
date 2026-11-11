on run argv
  if (count of argv) is not 3 then
    error "Usage: osascript start-codex-session-ghostty.applescript <worktree-path> <session-name> <initial-prompt>"
  end if

  set worktreePath to item 1 of argv
  set sessionName to item 2 of argv
  set initialPrompt to item 3 of argv
  set launcherDirectory to do shell script ("dirname " & quoted form of (POSIX path of (path to me)))
  set attachLauncherPath to launcherDirectory & "/attach-codex-session.mjs"
  set statusPath to (do shell script "mktemp /private/tmp/codex-delegation-launch.XXXXXX")
  set commandLine to "node " & quoted form of attachLauncherPath & " " & quoted form of worktreePath & " " & quoted form of sessionName & " " & quoted form of initialPrompt & " " & quoted form of statusPath

  tell application "Ghostty"
    activate

    set cfg to new surface configuration
    set initial working directory of cfg to worktreePath
    set command of cfg to "/bin/zsh -lc " & quoted form of commandLine
    set wait after command of cfg to true

    set win to front window
    set taskTab to new tab in win with configuration cfg
    set taskTerminal to terminal 1 of taskTab
    focus taskTerminal
  end tell
  -- This is a verification handle, not a claim that terminal attachment worked.
  return statusPath
end run
