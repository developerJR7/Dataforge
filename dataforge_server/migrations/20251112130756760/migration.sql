BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "user" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "user" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "email" text NOT NULL,
    "username" text NOT NULL,
    "passwordHash" text NOT NULL,
    "createdAt" timestamp without time zone
);


--
-- MIGRATION VERSION FOR dataforge
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('dataforge', '20251112130756760', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251112130756760', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();


COMMIT;
