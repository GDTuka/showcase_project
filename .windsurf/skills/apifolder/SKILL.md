---
name: apifolder
description: A brief description, shown to the model to help it understand when to use this skill
---

Папка data должна выглядеть следующим образом.

data/
  models/
    remote/
        /request
            /get_user
            /get_habbits
        /response
            /register
            /login
            /get_habbits
        /dto
            /user
            /habbit
    local/
  api/
        /api
            /user_api.dart
            /habbit_api.dart
        /interceptors
            /logger_interceptor.dart
            /error_interceptor.dart
        
В папке models remote должны быть все модели для запросов и ответов.
В папке models local должны быть все модели для локального хранения.
В папке api должны быть все api классы.
Каждое отдельное api в отдельном файле
В папке interceptors должны быть все интерцепторы.
Каждый запрос имеет свой собственный файл
