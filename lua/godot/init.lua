-- Подключаем сервер (определение проекта + запуск server.pipe)
require("godot.server")

-- Если проект Godot найден — подключаем команды и сборку
if _G.is_godot_project then
    require("godot.commands")
    require("godot.build")
    end
