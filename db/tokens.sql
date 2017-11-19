
CREATE TABLE public.tokens
(
   	id character varying(255) NOT NULL,
    table_id character varying(255) COLLATE pg_catalog."default",
    permission character varying(2) COLLATE pg_catalog."default",
    CONSTRAINT tokens_pkey PRIMARY KEY (id),
    /* 
     * Avoids to have duplicated records with some table_id and permission
     * It could be used as natural key of this table
     */
    UNIQUE (table_id, permission),
    
    /*
     * Restricts permission values to be only 'R' or 'RW' 
     */
    CONSTRAINT check_types CHECK (permission = 'R' OR permission = 'RW')
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.tokens OWNER to backend;

/***************************************************
 * Inserting some data to populate tokens table
 ***************************************************/
insert into tokens(id, table_id, permission) values (md5(random()::text), 'users', 'R');
insert into tokens(id, table_id, permission) values (md5(random()::text), 'users', 'RW');
insert into tokens(id, table_id, permission) values (md5(random()::text), 'groups', 'R');
insert into tokens(id, table_id, permission) values (md5(random()::text), 'groups', 'RW');
insert into tokens(id, table_id, permission) values (md5(random()::text), 'groups_users', 'R');
insert into tokens(id, table_id, permission) values (md5(random()::text), 'groups_users', 'RW');
insert into tokens(id, table_id, permission) values (md5(random()::text), 'maps', 'R');
insert into tokens(id, table_id, permission) values (md5(random()::text), 'maps', 'RW');

commit;