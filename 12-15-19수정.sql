--주제
create table SUBJECT(
	J_CODE number(2) constraint SUB_PK primary key,
	J_NAME varchar2(30) constraint SUB_CK
	check(J_NAME in('영화','드라마','다큐','예능'))
)
--장르
create table GENRE(
	G_CODE number(2) constraint GENRE_PK primary key,
	G_NAME varchar2(30)
)
--작품코드 시퀀스
create table VID(
	V_CODE number constraint VID_PK primary key,
	V_NAME varchar2(30),
	DIR_NAME varchar2(15),
	COU_NAME varchar2(20),
	ACTOR_NAME varchar2(15),
	RELEASE_DATE date,
	J_CODE number(2) constraint VID_J_FK references SUBJECT(J_CODE),
	G_CODE number(2) constraint VID_G_FK references GENRE(G_CODE)
)
create sequence VID_SEQ increment by 1 start with 1 nocache;
--리뷰
create table REVIEW(
	V_CODE number constraint REVIEW_PK references VID(V_CODE),
	V_REVIEW varchar2(1000),
	V_GRADE number(2),
	ID varchar2(15) constraint REVIEW_FK references MEMBER(ID)
)
--스트리밍
create table STREAMING(
	V_CODE number references VID(V_CODE),
	ID varchar2(15) references MEMBER(ID),
	V_DATE date,
	V_CONTINUE number(3)
)
alter table STREAMING add constraint STREAMING_PK primary key(V_CODE,ID);

--회원
create TABLE MEMBER(
	ID VARCHAR2(10) constraint MEM_PK primary key,
	PWD VARCHAR2(20),
	EMAIL VARCHAR2(30),
	BIRTH VARCHAR2(26),
	PAYDAY DATE,
	REMPER_CODE VARCHAR2(10)
)
--결제
create table PAY(
	ID varchar2(10) constraint PAY_PK primary key references MEMBER(ID),
	P_INFOM NUMBER(2),
	P_DATE DATE,
	P_END DATE
)
--설정
create table SETTING (
	ID varchar2(15) constraint SETTING_ID_FK references MEMBER(ID),
	QUALITY varchar2(10),
	SUBTITLE varchar2(10),
	DUBBING varchar2(10),
	WIFI varchar2(10),
	ABROAD NUMBER(1)
)
--회원관리
create table MEMMGR (
	ID varchar2(15) constraint MEMMGR_ID_FK references MEMBER(ID),
	SO_LOGIN NUMBER(1),
	CERTIFY NUMBER(1)
)
--마이페이지
create table MYPAGE (
	ID varchar2(15) constraint MYPAGE_ID_FK references MEMBER(ID),
	VID_REQUEST varchar2(20),
	HISTORY varchar2(16),
	DOWNLOAD varchar2(20),
	SERVICE varchar2(30),
	HEART_LIST varchar2(20),
	COMMUNITY varchar2(30)
)
--알림소식
create table NOTICE(
	NEW_NOTICE varchar2(30) constraint NOTICE_PK primary key,
	NEW_RECOM varchar2(30),
	NEW_EVENT varchar2(30)
);
--질문게시판 시퀀스
create table QNABD(
	QNA_IDX number constraint QNA_PK primary key,
	ID varchar2(15) constraint ID_FK references MEMBER(ID),
	QNA_TITLE varchar2(30),
	QNA_POST varchar2(1000),
	QNA_DATE date,
	QNA_COMPLETE number(2)
);
create sequence QNABD_SEQ increment by 1 start with 1 nocache;

--관리자
create table MANAGE(
	MONTH varchar2(10),
	MONTH_SALES number(20)
);

--이벤트 트리거 사용하기 
create table EVENT(
	DCT_CODE varchar2(10),
	DCT_FRND varchar2(10),
	REMPER_CODE varchar2(10),
	ID varchar2(15)
);


----------------------------
insert into SUBJECT values(10,'영화');
insert into SUBJECT values(20,'드라마');
insert into SUBJECT values(30,'다큐');
insert into SUBJECT values(40,'예능');

insert into GENRE values(51,'판타지');
insert into GENRE values(52,'멜로');
insert into GENRE values(53,'코믹');
insert into GENRE values(54,'공포');
insert into GENRE values(55,'스릴러');
insert into GENRE values(56,'액션');
insert into GENRE values(57,'드라마');

