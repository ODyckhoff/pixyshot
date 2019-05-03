CREATE TABLE IF NOT EXISTS users (
	user_id INT AUTO_INCREMENT,
	user_name TEXT NOT NULL,
	user_pass TEXT NOT NULL,
	user_realname TEXT NOT NULL,
	display_realname BOOLEAN,

	PRIMARY KEY (user_id)
);

CREATE TABLE IF NOT EXISTS competition (
	comp_id INT AUTO_INCREMENT,
	comp_title TEXT,
	comp_theme TEXT,
	comp_due DATETIME NOT NULL,

	PRIMARY KEY (comp_id)
);

CREATE TABLE IF NOT EXISTS comp_photos (
	photo_id INT AUTO_INCREMENT,
	time_uploaded DATETIME NOT NULL,
	photo_guid TEXT NOT NULL,
        photo_user INT NOT NULL,
	photo_comp INT NOT NULL,
	weighted_votes INT NOT NULL,
	normal_votes INT NOT NULL,

	PRIMARY KEY (photo_id),

	INDEX (photo_comp),
	INDEX (photo_user),

	FOREIGN KEY (photo_user)
		REFERENCES users(user_id)
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
		REFERENCES comp_photos(photo_id)
		ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS user_profile (
	profile_id INT AUTO_INCREMENT,
	user_id INT NOT NULL,
	profile_bio LONGTEXT,
	profile_sites TEXT,
	profile_phone TEXT,
	profile_email TEXT,
	
	
	PRIMARY KEY (profile_id),

	INDEX (user_id),

	FOREIGN KEY (user_id)
		REFERENCES users(user_id)
		ON DELETE CASCADE
);
