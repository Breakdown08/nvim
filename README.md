## Убедиться в доступности системных переменных (может быть изменено)
```
export PATH="$HOME/.local/bin/nvim/bin:$PATH"
export PATH="$HOME/.local/go/bin:$PATH"
export GOPATH="$HOME/go"
export PATH="$HOME/go/bin:$HOME/.local/go/bin:$PATH"
```

Также необходимо убедиться в том, чтобы Godot вызывался по команде ```godot``` в терминале
```
ls -la /usr/local/bin/godot
```
lrwxrwxrwx 1 root root 47 month dd hh:mm /usr/local/bin/godot -> /your/path/to/godot.x86_64

Для создания символьной ссылки на исполняемый файл необходимо вызвать
```
ln -s /your/path/to/godot.x86_64 /usr/local/bin/godot
```
