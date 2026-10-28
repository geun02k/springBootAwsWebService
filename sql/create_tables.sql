-- 테스트 코드 수행 시 출력되는 로그로 생성되는 쿼리 복사

-- 게시글 테이블 생성
create table posts (
    id bigint not null auto_increment,
    created_date datetime,
    modified_date datetime,
    author varchar(255),
    content TEXT not null,
    title varchar(500) not null,
    primary key (id)
);

-- 사용자 테이블 생성
create table `user` (
    id bigint not null auto_increment,
    created_date datetime,
    modified_date datetime,
    email varchar(255) not null,
    name varchar(255) not null,
    picture varchar(255),
    role varchar(255) not null,
    primary key (id)
);
