# dotfiles 

Configuration repository for Linux, FreeBSD and OS X shell environments

## Initial User Configuration

### Append to ~/.netrc

```
machine github.com
login bviefhues
password <GitHub password>
```

### git Configuration and initial Pull

```
# for git version 2.x:
git config --global push.default simple

git config --global user.name "bviefhues"
git config --global user.email "bviefhues@users.noreply.github.com"

git clone https://github.com/bviefhues/dotfiles
```

## Update to latest version

```
make
```



