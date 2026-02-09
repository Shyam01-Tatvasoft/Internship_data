CREATE TABLE role(
	id serial primary key,
	name varchar(50) not null unique,
	createddate timestamp default now(),
	createdBy varchar(50),
	updateddate timestamp default now(),
	updatedBy varchar(50)
);

CREATE TABLE account(
	id serial primary key,
	email varchar(50) not null unique,
	password varchar(255) not null,
	roleid integer references role(id),
	isDeleted boolean default false,
	isfirstlogin boolean,
	createddate timestamp default now(),
	createdBy varchar(50),
	updateddate timestamp default now(),
	updatedBy varchar(50)
);

CREATE TABLE category(
	id serial primary key,
	name varchar(50) not null unique,
	description text not null,
	isDeleted boolean default false,
	createddate timestamp default now(),
	createdBy varchar(50),
	updateddate timestamp default now(),
	updatedBy varchar(50)
);

CREATE TABLE permission(
	id serial primary key,
	name varchar(50) not null unique,
	createddate timestamp default now(),
	createdBy varchar(50),
	updateddate timestamp default now(),
	updatedBy varchar(50)
);

CREATE TABLE rolepermission(
	id serial primary key,
	roleid integer references role(id),
	permissionid integer references permission(id),
	canview boolean default true,
	canaddedit boolean default false,
	candelete boolean default false,
	createddate timestamp default now(),
	createdBy varchar(50),
	updateddate timestamp default now(),
	updatedBy varchar(50)
);

CREATE TABLE country(
	id serial primary key,
	name varchar(50) not null,
	createddate timestamp default now(),
	createdBy varchar(50),
	updateddate timestamp default now(),
	updatedBy varchar(50)
);

CREATE TABLE state(
	id serial primary key,
	name varchar(50) not null,
	countryid integer references country(id) on delete cascade,
	createddate timestamp default now(),
	createdBy varchar(50),
	updateddate timestamp default now(),
	updatedBy varchar(50)
);

CREATE TABLE city(
	id serial primary key,
	name varchar(50) not null,
	stateid integer references state(id) on delete cascade,
	createddate timestamp default now(),
	createdBy varchar(50),
	updateddate timestamp default now(),
	updatedBy varchar(50)
);

CREATE TABLE customer(
	id serial primary key,
	name varchar(50) not null,
	email varchar(50) not null unique,
	phone varchar(20) not null,
	date timestamp not null,
	createddate timestamp default now(),
	createdBy varchar(50),
	updateddate timestamp default now(),
	updatedBy varchar(50)
);

CREATE TABLE modifiergroup(
	id serial primary key,
	name varchar(50) not null,
	description varchar(255) not null,
	isDeleted boolean default false,
	createddate timestamp default now(),
	createdBy varchar(50),
	updateddate timestamp default now(),
	updatedBy varchar(50)
);

CREATE TABLE unit(
	id serial primary key,
	shortName varchar(10),
	name varchar(20) not null,
	isDeleted boolean default false,
	createddate timestamp default now(),
	createdBy varchar(50),
	updateddate timestamp default now(),
	updatedBy varchar(50)
);

CREATE TABLE modifier(
	id serial primary key,
	name varchar(50) not null,
	rate decimal(10,2) not null,
	quantity smallint not null,
	isDeleted boolean default false,
	description text not null,
	modifiergroupid integer references modifiergroup(id),
	unitid integer references unit(id),
	createddate timestamp default now(),
	createdBy varchar(50),
	updateddate timestamp default now(),
	updatedBy varchar(50)
);

CREATE TABLE "order"(
	id serial primary key,
	customerid integer references  customer(id),
	subtotalamount decimal(18,2) not null,
	totalamount decimal(18,2) not null,
	tax decimal(10,2),
	discount decimal(10,2),
	notes text,
	status varchar(20) not null,
	isGSTSelected boolean,
	isDeleted boolean default false,
	createddate timestamp default now(),
	createdBy varchar(50),
	updateddate timestamp default now(),
	updatedBy varchar(50)
);

CREATE TABLE invoice(
	id serial primary key,
	orderid integer references "order"(id),
	modifierid integer references modifier(id),
	quantityOfModifier smallint not null,
	rateOfModifier decimal(10,2) not null,
	totalamount decimal(18,2) not null,
	createddate timestamp default now(),
	createdBy varchar(50),
	updateddate timestamp default now(),
	updatedBy varchar(50)
);


CREATE TABLE payment(
	id serial primary key,
	method varchar(10) not null,
	amount decimal(18,2) not null,
	status varchar(20) not null,
	invoiceId integer references invoice(id),
	createddate timestamp default now(),
	createdBy varchar(50),
	updateddate timestamp default now(),
	updatedBy varchar(50)
);

ALTER TABLE "order" ADD COLUMN paymentid integer references payment(id);



CREATE TABLE feedback(
	id serial primary key,
	orderid integer references "order"(id),
	avgRating decimal(1,1),
	comment varchar(100),
	food smallint,
	service smallint,
	ambience smallint,
	createddate timestamp default now(),
	createdBy varchar(50),
	updateddate timestamp default now(),
	updatedBy varchar(50)
);

