

SELECT iw,
     MIN (CASE WHEN
        d = 6 THEN dt       
        else dt-1
        END)
FROM
(SELECT TO_DATE(:yyyymm, 'YYYYMM' ) + (LEVEL -1) dt, --20191130
        TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM' ) + (LEVEL -1), 'D')d,
        TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM' ) + (LEVEL), 'iw')iw
FROM DUAL 
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM' )),'DD'))
GROUP BY iw
ORDER BY iw;

--201910 : 35 첫주의 일요일 : 20190929,마지막주의 토요일 : 20191102
--일(1),월(2),화(3),수(4),목(5),금(6),토(7)
SELECT LDT-FDT +1
FROM
(SELECT LAST_DAY(TO_DATE(:yyyymm, 'yyyymm')) dt,

       LAST_DAY(TO_DATE(:yyyymm, 'yyyymm')) + 
       7 - TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'yyyymm')),'D') ldt,
       
       TO_DATE(:yyyymm, 'yyyymm')-
       (TO_CHAR(TO_DATE(:yyyymm, 'yyyymm'),'D')-1)fdt
FROM dual);


-----------------------------
SELECT 
        MIN(DECODE (d, 1,fdt))sun, MIN(DECODE (d, 2,fdt))mon, MIN(DECODE (d, 3,fdt))tue,
        MIN(DECODE (d, 4,fdt))wed, MIN(DECODE (d, 5,fdt))thu, MIN(DECODE (d, 6,fdt))fri,
        MIN(DECODE (d, 7,fdt))sat

FROM 
(SELECT  TO_DATE(:yyyymm, 'yyyymm')-
       (TO_CHAR(TO_DATE(:yyyymm, 'yyyymm'),'D')-1) + (LEVEL -1) fdt, --20191130
       
        TO_CHAR( TO_DATE(:yyyymm, 'yyyymm')-
       (TO_CHAR(TO_DATE(:yyyymm, 'yyyymm'),'D')-1) + (LEVEL -1), 'D')d,
        TO_CHAR( TO_DATE(:yyyymm, 'yyyymm')-
       (TO_CHAR(TO_DATE(:yyyymm, 'yyyymm'),'D')-1) + (LEVEL), 'iw') iw
        
FROM DUAL 
CONNECT BY LEVEL <= (SELECT LDT-FDT +1
                    FROM
                    (SELECT LAST_DAY(TO_DATE(:yyyymm, 'yyyymm')) dt,
                    LAST_DAY(TO_DATE(:yyyymm, 'yyyymm')) + 
                     7 - TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'yyyymm')),'D') ldt,                   
                     TO_DATE(:yyyymm, 'yyyymm')-
                       (TO_CHAR(TO_DATE(:yyyymm, 'yyyymm'),'D')-1)fdt
                        FROM dual)))

GROUP BY fdt -(d-1)
ORDER BY fdt -(d-1);