CREATE TABLE IF NOT EXISTS users (
	user_id INT AUTO_INCREMENT,
	user_name TEXT NOT NULL,
	user_pass TEXT NOT NULL,
	user_realname TEXT NOT NULL,
	display_realname BOOLEAN,
	user_level INT NOT NULL,

	PRIMARY KEY (user_id)
);

CREATE TABLE IF NOT EXISTS competition (
	comp_id INT AUTO_INCREMENT,
	comp_title TEXT,
	comp_theme TEXT,
	comp_sub_due DATETIME NOT NULL,
	comp_vote_due DATETIME NOT NULL,
	comp_sub_limit INT NOT NULL,

	PRIMARY KEY (comp_id)
);

CREATE TABLE IF NOT EXISTS photos (
	photo_id INT AUTO_INCREMENT,
	time_uploaded DATETIME NOT NULL,
	photo_guid TEXT NOT NULL,
        photo_user INT NOT NULL,
	photo_title TEXT,
	photo_filename TEXT,

	PRIMARY KEY (photo_id),

	INDEX (photo_user),

	FOREIGN KEY (photo_user)
		REFERENCES users(user_id)
		ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS comp_photos (
	comp_photo_id INT AUTO_INCREMENT,
	photo_id INT NOT NULL,
	photo_comp INT NOT NULL,
	weighted_votes INT NOT NULL,
	normal_votes INT NOT NULL,

	PRIMARY KEY (comp_photo_id),

	INDEX (photo_id, photo_comp),

	FOREIGN KEY (photo_id)
		REFERENCES photos(photo_id)
		ON DELETE CASCADE,
	FOREIGN KEY (photo_comp)
		REFERENCES competition(comp_id)
		ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS exif_data (
	exif_id INT AUTO_INCREMENT,
	photo_id INT NOT NULL,
	camera_make TEXT,
	camera_model TEXT,
	date_taken DATETIME,
	img_width INT,
	img_height INT,
	f_number CHAR(10),
	shutter_speed CHAR(10),
	iso CHAR(10),

	PRIMARY KEY (exif_id),

	INDEX (photo_id),

	FOREIGN KEY (photo_id)
		REFERENCES photos(photo_id)
		ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS user_profile (
	profile_id INT AUTO_INCREMENT,
	user_id INT NOT NULL,
	profile_bio LONGTEXT,
	profile_sites TEXT,
	profile_phone TEXT,
	profile_email TEXT,
	profile_picture INT NOT NULL,
	
	
	PRIMARY KEY (profile_id),

	INDEX (user_id, profile_picture),

	FOREIGN KEY (user_id)
		REFERENCES users(user_id)
		ON DELETE CASCADE,

	FOREIGN KEY (profile_picture)
		REFERENCES photos(photo_id)
		ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS user_favourites (
	fave_id INT AUTO_INCREMENT,
	user_id INT NOT NULL,
	photo_id INT NOT NULL,

	PRIMARY KEY (fave_id),

	INDEX (user_id, photo_id),

	FOREIGN KEY (user_id)
		REFERENCES users(user_id)
		ON DELETE CASCADE,

	FOREIGN KEY (photo_id)
		REFERENCES comp_photos(photo_id)
		ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS galleries (
	gallery_id INT AUTO_INCREMENT,
	user_id INT NOT NULL,
        top_1 INT,
	top_2 INT,
	top_3 INT,
	top_4 INT,
	top_5 INT,

	PRIMARY KEY (gallery_id),

	INDEX(user_id),

	FOREIGN KEY(user_id)
		REFERENCES users(user_id)
		ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS albums (
	album_id INT AUTO_INCREMENT,
	gallery_id INT NOT NULL,
	album_title TEXT NOT NULL,

	PRIMARY KEY (album_id),

	INDEX (gallery_id),

	FOREIGN KEY (gallery_id)
		REFERENCES galleries(gallery_id)
		ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS image_album_link (
	link_id INT AUTO_INCREMENT,
	album_id INT NOT NULL,
	image_id INT NOT NULL,

	PRIMARY KEY (link_id),

	INDEX (album_id, image_id),

	FOREIGN KEY(album_id)
		REFERENCES albums(album_id)
		ON DELETE CASCADE,

	FOREIGN KEY(image_id)
		REFERENCES photos(photo_id)
		ON DELETE CASCADE
);

