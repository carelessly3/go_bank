
ALTER TABLE "account" RENAME TO "accounts";

CREATE TABLE "users" (
  "username" varchar PRIMARY KEY,
  "hashed_password" varchar NOT NULL,
  "email" varchar UNIQUE NOT NULL,
  "full_name" varchar NOT NULL,
  "created_at" timestamptz NOT NULL DEFAULT 'now()',
  "password_changed_at" timestamptz NOT NULL DEFAULT 'now()'
);


ALTER TABLE "accounts" ADD CONSTRAINT "owner_currency_key" UNIQUE ("owner", "currency");
--ADDING UNIQUE CONSTRAINT IS BETTER AS IT CREATES AN INDEX FOR POSTGRES TO APPLY THIS UNIQUE CONSTRAINT FASTER

ALTER TABLE "accounts" ADD FOREIGN KEY ("owner") REFERENCES "users" ("username");

