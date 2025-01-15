#!/bin/bash

# Hacer múltiples commits vacíos del 21 de noviembre de 2025 al 14 de enero de 2025
start_date="2024-11-21"
end_date="2025-01-14"

current_date="$start_date"

while [ "$current_date" != "$(date -I -d "$end_date + 1 day")" ]; do
  # Generar un número aleatorio de commits entre 10 y 20
  num_commits=$(shuf -i 10-20 -n 1)

  for i in $(seq 1 $num_commits); do
    # Generar una hora aleatoria para el commit
    random_hour=$(shuf -i 0-23 -n 1)
    random_minute=$(shuf -i 0-59 -n 1)
    random_second=$(shuf -i 0-59 -n 1)

    # Formatear la hora para asegurar dos dígitos
    formatted_time=$(printf "%02d:%02d:%02d" $random_hour $random_minute $random_second)

    # Establecer la fecha y hora del commit
    export GIT_COMMITTER_DATE="$current_date $formatted_time"
    GIT_AUTHOR_DATE="$current_date $formatted_time" git commit --allow-empty -m "Commit del día $current_date, número $i" --date="$current_date $formatted_time"
  done

  # Avanzar al siguiente día
  current_date=$(date -I -d "$current_date + 1 day")
done

# Push al repositorio remoto
git push origin main