CREATE TABLE IF NOT EXISTS users (
    id BIGINT(9) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT COMMENT 'システムで自動採番されるユーザーID',
    email VARCHAR(128) NOT NULL COMMENT 'Ｅメールアドレス',
    avf DATE NOT NULL COMMENT '世代管理用の日付',
    name VARCHAR(128) DEFAULT NULL COMMENT 'ユーザー情報に表示されるユーザー名を保持する。',
    password CHAR(60) DEFAULT NULL,
    locked TINYINT(1) UNSIGNED DEFAULT '0' COMMENT 'アカウントがロックされていることを示すフラグ',
    expired TINYINT(1) UNSIGNED DEFAULT '0' COMMENT 'アカウントが期限切れになったことを示すフラグ',
    emp_no CHAR(8) DEFAULT NULL,
    dept_cd CHAR(7) DEFAULT NULL,
    pos_cd CHAR(4) DEFAULT NULL,
    profile_img LONGTEXT DEFAULT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY email (email,avf)
) ENGINE=InnoDB AUTO_INCREMENT=119 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

CREATE TABLE IF NOT EXISTS user_roles (
    user_id BIGINT(9) UNSIGNED ZEROFILL NOT NULL COMMENT 'ユーザーマスタのユーザーIDを参照',
    role CHAR(2) NOT NULL,
    delflg CHAR(1) DEFAULT NULL COMMENT 'ユーザーが無効化された場合に設定される削除フラグ',
    PRIMARY KEY (user_id,role)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

CREATE TABLE IF NOT EXISTS personal_info (
    user_id BIGINT(9) UNSIGNED ZEROFILL NOT NULL,
    last_name VARCHAR(32) DEFAULT NULL,
    first_name VARCHAR(32) DEFAULT NULL,
    zipcode CHAR(7) DEFAULT NULL,
    pref VARCHAR(16) DEFAULT NULL,
    city VARCHAR(128) DEFAULT NULL,
    bldg VARCHAR(128) DEFAULT NULL,
    telno VARCHAR(32) DEFAULT NULL,
    mobile_no VARCHAR(32) DEFAULT NULL,
    PRIMARY KEY (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS codemst (
    code_id BIGINT(8) UNSIGNED ZEROFILL NOT NULL COMMENT 'コード体系を一意にしきべつするためのID',
    code VARCHAR(8) NOT NULL,
    code_nm VARCHAR(256) DEFAULT NULL,
    delflg CHAR(1) DEFAULT NULL COMMENT 'ユーザーが無効化された場合に設定される削除フラグ',
    PRIMARY KEY (code_id,code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS depts (
    dept_cd CHAR(7) NOT NULL,
    avf DATE NOT NULL,
    dept_nm VARCHAR(64) DEFAULT NULL,
    PRIMARY KEY (dept_cd,avf)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS positions (
    pos_cd CHAR(4) NOT NULL,
    avf DATE NOT NULL,
    pos_nm VARCHAR(64) DEFAULT NULL,
    PRIMARY KEY (pos_cd,avf)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

CREATE TABLE IF NOT EXISTS numbering_ledger (
    numbering_cd VARCHAR(3) NOT NULL,
    avail_year VARCHAR(4) NOT NULL,
    nextno decimal(9,0) DEFAULT NULL,
    digits decimal(9,0) DEFAULT NULL,
    updusr BIGINT(9) UNSIGNED ZEROFILL DEFAULT NULL,
    upddate DATE DEFAULT NULL,
    PRIMARY KEY (numbering_cd,avail_year)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS topics (
    topicno VARCHAR(12) NOT NULL,
    subject VARCHAR(128) DEFAULT NULL,
    createdby VARCHAR(8) DEFAULT NULL,
    createdat DATE DEFAULT NULL,
    PRIMARY KEY (topicno)
) ENGINE=InnoDB AUTO_INCREMENT=158 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

CREATE TABLE IF NOT EXISTS posts (
    topicno VARCHAR(12) NOT NULL,
    postno BIGINT(8) UNSIGNED ZEROFILL,
    post VARCHAR(1280) DEFAULT NULL,
    createdby VARCHAR(8) DEFAULT NULL,
    createdat DATE DEFAULT NULL,
    PRIMARY KEY (topicno, postno)
) ENGINE=InnoDB AUTO_INCREMENT=158 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

CREATE TABLE IF NOT EXISTS post_ratings (
    topicno VARCHAR(12) NOT NULL,
    postno BIGINT(8) UNSIGNED ZEROFILL NOT NULL,
    ratedby VARCHAR(8) NOT NULL,
    rating_flg TINYINT DEFAULT NULL,
    ratedat DATE DEFAULT NULL,
    PRIMARY KEY(topicno, postno, ratedby)
) ENGINE=InnoDB AUTO_INCREMENT=158 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
