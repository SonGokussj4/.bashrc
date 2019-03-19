# Show list of project within public github repository of selected user
function ghuserepo() {
    GHUSER=SonGokussj4
    curl -s "https://api.github.com/users/$GHUSER/repos?per_page=100" | grep -o 'git@[^"]*'
}