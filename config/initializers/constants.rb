# never change these unless your database is blank, because existing values will be set to one of them
SEX_MALE = 0
SEX_FEMALE = 1
SEX_MIXED = 2

VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
VALID_SEX_REGEX_PLAYER   = /\A[#{SEX_MALE}#{SEX_FEMALE}]\z/i
VALID_SEX_REGEX_DIVISION = /\A[#{SEX_MALE}#{SEX_FEMALE}#{SEX_MIXED}]\z/i

