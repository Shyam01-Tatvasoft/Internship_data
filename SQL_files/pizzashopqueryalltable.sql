CREATE TABLE role(
	id serial PRIMARY KEY,
	role_name varchar(20) NOT NULL UNIQUE,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP,
	created_by varchar(50),
	updated_by varchar(50)
);

CREATE TABLE "user"(
	id serial PRIMARY KEY,
	first_name varchar(50) NOT NULL,
	last_name varchar(50),
	phone varchar(20) NOT NULL UNIQUE,
	email varchar(200) NOT NULL UNIQUE,
	username varchar(50) NOT NULL UNIQUE,
	country varchar(50) NOT NULL,
	state varchar(50) NOT NULL,
	city varchar(50) NOT NULL,
	address varchar(200) NOT NULL,
	zipcode integer NOT NULL,
	role_id integer NOT NULL REFERENCES role(id), 
	is_active boolean DEFAULT TRUE,
	profile_image text,
	is_deleted boolean DEFAULT FALSE,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP,
	created_by varchar(50),
	updated_by varchar(50)
);

CREATE TABLE account(
	id serial PRIMARY KEY,
	password varchar(50) NOT NULL,
	email varchar(200) NOT NULL UNIQUE,
	role_id integer NOT NULL REFERENCES role(id),
	user_id integer NOT NULL REFERENCES "user"(id),
	created_at timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP,
	created_by varchar(20),
	updated_by varchar(20)
);

CREATE TABLE permission(
	id serial PRIMARY KEY,
	permission_name varchar(50) NOT NULL UNIQUE,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP,
	created_by varchar(20),
	updated_by varchar(20)
);

CREATE TABLE role_permission_mapping(
	id serial PRIMARY KEY,
	role_id integer NOT NULL REFERENCES role(id),
	permission_id integer NOT NULL REFERENCES permission(id),
	can_view boolean DEFAULT TRUE,
	can_edit boolean DEFAULT FALSE,
	can_delete boolean DEFAULT FALSE,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP,
	created_by varchar(20),
	updated_by varchar(20)
);

CREATE TABLE unit(
	id serial PRIMARY KEY,
	unit_name varchar(20) NOT NULL UNIQUE,
	short_name varchar(10) UNIQUE,
	is_deleted boolean DEFAULT FALSE,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP,
	created_by varchar(20),
	updated_by varchar(20)
);

CREATE TABLE item_category(
	id serial PRIMARY KEY,
	category_name varchar(20) NOT NULL UNIQUE,
	category_description text,
	is_deleted boolean DEFAULT FALSE,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP,
	created_by varchar(20),
	updated_by varchar(20)
);

CREATE TABLE menu_item(
	id serial PRIMARY KEY,
	item_name varchar(50) NOT NULL UNIQUE,
	item_description text,
	category_id integer NOT NULL REFERENCES item_category(id),
	item_type varchar(20) NOT NULL,
	rate numeric(10,2) NOT NULL,
	quantity int NOT NULL,
	unit_id integer NOT NULL REFERENCES unit(id),
	is_available boolean DEFAULT TRUE,
	is_default_tax boolean NOT NULL,
	tax_percentage numeric(4,2),
	short_code varchar(10),
	is_favourite boolean DEFAULT FALSE,
	item_image text,
	is_deleted boolean DEFAULT FALSE,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP,
	created_by varchar(20),
	updated_by varchar(20)
);

;
CREATE TABLE modifier_group(
	id serial PRIMARY KEY,
	group_name varchar(50) NOT NULL UNIQUE,
	group_description text,
	is_deleted boolean DEFAULT FALSE,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP,
	created_by varchar(20),
	updated_by varchar(20)
);

CREATE TABLE item_modifiergroup_mapping(
	id serial PRIMARY KEY,
	item_id integer REFERENCES menu_item(id),
	modifiergroup_id integer REFERENCES modifier_group(id),
	min_selection integer DEFAULT 0,
	max_selection integer DEFAULT 0,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP,
	created_by varchar(20),
	updated_by varchar(20)
);

CREATE TABLE modifier(
	id serial PRIMARY KEY,
	modifier_name varchar(50) NOT NULL UNIQUE,
	modifier_description text,
	rate numeric(10,2) NOT NULL,
	quantity int NOT NULL,
	unit_id integer NOT NULL REFERENCES unit(id),
	modifiergroup_id integer REFERENCES modifier_group(id),
	is_deleted boolean DEFAULT FALSE,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP,
	created_by varchar(20),
	updated_by varchar(20)
);

CREATE TABLE section(
	id serial PRIMARY KEY,
	section_name varchar(50) NOT NULL UNIQUE,
	section_description text,
	is_deleted boolean DEFAULT FALSE,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP,
	created_by varchar(20),
	updated_by varchar(20)
);

CREATE TABLE "table"(
	id serial PRIMARY KEY,
	table_name varchar(10) NOT NULL,
	section_id integer NOT NULL REFERENCES section(id),
	is_available boolean DEFAULT TRUE,
	status varchar(20),
	capacity integer,
	is_deleted boolean DEFAULT FALSE,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP,
	created_by varchar(20),
	updated_by varchar(20)
);

