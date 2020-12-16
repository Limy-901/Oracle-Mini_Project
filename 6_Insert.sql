
-- 주제
insert into SUBJECT values(10,'영화');
insert into SUBJECT values(20,'드라마');
insert into SUBJECT values(30,'다큐');
insert into SUBJECT values(40,'예능');

-- 장르
insert into GENRE values(51,'판타지');
insert into GENRE values(52,'멜로');
insert into GENRE values(53,'코믹');
insert into GENRE values(54,'공포');
insert into GENRE values(55,'스릴러');
insert into GENRE values(56,'액션');
insert into GENRE values(57,'드라마');

-- 작품
insert into VID values(vid_SEQ.nextval,'어바웃 타임','리차드 커티스','영국','레이첼 맥아담스','2013/12/05',10,52);
insert into VID values(vid_SEQ.nextval,'행복을 찾아서','가브리엘 무치노','미국','윌 스미스','2007/02/28',10,57);
insert into VID values(vid_SEQ.nextval,'그 시절 우리가 좋아했던 소녀','구파도','대만','가진동,션자이','2012/08/22',10,52);
insert into VID values(vid_SEQ.nextval,'월-E','앤드류 스탠튼','미국','월-E','2008/08/06',10,51);

-- 회원
insert into MEMBER values('JINNY','wda123','SNID@NAVER.COM','1999.01.01','2020.02.15','RE-01');
insert into MEMBER values('CANDY','gf2123','HO@NAVER.COM','2000.01.02','2020.03.15','RE-02');
insert into MEMBER values('JUN','ge9293','DO@NAVER.COM','2001.01.03','2018.03.15','RE-03');
insert into MEMBER values('JONNY','jonny3','RO@NAVER.COM','2002.01.04','2015.01.30','RE-04');

-- 결제
insert into PAY values('JINNY',1,(select PAYDAY from member where id='JINNY'),ADD_MONTHS((select PAYDAY from member where id='JINNY'),1));
insert into PAY values('CANDY',2,(select PAYDAY from member where id='CANDY'),ADD_MONTHS((select PAYDAY from member where id='CANDY'),2));
insert into PAY values('JUN',3,(select PAYDAY from member where id='JUN'),ADD_MONTHS((select PAYDAY from member where id='JUN'),3));
insert into PAY values('JONNY',1,(select PAYDAY from member where id='JONNY'),ADD_MONTHS((select PAYDAY from member where id='JONNY'),1));

-- 셋팅
insert into SETTING values('JINNY','fullhd','0','ENGLISH','wifi',1);
insert into SETTING values('CANDY','hd','1','KOREAN','4G',0);
insert into SETTING values('JUN','hd','1','KOREAN','4G',0);
insert into SETTING values('JONNY','fullhd','0','ENGLISH','wifi',1);

-- 회원관리
insert into MEMMGR values('JINNY',0,1);
insert into MEMMGR values('CANDY',1,1);
insert into MEMMGR values('JUN',1,0);
insert into MEMMGR values('JONNY',0,1);

-- 마이페이지
insert into MYPAGE values ('JINNY', '무간도', (select V_CODE from STREAMING where ID='JINNY'), 'MOVIE-00175', '0', '어바웃 타임', 'A');
insert into MYPAGE values ('CANDY', '테넷', (select V_CODE from STREAMING where ID='CANDY'), 'DRAMA-00115', '1', '어바웃 타임', 'B');
insert into MYPAGE values ('JUN', '조제', (select V_CODE from STREAMING where ID='JUN'), 'DRAMA-00125', '1', '그 시절 우리가 좋아했던 소녀', 'A');
insert into MYPAGE values ('JONNY', '더 문', (select V_CODE from STREAMING where ID='JONNY'), 'MOVIE-00105', '0', '행복을 찾아서', 'B');


-- 스트리밍
insert into STREAMING values((select V_CODE from VID where V_NAME='월-E'),'JINNY','2019-03-20',50);
insert into STREAMING values((select V_CODE from VID where V_NAME='행복을 찾아서'),'CANDY','2020-05-14',32);
insert into STREAMING values((select V_CODE from VID where V_NAME='어바웃 타임'),'JUN','2020-10-19',121);
insert into STREAMING values((select V_CODE from VID where V_NAME='그 시절 우리가 좋아했던 소녀'),'JINNY','2020-12-25',86);

-- 리뷰
insert into REVIEW values((select V_CODE from VID where V_NAME='어바웃 타임'),'계속 보게됨, 배우가 예쁨',4.6,'JINNY');
insert into REVIEW values((select V_CODE from VID where V_NAME='월-E'),'저렇게 순수할 수 있을까',5,'CANDY');
insert into REVIEW values((select V_CODE from VID where V_NAME='행복을 찾아서'),'정말 감동적이에요.. 추천',5,'JUN');
insert into REVIEW values((select V_CODE from VID where V_NAME='그 시절 우리가 좋아했던 소녀'),'부럽다, 웰컴 크리스마스',5,'JONNY');

-- 관리
insert into MANAGE values(to_char(SYSDATE, 'YY-MM'),100000);
insert into MANAGE values(to_char((SYSDATE-31), 'YY-MM'),200000);
insert into MANAGE values(to_char((SYSDATE-365), 'YY-MM'),300000);

-- 질문게시판
insert into QNABD values(QNABD_SEQ.nextval,'JINNY','질문있습니다','회원 탈퇴는 어떻게 하는건가요? 잘 안되네요.','2020-01-25',0);
insert into QNABD values(QNABD_SEQ.nextval,'CANDY','영화 넘 없어요','돈 아까운데 언제 추가해주시나여?','2019-12-31',0);
insert into QNABD values(QNABD_SEQ.nextval,'JUN','다큐도 나오나요?','기대돼요!!','2018-06-03',1);
insert into QNABD values(QNABD_SEQ.nextval,'JONNY','저작권','저작권 문제를 조십하십셔......','2020-11-13',1);

-- 알림
insert into NOTICE values('20-12 공지사항', '어바웃 타임이 새로 나왔습니다!', '친구 추천 이벤트');
insert into NOTICE values('20-12 업데이트', '우리 귀여운 월-E 등장~', '친구 추천 이벤트, 두번째!');

-- 이벤트
insert into EVENT values('PRO-001', 'CANDY', (select REMPER_CODE from member where id='CANDY'), 'JINNY'); 
insert into EVENT values('PRO-002', 'JONNY', (select REMPER_CODE from member where id='JONNY'), 'JUN');