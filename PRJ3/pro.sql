CREATE OR REPLACE FUNCTION rand_ill ( abc NUMBER ) RETURN VARCHAR2 IS

    ill   VARCHAR2(10);
    ran   NUMBER := round(dbms_random.value(0,3) );
BEGIN
    IF
        ran <= 1
    THEN
        ill := 'Cardiac';
    ELSIF ran <= 2 THEN
        ill := 'Neuro';
    ELSIF ran <= 3 THEN
        ill := 'General';
    END IF;

    RETURN ill;
END;
/

CREATE OR REPLACE PROCEDURE pop_patient_chart AS

    tmin    NUMBER := 95;
    tmax    NUMBER := 102;
    bpmin   NUMBER := 100;
    bpmax   NUMBER := 150;
BEGIN
    FOR i IN 0..40 LOOP
            IF
                i = 0 OR i = 20
            THEN
                INSERT INTO patient_input VALUES (
                    'Bob',
                    TO_DATE('2005-11-25','yyyy-MM-dd') + i,
                    rand_ill(1)
                );

            END IF;

            IF
                i >= 2
            THEN
                INSERT INTO patient_chart VALUES (
                    'Bob',
                    TO_DATE('2005-11-25','yyyy-MM-dd') + i,
                    round(dbms_random.value(tmin,tmax) ),
                    round(dbms_random.value(bpmin,bpmax) )
                );

            END IF;

    END LOOP;

    FOR i IN 0..25 LOOP
        FOR j IN 0..25 LOOP
--            dbms_output.put_line(i || ' ' || j);
            IF
--                                mod(I,26) = J
                i = j
            THEN
                INSERT INTO patient_input VALUES (
                    chr(65 + j),
                    TO_DATE('2005-12-06','yyyy-MM-dd') + i,
                    rand_ill(1)
                );

            END IF;

            IF
                i >= j
            THEN
                INSERT INTO patient_chart VALUES (
                    chr(65 + j),
                    TO_DATE('2005-12-06','yyyy-MM-dd') + i,
                    round(dbms_random.value(tmin,tmax) ),
                    round(dbms_random.value(bpmin,bpmax) )
                );

            END IF;

        END LOOP;
    END LOOP;

END;
/

CREATE OR REPLACE PROCEDURE pop_patient_input
    AS
BEGIN
    FOR i IN 0..60 LOOP
        IF
            i = 0 OR i = 20 OR i = 40
        THEN
            INSERT INTO patient_input VALUES (
                'Bob',
                TO_DATE('2005-11-06','yyyy-MM-dd') + i,
                rand_ill(1)
            );

        END IF;

        FOR j IN 0..25 LOOP
--            dbms_output.put_line(i || ' ' || j);
            IF
                MOD(i,26) = j
--                i = j
            THEN
                INSERT INTO patient_input VALUES (
                    chr(65 + j),
                    TO_DATE('2005-11-06','yyyy-MM-dd') + i,
                    rand_ill(1)
                );
                                INSERT INTO patient_input VALUES (
                    chr(65 + j),
                    TO_DATE('2005-04-01','yyyy-MM-dd') + i,
                    rand_ill(1)
                );
                

            END IF;
        END LOOP;

    END LOOP;
END;
/
SHOW ERROR