CREATE TABLE taxes_and_fees(
	id serial PRIMARY KEY,
	tax_name varchar(20) NOT NULL UNIQUE,
	tax_percentage numeric(4,2) NOT NULL,
	flat_amount numeric(18,2),
	is_enabled boolean DEFAULT TRUE,
	is_default_tax boolean,
	is_deleted boolean DEFAULT FALSE,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP,
	created_by varchar(20),
	updated_by varchar(20)
);

CREATE TABLE customer(
	id serial PRIMARY KEY,
	customer_name varchar(50) NOT NULL,
	customer_email varchar(300) NOT NULL UNIQUE,
	customer_phone varchar(20) NOT NULL,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP,
	created_by varchar(20),
	updated_by varchar(20)
);

CREATE TABLE "order"(
	id serial PRIMARY KEY,
	sub_total_amount numeric(18,2) NOT NULL,
	total_amount numeric(18,2) NOT NULL,
	comment varchar(200),
	status varchar(20) NOT NULL,
	customer_id integer REFERENCES customer(id),
	no_of_person integer DEFAULT 1,
	discount numeric(10,2),
	tax numeric(10,2),
	is_GSTselected boolean NOT NULL,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP,
	created_by varchar(20),
	updated_by varchar(20)
);


CREATE TABLE invoice(
	id serial PRIMARY KEY,
	order_id integer REFERENCES "order"(id),
	total_amount numeric(18,2),
	modifier_id integer REFERENCES modifier(id),
	quantity_of_modifier int,
	rate_of_modifier numeric(10,2),
	created_at timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP,
	created_by varchar(20),
	updated_by varchar(20)
);

CREATE TABLE payment(
 	id serial PRIMARY KEY,
	method varchar(20) NOT NULL,
	amount numeric(18,2) NOT NULL,
	status varchar(20) NOT NULL,
	invoice_id integer REFERENCES invoice(id),
	created_at timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP,
	created_by varchar(20),
	updated_by varchar(20)
);

ALTER TABLE "order" ADD COLUMN payment_id integer REFERENCES payment(id);

CREATE TABLE order_item_mapping(
	id serial PRIMARY KEY,
	order_id integer REFERENCES "order"(id),
	item_id integer REFERENCES menu_item(id),
	quantity int NOT NULL,
	instruction varchar(200),
	status varchar(20) NOT NULL,
	item_name varchar(50),
	item_rate numeric(10,2),
	amount numeric(10,2),
	total_modifier_amount numeric(10,2),
	total_amount numeric(10,2),
	tax numeric(10,2),
	is_deleted boolean DEFAULT FALSE,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP,
	created_by varchar(20),
	updated_by varchar(20)
);

CREATE TABLE order_item_modifier_mapping(
	id serial PRIMARY KEY,
	order_item_mapping_id integer REFERENCES order_item_mapping(id),
	modifier_id integer REFERENCES modifier(id),
	quantity integer NOT NULL,
	modifier_rate numeric(10,2),
	total_amount numeric(10,2),
	is_deleted boolean DEFAULT FALSE,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP,
	created_by varchar(20),
	updated_by varchar(20)
);

CREATE TABLE table_order_mapping(
	id serial PRIMARY KEY,
	order_id integer REFERENCES "order"(id),
	table_id integer REFERENCES "table"(id),
	no_of_person integer DEFAULT 1,
	is_deleted boolean DEFAULT FALSE,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP,
	created_by varchar(20),
	updated_by varchar(20)
);

CREATE TABLE feedback(
	id serial PRIMARY KEY,
	food integer,
	serivce integer,
	ambience integer,
	comment varchar(200),
	order_id integer REFERENCES "order"(id),
	avg_rating numeric(1,1),
	created_at timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP,
	created_by varchar(20),
	updated_by varchar(20)
);

CREATE TABLE waiting_token(
	id serial PRIMARY KEY,
	section_id integer REFERENCES section(id),
	is_assigned boolean DEFAULT FALSE,
	customer_id integer REFERENCES customer(id),
	no_of_person integer DEFAULT 1,
	table_id integer REFERENCES "table"(id),
	is_deleted boolean DEFAULT FALSE,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP,
	created_by varchar(20),
	updated_by varchar(20)
);

CREATE TABLE order_tax_mapping(
	id serial PRIMARY KEY,
	order_id integer REFERENCES "order"(id),
	tax_id integer REFERENCES taxes_and_fees(id),
	tax_value numeric(10,2),
	is_deleted boolean DEFAULT FALSE,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP,
	created_by varchar(20),
	updated_by varchar(20)
);

CREATE TABLE country(
	id serial PRIMARY KEY,
	country_name varchar(50) NOT NULL,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP,
	created_by varchar(20),
	updated_by varchar(20)
);

CREATE TABLE state(
	id serial PRIMARY KEY,
	state_name varchar(50) NOT NULL,
	country_id integer REFERENCES country(id) ON DELETE CASCADE,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP,
	created_by varchar(20),
	updated_by varchar(20)
);


CREATE TABLE city(
	id serial PRIMARY KEY,
	city_name varchar(50) NOT NULL,
	state_id integer REFERENCES country(id) ON DELETE CASCADE,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP,
	created_by varchar(20),
	updated_by varchar(20)
);

