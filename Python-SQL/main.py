import psycopg2


def create_db(cursor):
    cursor.execute('''
        DROP TABLE phone_user;
        DROP TABLE user_info;
        ''')
    cursor.execute("""
        CREATE TABLE user_info(
        user_id SERIAL PRIMARY KEY,
        name VARCHAR(40) NOT NULL,
        surname VARCHAR(40) NOT NULL,
        email VARCHAR(60) NOT NULL
        );
        """)
    cursor.execute('''
        CREATE TABLE phone_user(
        id SERIAL PRIMARY KEY,
        number VARCHAR(11) UNIQUE NOT NULL,
        user_id INTEGER NOT NULL REFERENCES user_info(user_id)
        ); 
        ''')
    conn.commit()


def add_user(cursor, name, surname, email, number=''):
    cursor.execute('''
        INSERT INTO user_info(name, surname, email) 
        VALUES (%s, %s, %s);    
        ''', (name, surname, email))
    if number:
        cursor.execute('''
            INSERT INTO phone_user(number, user_id) 
            VALUES (%s, %s);    
            ''', (number, test_name(cursor, name)))


def add_number(cursor, number, user_id):
    if test_id(cursor, user_id) is not None:
        cursor.execute('''
            INSERT INTO phone_user(number, user_id) 
            VALUES (%s, %s);
            ''', (number, user_id))
    else:
        print('Клиента не существует')


def test_name(cursor, name):
    cursor.execute('''
            SELECT user_id FROM user_info 
            WHERE name=%s;
            ''', (name,))
    return cur.fetchone()[0]


def test_id(cursor, user_id):
    cursor.execute('''
        SELECT name FROM user_info 
        WHERE user_id=%s;
        ''', (user_id,))
    return cur.fetchone()


def change_user_info(cursor, user_id):
    if test_id(cursor, user_id) is not None:
        while True:
            print('Введите команту для изменения данных о клиента:\n'
                  '1 - изменить имя, 2 - изменить фамилию, 3 - изменить email, 4 - изменить телефон\n'
                  'q - для выхода')
            command = (input('Введите команду: '))
            if command == '1':
                new_name = str(input(f'Введите новое имя: '))
                cursor.execute('''
                    UPDATE user_info SET name=%s WHERE user_id=%s;
                    ''', (new_name, user_id))
            elif command == '2':
                new_surname = str(input(f'Введите новую фамилию: '))
                cursor.execute('''
                    UPDATE user_info SET surname=%s WHERE user_id=%s;
                    ''', (new_surname, user_id))
            elif command == '3':
                new_email = str(input(f'Введите новый email: '))
                cursor.execute('''
                    UPDATE user_info SET email=%s WHERE user_id=%s;
                    ''', (new_email, user_id))
            elif command == '4':
                old_number = str(input(f'Введите старый телефон: '))
                new_number = str(input(f'Введите новый телефон: '))
                cursor.execute('''
                    UPDATE phone_user SET number=%s WHERE number=%s;
                    ''', (new_number, old_number))
            elif command == 'q':
                break
            else:
                print('Неверная команда!')
    else:
        print('Клиента не существует')


def del_number(cursor, number: str, user_id):
    if test_id(cursor, user_id) is not None:
        cursor.execute('''
            DELETE FROM phone_user 
            WHERE user_id=%s AND number=%s;
            ''', (user_id, number))
    else:
        print('Клиента не существует')


def del_user(cursor, user_id):
    if test_id(cursor, user_id) is not None:
        cursor.execute('''
            DELETE FROM phone_user 
            WHERE user_id=%s;
            ''', (user_id,))
        cursor.execute('''
            DELETE FROM user_info 
            WHERE user_id=%s;
            ''', (user_id,))
    else:
        print('Клиента не существует')


def user_info(cursor, name='', surname='', email='', number=''):
    if not name:
        name = '%'
    else:
        name = '%' + name + '%'
    if not surname:
        surname = '%'
    else:
        surname = '%' + surname + '%'
    if not email:
        email = '%'
    else:
        email = '%' + email + '%'
    if not number:
        cursor.execute("""
              SELECT u.user_id FROM user_info u
              WHERE u.name LIKE %s AND u.surname LIKE %s
              AND u.email LIKE %s;
              """, (name, surname, email))
    else:
        cursor.execute("""
              SELECT u.user_id FROM user_info u
              LEFT JOIN phone_user pu ON u.user_id = pu.user_id
              WHERE u.name LIKE %s AND u.surname LIKE %s
              AND u.email LIKE %s AND pu.number LIKE %s;
              """, (name, surname, email, number))
    return f'Клиент номер: {cursor.fetchall()[0][0]}'


if __name__ == '__main__':
    with psycopg2.connect(database="DB", user='postgres', password='35Pc5zTH47A7') as conn:
        with conn.cursor() as cur:
            create_db(cur)
            add_user(cur, "Pol", "Filonov", "testpf@mail")
            add_user(cur, "Hanz", "Niman", "termo@mail")
            add_user(cur, "Gogi", "Tolik", "1234@mail", '89444444444')
            add_number(cur, 89111111111, 1)
            add_number(cur, 89000000000, 1)
            add_number(cur, 89222222222, 2)
            add_number(cur, 89333333333, 2)
            change_user_info(cur, 1)
            del_number(cur, '89000000000', 1)
            del_user(cur, 2)
            print(user_info(cur, email='1234@mail'))
    conn.close()
