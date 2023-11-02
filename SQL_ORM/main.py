import json

import sqlalchemy
from sqlalchemy.orm import sessionmaker

from models import create_tables, Publisher, Shop, Book, Stock, Sale

SQLsystem = 'postgresql'
login = 'postgres'
password = '35Pc5zTH47A7'
host = 'localhost'
port = '5432'
db_name = "netology_db"
DSN = f'{SQLsystem}://{login}:{password}@{host}:{port}/{db_name}'
engine = sqlalchemy.create_engine(DSN)

Session = sessionmaker(bind=engine)
session = Session()

create_tables(engine)

with open('tests_data.json', 'r') as db:
    data = json.load(db)
for line in data:
    method = {
        'publisher': Publisher,
        'shop': Shop,
        'book': Book,
        'stock': Stock,
        'sale': Sale,
    }[line['model']]
    session.add(method(id=line['pk'], **line.get('fields')))
session.commit()

if __name__ == '__main__':
    publ_name = input('Ведите имя писателя или id для вывода: ')
    if publ_name.isnumeric():
        for publ, book_title, shop_name, sale_price, sale_date in session.query(Publisher, Book.title, Shop.name,
                                                                                Sale.price, Sale.date_sale). \
                join(Book). \
                join(Stock). \
                join(Shop). \
                join(Sale).filter(Publisher.id == int(publ_name)).all():
            print(f'{book_title} | {shop_name} | {sale_price} | {sale_date}')
    else:
        for publ, book_title, shop_name, sale_price, sale_date in session.query(Publisher, Book.title, Shop.name,
                                                                                Sale.price, Sale.date_sale). \
                join(Book). \
                join(Stock). \
                join(Shop). \
                join(Sale).filter(Publisher.name.like(f'%{publ_name}%')).all():
            print(f'{book_title} | {shop_name} | {sale_price} | {sale_date}')
    session.close()
