drop table REVIEW;
drop table STREAMING;
drop table PAY;
drop table SETTING;
drop table MEMMGR;
drop table MYPAGE;
drop table NOTICE;
drop table QNABD;
drop table MANAGE;
drop table EVENT;
drop table MEMBER;
drop table VID;
drop table GENRE;
drop table SUBJECT;
drop sequence VID_SEQ;
drop sequence QNABD_SEQ;
purge recyclebin;

select TNAME from TAB;
select SEQUENCE_NAME from SEQ;