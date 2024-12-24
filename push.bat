@echo off
:: Script to add, commit, and push untracked files one by one in a Git repository, with progress status
setlocal enabledelayedexpansion

:: Initialize counters
set total=0
set count=0

:: Fetch the list of untracked files and count them
for /f "tokens=*" %%f in ('git status --porcelain ^| findstr "^??"') do (
    set /a total+=1
)

:: Process each untracked file
for /f "tokens=*" %%f in ('git status --porcelain ^| findstr "^??"') do (
    set file=%%f
    :: Remove the '?? ' prefix to get the file path
    set file=!file:?? =!
    set /a count+=1
    echo Processing file [!count! of !total!]: "!file!"

    :: Git add, commit, and push
    git add "!file!"
    git commit -m "Adding file: !file!"
    git push

    echo Completed processing for: "!file!"
    echo --------------------------------------
)

:: Final message
echo All untracked files have been added, committed, and pushed.
pause
