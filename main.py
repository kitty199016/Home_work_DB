from pathlib import Path
import os
import pandas as pd
from sqlalchemy import create_engine


DB_URL = "postgresql+psycopg2://postgres:postgres@localhost:5432/north"
engine = create_engine(DB_URL)
#Получаем список файлов в north_data
file_list = [f.name for f in Path('north_data').glob('*.csv')]
print(file_list)
for csv_file in file_list[:-1]:
    table_name = csv_file.split("_")[0]
    path = f"north_data/{csv_file}"
    # Проверяем, существует ли файл, чтобы скрипт не упал с ошибкой
    if not os.path.exists(path):
        print(f"Файл {path} не найден, пропускаем.")
        continue
    try:
        # Читаем CSV.
        df = pd.read_csv(path)

        # Отправляем в базу данных
        df.to_sql(
            name=table_name,
            con=engine,
            if_exists='append',
            index=False
        )

    except Exception as e:
        print(f"Ошибка при обработке файла {csv_file}: {e}")