CREATE TABLE menuItem(
	id serial primary key,
	categoryid integer references category(id),
	name varchar(20) not null unique,
	itemType varchar(20) not null,
	rate decimal(10,2) not null,
	quantity smallint not null,
	isAvailable boolean default true,
	isDeleted boolean default false,
	comment varchar(100),
	unitid integer references unit(id),
	isDefaultTax boolean,
	isFavourite boolean default false,
	taxPercentage decimal(5,2),
	shortcode varchar(10),
	description text,
	itemImage text,
	createddate timestamp default now(),
	createdBy varchar(50),
	updateddate timestamp default now(),
	updatedBy varchar(50)
);

CREATE TABLE mappingmenuItemwithmodifier(
	id serial primary key,
	menuitemid integer references menuItem(id),
	modifiergroupid integer references modifiergroup(id),
	minSelectionrequired smallint,
	maxselectionrequired smallint,
	createddate timestamp default now(),
	createdBy varchar(50),
	updateddate timestamp default now(),
	updatedBy varchar(50)
);

CREATE TABLE orderitem(
	id serial primary key,
	menuitemid integer references menuitem(id),
	orderid integer references "order"(id),
	status varchar(20) not null,
	comment varchar(100),
	name varchar(20) not null unique,
	quantity smallint not null,
	rate decimal(10,2) not null,
	amount decimal(18,2) not null,
	totalmodifieramount decimal(18,2) not null,
	tax decimal(10,2),
	totalAmount decimal(18,2) not null,
	instruction text,
	readyItemQuantity smallint,
	isDeleted boolean default false,
	createddate timestamp default now(),
	createdBy varchar(50),
	updateddate timestamp default now(),
	updatedBy varchar(50)
);

CREATE TABLE orderitemmodifiermapping(
	id serial primary key,
	orderItemid integer references orderitem(id),
	modifierid integer references modifier(id),
	quantityOfModifier smallint,
	rateOfModifier decimal(10,2),
	totalAmount decimal(18,2),
	isDeleted boolean default false,
	createddate timestamp default now(),
	createdBy varchar(50),
	updateddate timestamp default now(),
	updatedBy varchar(50)
);

CREATE TABLE taxesandfees(
	id serial primary key,
	name varchar(20) not null unique,
	Percentge decimal(5,2) not null,
	flatAmount decimal(10,2),
	isActive boolean default true,
	isDefault boolean,
	isDeleted boolean default false,
	createddate timestamp default now(),
	createdBy varchar(50),
	updateddate timestamp default now(),
	updatedBy varchar(50)
);

CREATE TABLE orderTaxmapping(
	id serial primary key,
	orderid integer references "order"(id),
	taxid integer references taxesandfees(id),
	taxvalue decimal(10,2),
	isDeleted boolean default false,
	createddate timestamp default now(),
	createdBy varchar(50),
	updateddate timestamp default now(),
	updatedBy varchar(50)
);

CREATE TABLE section(
	id serial primary key,
	name varchar(50) not null unique,
	isDeleted boolean default false,
	description text,
	createddate timestamp default now(),
	createdBy varchar(50),
	updateddate timestamp default now(),
	updatedBy varchar(50)
);

CREATE TABLE tables(
	id serial primary key,
	sectionId integer references section(id),
	name varchar(10) not null,
	capacity smallint not null,
	status varchar(20) not null,
	isAvailable boolean default true,
	isDeleted boolean default false,
	createddate timestamp default now(),
	createdBy varchar(50),
	updateddate timestamp default now(),
	updatedBy varchar(50)
);

CREATE TABLE tableordermapping(
	id serial primary key,
	orderid integer references "order"(id),
	tableid integer references tables(id),
	noofpersons smallint not null,
	isDeleted boolean default false,
	createddate timestamp default now(),
	createdBy varchar(50),
	updateddate timestamp default now(),
	updatedBy varchar(50)
);

CREATE TABLE users(
	id serial primary key,
	email varchar(50) not null unique,
	profileImage text,
	firstname varchar(50) not null,
	lastname varchar(50),
	username varchar(50) not null unique,
	phone varchar(20) not null,
	country varchar(20) not null,
	state varchar(20) not null,
	city varchar(20) not null,
	zipcode varchar(6),
	address text not null,
	roleid integer references role(id),
	isDeleted boolean default false,
	isActive boolean default true,
	createddate timestamp default now(),
	createdBy varchar(50),
	updateddate timestamp default now(),
	updatedBy varchar(50)
);

CREATE TABLE waitingToken(
	id serial primary key,
	customerid integer references customer(id),
	isDeleted boolean default false,
	isAssigned boolean default false,
	tableid integer references tables(id),
	sectionid integer references section(id),
	noofpersons smallint not null,
	createddate timestamp default now(),
	createdBy varchar(50),
	updateddate timestamp default now(),
	updatedBy varchar(50)
);