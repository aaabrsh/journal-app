-- CreateEnum
CREATE TYPE "ItemType" AS ENUM ('JOURNAL', 'ENTRY');

-- CreateEnum
CREATE TYPE "Repeat" AS ENUM ('DAILY', 'WEEKLY', 'MONTHLY');

-- CreateEnum
CREATE TYPE "ReminderType" AS ENUM ('NOTIFICATION', 'EMAIL', 'BOTH');

-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL,
    "full_name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Journal" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "is_deleted" BOOLEAN NOT NULL DEFAULT false,
    "deleted_on" TIMESTAMP(3),
    "autosave" BOOLEAN NOT NULL DEFAULT true,
    "has_lock" BOOLEAN NOT NULL DEFAULT false,
    "password" TEXT,
    "has_reminder" BOOLEAN NOT NULL DEFAULT false,
    "has_tags" BOOLEAN NOT NULL DEFAULT false,
    "owner_id" TEXT NOT NULL,

    CONSTRAINT "Journal_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Entry" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "body" TEXT,
    "has_attachment" BOOLEAN NOT NULL DEFAULT false,
    "has_tags" BOOLEAN NOT NULL DEFAULT false,
    "journal_id" TEXT NOT NULL,

    CONSTRAINT "Entry_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "File" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "file_type" TEXT NOT NULL,
    "blob" BYTEA NOT NULL,
    "entry_id" TEXT NOT NULL,

    CONSTRAINT "File_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Reminder" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "body" TEXT NOT NULL,
    "repeat" "Repeat" NOT NULL,
    "dateTime" TIMESTAMP(3) NOT NULL,
    "end_date" TIMESTAMP(3),
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "reminder_type" "ReminderType" NOT NULL,
    "journal_id" TEXT NOT NULL,

    CONSTRAINT "Reminder_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Tag" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "Tag_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "EntryTag" (
    "id" TEXT NOT NULL,
    "tag_id" TEXT NOT NULL,
    "entry_id" TEXT NOT NULL,

    CONSTRAINT "EntryTag_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "JournalTag" (
    "id" TEXT NOT NULL,
    "tag_id" TEXT NOT NULL,
    "journal_id" TEXT NOT NULL,

    CONSTRAINT "JournalTag_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- AddForeignKey
ALTER TABLE "Journal" ADD CONSTRAINT "Journal_owner_id_fkey" FOREIGN KEY ("owner_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Entry" ADD CONSTRAINT "Entry_journal_id_fkey" FOREIGN KEY ("journal_id") REFERENCES "Journal"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "File" ADD CONSTRAINT "File_entry_id_fkey" FOREIGN KEY ("entry_id") REFERENCES "Entry"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Reminder" ADD CONSTRAINT "Reminder_journal_id_fkey" FOREIGN KEY ("journal_id") REFERENCES "Journal"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "EntryTag" ADD CONSTRAINT "EntryTag_tag_id_fkey" FOREIGN KEY ("tag_id") REFERENCES "Tag"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "EntryTag" ADD CONSTRAINT "EntryTag_entry_id_fkey" FOREIGN KEY ("entry_id") REFERENCES "Entry"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "JournalTag" ADD CONSTRAINT "JournalTag_tag_id_fkey" FOREIGN KEY ("tag_id") REFERENCES "Tag"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "JournalTag" ADD CONSTRAINT "JournalTag_journal_id_fkey" FOREIGN KEY ("journal_id") REFERENCES "Journal"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
