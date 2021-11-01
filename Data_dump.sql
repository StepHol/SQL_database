PGDMP                     
    y            test    13.2    13.2     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    24931    test    DATABASE     `   CREATE DATABASE test WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Czech_Czechia.1250';
    DROP DATABASE test;
                postgres    false                        2615    24932    data    SCHEMA        CREATE SCHEMA data;
    DROP SCHEMA data;
                postgres    false            �           0    0    SCHEMA data    COMMENT     "   COMMENT ON SCHEMA data IS 'data';
                   postgres    false    6            �            1255    33326    set_hq_and_agent()    FUNCTION     �  CREATE FUNCTION data.set_hq_and_agent() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
         INSERT INTO adresses (company, office_type, country,	city, street, descriptive_number, orientation_number, ZIP_code)
         VALUES(NEW.company, 'headquarters', 'Czech Republic', 'Prague', 'Nová ulice', '2000', '13', '16700');
		 INSERT INTO employees
		 VALUES ('Richard', 'King',(SELECT office_id FROM adresses WHERE company = NEW.company), 'Agent');
 
    RETURN NEW;
END;
$$;
 '   DROP FUNCTION data.set_hq_and_agent();
       data          postgres    false    6            �            1259    33337    adresses    TABLE     �  CREATE TABLE data.adresses (
    office_id integer NOT NULL,
    company character varying(255),
    office_type character(14),
    country character varying(255),
    city character varying(255),
    street character varying(255),
    descriptive_number character(10),
    orientation_number character(10),
    zip_code character varying(10),
    CONSTRAINT adresses_office_type_check CHECK ((office_type = ANY (ARRAY['headquarters'::bpchar, 'branch'::bpchar, 'foreign_branch'::bpchar])))
);
    DROP TABLE data.adresses;
       data         heap    postgres    false    6            �            1259    33335    adresses_office_id_seq    SEQUENCE     �   CREATE SEQUENCE data.adresses_office_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE data.adresses_office_id_seq;
       data          postgres    false    203    6            �           0    0    adresses_office_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE data.adresses_office_id_seq OWNED BY data.adresses.office_id;
          data          postgres    false    202            �            1259    33330 	   companies    TABLE     f   CREATE TABLE data.companies (
    company character varying(255) NOT NULL,
    "iČo" character(8)
);
    DROP TABLE data.companies;
       data         heap    postgres    false    6            �            1259    33352 	   employees    TABLE     �  CREATE TABLE data.employees (
    first_name character varying(50),
    last_name character varying(50),
    office_id integer,
    job_position character varying(50),
    CONSTRAINT employees_job_position_check CHECK (((job_position)::text = ANY ((ARRAY['Agent'::character varying, 'Director'::character varying, 'Technical Staff'::character varying, 'Economist'::character varying, 'Receptionist'::character varying])::text[])))
);
    DROP TABLE data.employees;
       data         heap    postgres    false    6            -           2604    33340    adresses office_id    DEFAULT     t   ALTER TABLE ONLY data.adresses ALTER COLUMN office_id SET DEFAULT nextval('data.adresses_office_id_seq'::regclass);
 ?   ALTER TABLE data.adresses ALTER COLUMN office_id DROP DEFAULT;
       data          postgres    false    202    203    203            �          0    33337    adresses 
   TABLE DATA                 data          postgres    false    203   n       �          0    33330 	   companies 
   TABLE DATA                 data          postgres    false    201   G       �          0    33352 	   employees 
   TABLE DATA                 data          postgres    false    204   �       �           0    0    adresses_office_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('data.adresses_office_id_seq', 7, true);
          data          postgres    false    202            3           2606    33346    adresses adresses_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY data.adresses
    ADD CONSTRAINT adresses_pkey PRIMARY KEY (office_id);
 >   ALTER TABLE ONLY data.adresses DROP CONSTRAINT adresses_pkey;
       data            postgres    false    203            1           2606    33334    companies companies_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY data.companies
    ADD CONSTRAINT companies_pkey PRIMARY KEY (company);
 @   ALTER TABLE ONLY data.companies DROP CONSTRAINT companies_pkey;
       data            postgres    false    201            4           2606    33347    adresses adresses_company_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY data.adresses
    ADD CONSTRAINT adresses_company_fkey FOREIGN KEY (company) REFERENCES data.companies(company);
 F   ALTER TABLE ONLY data.adresses DROP CONSTRAINT adresses_company_fkey;
       data          postgres    false    203    2865    201            5           2606    33356 "   employees employees_office_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY data.employees
    ADD CONSTRAINT employees_office_id_fkey FOREIGN KEY (office_id) REFERENCES data.adresses(office_id);
 J   ALTER TABLE ONLY data.employees DROP CONSTRAINT employees_office_id_fkey;
       data          postgres    false    203    204    2867            �   �  x�͔�N�0��}
�
R����V��El*�e�VSg�xI�0q�ʛ��=��v��D���3�,���2��lq9�g���-�@�	D�E�;��k)p)�Y��ڎػ��9Z�T��*�6s�	Q�X�� �k��KU�+$s�$*Zf�C{��Rd������v�Glx%Aiv�<84B�=�@�`�*/(b6Ǽ\%RX�`Sb���^�jgc>	BV����ǎ3<>L��=`E���V��8'���F	�z�U�v����?t ���C �! �PnԲa�+��}����66�.	5[h��������u ���w ��8+�S�H������xRm-�G]���<w	����$��e�#��'_os�d�=�8� l��~۾z=����p-��w��x���uKpy�	��5��ӿ&��d6+5;/�L_/�Y��,RM�Ý=�Np�4���/w�7�      �   �   x���v
Q���WHI,I�K��-H��L-VЀ0+u�2���+i*�9���+h��g&�(8C��u���ML��-�5��<�228#�� �H�3/Yd������ �D�����̼��b��� �,�-A&rq v�Jk      �   �  x���A��@E���;f$)�d��
2H�Lđؠrw94nw�v{"s�,�D���
��+nc#r���,Yz��oO���ʛ>��<^`���!&�M(tb6
bx.#��`�|��(��)F�������x����������"������+*ӿ}כ��.%<S\k�'Y�e.dC~��Vr�����]�1���B�U�������Pi�[�(�Iq�����X$���J�g��������.������(��M�H[aU�,zB��w���9�l�Fp�Y7����?�\?��B_97�#hQ��B�E���+���c�`�ۘ�v���nv��/�M2v����ţ�9�f�:kT�ਛ܇�޾�?�T+�M���5�n�TQ�*���*�I5�;�Np���8����Nρ_���%4���]�����Jk�[���E�6|���W������U,FW     