insert into STREAMING values((select V_CODE from VID where V_NAME='월-E'),'jinny',sysdate,126);
insert into STREAMING values((select V_CODE from VID where V_NAME='행복을 찾아서'),'candy',sysdate,126);
insert into STREAMING values((select V_CODE from VID where V_NAME='어바웃 타임'),'jun',sysdate,126);

insert into VID values(vid_SEQ.nextval,'어바웃 타임','리차드 커티스','영국','레이첼 맥아담스','2013/12/05',10,52);
insert into VID values(vid_SEQ.nextval,'행복을 찾아서','가브리엘 무치노','미국','윌 스미스','2007/02/28',10,57);
insert into VID values(vid_SEQ.nextval,'그 시절 우리가 좋아했던 소녀','구파도','대만','가진동,션자이','2012/08/22',10,52);
insert into VID values(vid_SEQ.nextval,'월-E','앤드류 스탠튼','미국','월-E','2008/08/06',10,51);

insert into REVIEW values((select V_CODE from VID where V_NAME='어바웃 타임'),'계속 보게됨, 배우가 예쁨',4.6,'JINNY');
insert into REVIEW values((select V_CODE from VID where V_NAME='월-E'),'저렇게 순수할 수 있을까',5,'CANDY');

insert into PAY values('JINNY',1,(select PAYDAY from MEMBER where ID='jinny'),ADD_MONTHS((select PAYDAY from MEMBER where ID='jinny'),1));
insert into PAY values('CANDY',2,(select PAYDAY from MEMBER where ID='jinny'),ADD_MONTHS((select PAYDAY from MEMBER where ID='jinny'),2));
insert into PAY values('JUN',3,(select PAYDAY from MEMBER where ID='jinny'),ADD_MONTHS((select PAYDAY from MEMBER where ID='jinny'),3));
insert into PAY values('JONNY',1,(select PAYDAY from MEMBER where ID='jinny'),ADD_MONTHS((select PAYDAY from MEMBER where ID='jinny'),1));

insert into SETTING values('JINNY','fullhd','0','english','wifi',0);
insert into MEMMGR values('JINNY',0,0);
insert into MYPAGE values ('JINNY', '무간도', 'movie-0001', 'drama-00175', 'Y', 'movie-00134', 'A');

insert into MEMBER values('jinny','12345','snid@naver.com','1999.01.01','2020.02.15','pre-000001','re-01');
insert into MEMBER values('candy','54321','ho@naver.com','2000.01.02','2020.03.15','pre-000002','re-02');
insert into MEMBER values('jun','45678','do@naver.com','2001.01.03','2018.03.15','pre-000003','re-03');
insert into MEMBER values('jonny','87654','ro@naver.com','2002.01.04','2015.01.30','pre-000004','re-04');

--매니지 인설트
insert into MANAGE values(to_char(sysdate, 'YY-MM'),100000);
insert into MANAGE values(to_char((sysdate-31), 'YY-MM'),200000);
insert into MANAGE values(to_char((sysdate-365), 'YY-MM'),300000);

--질문게시판
insert into QNABD values(QNABD_SEQ.nextval,'JINNY','질문있습니다','회원 탈퇴는 어떻게 하는건가요? 잘 안되네요.',sysdate,0);
insert into QNABD values(QNABD_SEQ.nextval,'CANDY','영화 넘 없어요','돈 아까운데 언제 추가해주시나여?',sysdate,0);
insert into QNABD values(QNABD_SEQ.nextval,'JUN','다큐도 나오나요?','기대돼요!!',sysdate,1);
insert into QNABD values(QNABD_SEQ.nextval,'JONNY','저작권','저작권 문제를 조십하십셔......',sysdate,1);

--알림소식
insert into NOTICE values('20-12 공지사항', '어바웃 타임이 새로 나왔습니다!', '친구 추천 이벤트');
insert into NOTICE values('20-12 업데이트', '우리 귀여운 월-E 등장~', '친구 추천 이벤트, 두번째!');

--이벤트
insert into EVENT values('PRO-001', 'CANDY', (select REMPER_CODE from MEMBER where ID='CANDY'), 'JINNY'); --캔디가 지니를 데려옴
insert into EVENT values('PRO-002', 'JONNY', (select REMPER_CODE from MEMBER where ID='JONNY'), 'JUN');--조니가 준을 데려옴
