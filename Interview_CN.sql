##计算最大连续登录天数

create table #Tmp_Data
(
    List_ID int identity(1,1),
    UID varchar(10),
    LoadTime datetime
)
 
INSERT INTO #Tmp_Data
Select '201','2017/01/01' union all
Select '201','2017/01/02' union all
Select '202','2017/01/02' union all
Select '202','2017/01/03' union all
Select '203','2017/01/03' union all
Select '201','2017/01/04' union all
Select '202','2017/01/04' union all
Select '201','2017/01/05' union all
Select '202','2017/01/05' union all
Select '201','2017/01/06' union all
Select '203','2017/01/06' union all
Select '203','2017/01/07' 

Select UID,max(cnt) as cnt
From (
            Select UID,Grp_No,count(*) as cnt
            From (
                    Select UID,LoadTime,(Day(LoadTime)-ROW_NUMBER() OVER (Partition By UID Order By UID,LoadTime)) as Grp_No 
                    From #Tmp_Data 
                  ) a
            Group By UID,Grp_No
      ) a
Group By UID
