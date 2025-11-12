BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "task" (
    "id" bigserial PRIMARY KEY,
    "title" text NOT NULL,
    "description" text,
    "userId" bigint NOT NULL,
    "createdAt" timestamp without time zone
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "user" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "email" text NOT NULL,
    "createdAt" timestamp without time zone
);


--
-- MIGRATION VERSION FOR dataforge
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('dataforge', '20251111032801349', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251111032801349', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();


COMMIT;
