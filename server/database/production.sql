drop database if exists annotations;
create database annotations;
use annotations;

create table app_user (
	app_user_id int primary key auto_increment,
    username varchar(32) not null unique,
    password_hash varchar(2048) not null,
    enabled bit not null default(1)
);

create table book (
	book_id int primary key auto_increment,
    title varchar(200) not null unique,
    author varchar(200) not null,
    `description` varchar(2000) not null
);

create table app_user_book (
	app_user_id int not null,
    book_id int not null,
    constraint pk_app_user_book
		primary key (app_user_id, book_id),
	constraint fk_app_user_book_app_user_id
		foreign key (app_user_id)
        references app_user(app_user_id),
	constraint fk_app_user_book_book_id
		foreign key (book_id)
        references book(book_id)
);

create table annotation (
	annotation_id int primary key auto_increment,
    app_user_id int not null,
    constraint fk_annotation_app_user
		foreign key (app_user_id)
        references app_user(app_user_id),
	book_id int not null,
    constraint fk_annotation_book
		foreign key (book_id)
        references book(book_id),
	`date` date not null,
    `quote` text not null, index(`quote`(10)),
    annotation text not null, index(annotation(10))
);

-- TEST DATA

insert into app_user(username, password_hash, enabled)
	values
    ("veronica@test.com", "$2a$10$ntB7CsRKQzuLoKY3rfoAQen5nNyiC/U60wBsWnnYrtQQi8Z3IZzQa", 1);
    
insert into book(title, author, `description`)
	values
    ("The Brothers Karamazov", "Fyodor Dostoevsky", "Test description.");
    
insert into app_user_book(app_user_id, book_id)
	values
    (1, 1);

insert into annotation(app_user_id, book_id, `date`, `quote`, annotation)
	values
    (1, 1, "2023-06-26", "Test quote.", "Test annotation.");