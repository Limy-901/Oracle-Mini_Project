-- 주제
create table SUBJECT(
	J_CODE number(2) constraint SUB_PK primary key, -- 주제코드(PK)
	J_NAME varchar2(30) constraint SUB_CK           -- 주제명
	check(J_NAME in('영화','드라마','다큐','예능'))
);

-- 장르
create table GENRE(
	G_CODE number(2) constraint GENRE_PK primary key, -- 장르코드(PK)
	G_NAME varchar2(30)                               -- 장르명
);

-- 작품
create table VID(
	V_CODE number constraint VID_PK primary key,                     -- 작품코드(시퀀스)(PK)
	V_NAME varchar2(30),                                             -- 작품제목
	DIR_NAME varchar2(30),                                           -- 감독명
	COU_NAME varchar2(30),                                           -- 국가명
	ACTOR_NAME varchar2(30),                                         -- 주연배우
	RELEASE_DATE date,                                               -- 개봉일
	J_CODE number(2) constraint VID_J_FK references SUBJECT(J_CODE), -- 주제코드(FK)
	G_CODE number(2) constraint VID_G_FK references GENRE(G_CODE)    -- 장르코드(FK)
);
create sequence VID_SEQ increment by 1 start with 1 nocache;

-- 회원
create TABLE MEMBER(
	ID VARCHAR2(10) constraint MEM_PK primary key, -- ID(PK)
	PWD VARCHAR2(20),                              -- PWD
	EMAIL VARCHAR2(30),                            -- 이메일
	BIRTH VARCHAR2(26),                            -- 생년월일
	PAYDAY DATE,                                   -- 결제일
	REMPER_CODE VARCHAR2(10)                       -- 추천인코드
);

-- 결제
create table PAY(
	ID varchar2(10) constraint PAY_PK primary key references MEMBER(ID),  -- ID(PK)
	P_INFOM NUMBER(2),                                                    -- 결제정보
	P_DATE DATE,                                                          -- 시작일
	P_END DATE                                                            -- 종료일
);

-- 설정
create table SETTING (
	ID varchar2(15) constraint SETTING_ID_FK references MEMBER(ID),  -- ID(FK)
	QUALITY varchar2(10),                                            -- 화질[FullHD,HD]
	SUBTITLE varchar2(10),                                           -- 자막[0,1]
	DUBBING varchar2(10),                                            -- 더빙[0,1]
	WIFI varchar2(10),                                               -- 접속방식[data,wifi]
	ABROAD NUMBER(1)                                                 -- 해외접속[0,1]
);

-- 회원관리
create table MEMMGR (
	ID varchar2(15) constraint MEMMGR_ID_FK references MEMBER(ID),   -- ID(FK)
	SO_LOGIN NUMBER(1),                                              -- 소셜로그인여부[0,1]
	CERTIFY NUMBER(1)                                                -- 이메일인증여부[0,1]
);

-- 마이페이지
create table MYPAGE (
	ID varchar2(15) constraint MYPAGE_ID_FK references MEMBER(ID),   -- ID(FK)
	VID_REQUEST varchar2(30),                                        -- 영상요청
	HISTORY varchar2(30),                                            -- 최근기록
	DOWNLOAD varchar2(30),                                           -- 다운로드
	SERVICE varchar2(30),                                            -- 고객센터
	HEART_LIST varchar2(30),                                         -- 찜목록
	COMMUNITY varchar2(30)                                           -- 읏챠커뮤니티참여
);

-- 리뷰
create table REVIEW(
	V_CODE number constraint REVIEW_PK references VID(V_CODE), -- 작품코드(PK)
	V_REVIEW varchar2(1000),                                   -- 리뷰내용
	V_GRADE number(2),                                         -- 별점
	ID varchar2(15) constraint REVIEW_FK references MEMBER(ID) -- 아이디(FK)
);

-- 스트리밍
create table STREAMING(
	V_CODE number references VID(V_CODE),      -- 작품코드(PK)
	ID varchar2(15) references MEMBER(ID),     -- 아이디(PK)
	V_DATE date,                               -- 시청일
	V_CONTINUE number(3)                       -- 이어보기시점
);
alter table STREAMING add constraint STREAMING_PK primary key(V_CODE,ID);

-- 알림소식
create table NOTICE(
	NEW_NOTICE varchar2(30),                                        -- 공지사항
	NEW_RECOM varchar2(100),                                         -- 신작추천
	NEW_EVENT varchar2(30)                                          -- 이벤트
);
-- 질문게시판 시퀀스
create table QNABD(
	QNA_IDX number constraint QNA_PK primary key,                   -- 게시글번호(시퀀스) (PK)
	ID varchar2(15) constraint ID_FK references MEMBER(ID),         -- 아이디(FK)
	QNA_TITLE varchar2(30),                                         -- 글제목
	QNA_POST varchar2(1000),                                        -- 글내용
	QNA_DATE date,                                                  -- 날짜
	QNA_COMPLETE number(2)                                          -- 답변여부
);
create sequence QNABD_SEQ increment by 1 start with 1 nocache;

-- 관리자
create table MANAGE( 
	MONTH varchar2(10),    -- 해당월
	MONTH_SALES number(20) -- 매출기록
);

-- 이벤트
create table EVENT(
	DCT_CODE varchar2(10),    -- 할인코드
	DCT_FRND varchar2(10),    -- 초대한사람
	REMPER_CODE varchar2(10), -- 추천인코드
	ID varchar2(15)           -- 신규회원아이디
);

-- 멤버 insert시 셋팅값 디폴트값으로 설정해주는 트리거
create or replace trigger TRI_MKSET
after
	insert on MEMBER
	for each row
begin
	insert into SETTING
	values(:new.ID,'HD','0','KOREAN','DATA','0');
end;
/

-- 멤버 insert시 멤버관리 디폴트값으로 설정해주는 트리거
create or replace trigger TRI_MKMEMMGR
after
	insert on MEMBER
	for each row
begin
	insert into MEMMGR
	values(:new.ID,'0','0');
end;
/

-- 작품 insert시 신작추천 자동생성 트리거
create or replace trigger TRI_NEWVID
after
	insert on VID
	for each row
begin
	insert into NOTICE(NEW_RECOM)
	values(:new.V_NAME||'이 새로 나왔습니다.');
end;
/
