PGDMP       5                }         	   reto-java    17.4    17.4                0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false                       1262    16389 	   reto-java    DATABASE     q   CREATE DATABASE "reto-java" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'es-EC';
    DROP DATABASE "reto-java";
                     postgres    false            �            1259    16401    clientes    TABLE     �   CREATE TABLE public.clientes (
    clienteid bigint NOT NULL,
    id bigint,
    contrasena text NOT NULL,
    estado boolean DEFAULT true
);
    DROP TABLE public.clientes;
       public         heap r       postgres    false            �            1259    16400    clientes_clienteid_seq    SEQUENCE     �   ALTER TABLE public.clientes ALTER COLUMN clienteid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.clientes_clienteid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public               postgres    false    220            �            1259    16417    cuentas    TABLE     �   CREATE TABLE public.cuentas (
    numerocuenta bigint NOT NULL,
    clienteid bigint,
    tipocuenta text NOT NULL,
    saldoinicial numeric NOT NULL,
    estado boolean DEFAULT true
);
    DROP TABLE public.cuentas;
       public         heap r       postgres    false            �            1259    16416    cuentas_numerocuenta_seq    SEQUENCE     �   ALTER TABLE public.cuentas ALTER COLUMN numerocuenta ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.cuentas_numerocuenta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public               postgres    false    222            �            1259    16431    movimientos    TABLE     �   CREATE TABLE public.movimientos (
    id bigint NOT NULL,
    numerocuenta bigint,
    fecha timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    tipomovimiento text NOT NULL,
    valor numeric NOT NULL,
    saldo numeric NOT NULL
);
    DROP TABLE public.movimientos;
       public         heap r       postgres    false            �            1259    16430    movimientos_id_seq    SEQUENCE     �   ALTER TABLE public.movimientos ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.movimientos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public               postgres    false    224            �            1259    16391    personas    TABLE     �   CREATE TABLE public.personas (
    id bigint NOT NULL,
    nombre text NOT NULL,
    genero text,
    edad integer,
    identificacion text NOT NULL,
    direccion text,
    telefono text,
    version bigint DEFAULT 0
);
    DROP TABLE public.personas;
       public         heap r       postgres    false            �            1259    16390    personas_id_seq    SEQUENCE     �   ALTER TABLE public.personas ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.personas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public               postgres    false    218                      0    16401    clientes 
   TABLE DATA           E   COPY public.clientes (clienteid, id, contrasena, estado) FROM stdin;
    public               postgres    false    220   T"                 0    16417    cuentas 
   TABLE DATA           \   COPY public.cuentas (numerocuenta, clienteid, tipocuenta, saldoinicial, estado) FROM stdin;
    public               postgres    false    222   �"                 0    16431    movimientos 
   TABLE DATA           \   COPY public.movimientos (id, numerocuenta, fecha, tipomovimiento, valor, saldo) FROM stdin;
    public               postgres    false    224   "#                 0    16391    personas 
   TABLE DATA           j   COPY public.personas (id, nombre, genero, edad, identificacion, direccion, telefono, version) FROM stdin;
    public               postgres    false    218   2$                  0    0    clientes_clienteid_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.clientes_clienteid_seq', 10, true);
          public               postgres    false    219                       0    0    cuentas_numerocuenta_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.cuentas_numerocuenta_seq', 5, true);
          public               postgres    false    221                       0    0    movimientos_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.movimientos_id_seq', 17, true);
          public               postgres    false    223                       0    0    personas_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.personas_id_seq', 10, true);
          public               postgres    false    217            o           2606    16410    clientes clientes_id_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_id_key UNIQUE (id);
 B   ALTER TABLE ONLY public.clientes DROP CONSTRAINT clientes_id_key;
       public                 postgres    false    220            q           2606    16408    clientes clientes_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_pkey PRIMARY KEY (clienteid);
 @   ALTER TABLE ONLY public.clientes DROP CONSTRAINT clientes_pkey;
       public                 postgres    false    220            s           2606    16424    cuentas cuentas_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.cuentas
    ADD CONSTRAINT cuentas_pkey PRIMARY KEY (numerocuenta);
 >   ALTER TABLE ONLY public.cuentas DROP CONSTRAINT cuentas_pkey;
       public                 postgres    false    222            u           2606    16438    movimientos movimientos_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.movimientos
    ADD CONSTRAINT movimientos_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.movimientos DROP CONSTRAINT movimientos_pkey;
       public                 postgres    false    224            k           2606    16399 $   personas personas_identificacion_key 
   CONSTRAINT     i   ALTER TABLE ONLY public.personas
    ADD CONSTRAINT personas_identificacion_key UNIQUE (identificacion);
 N   ALTER TABLE ONLY public.personas DROP CONSTRAINT personas_identificacion_key;
       public                 postgres    false    218            m           2606    16397    personas personas_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.personas
    ADD CONSTRAINT personas_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.personas DROP CONSTRAINT personas_pkey;
       public                 postgres    false    218            v           2606    16411    clientes clientes_id_fkey    FK CONSTRAINT     v   ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_id_fkey FOREIGN KEY (id) REFERENCES public.personas(id);
 C   ALTER TABLE ONLY public.clientes DROP CONSTRAINT clientes_id_fkey;
       public               postgres    false    4717    220    218            w           2606    16425    cuentas cuentas_clienteid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.cuentas
    ADD CONSTRAINT cuentas_clienteid_fkey FOREIGN KEY (clienteid) REFERENCES public.clientes(clienteid) ON DELETE CASCADE;
 H   ALTER TABLE ONLY public.cuentas DROP CONSTRAINT cuentas_clienteid_fkey;
       public               postgres    false    222    220    4721            x           2606    16439 )   movimientos movimientos_numerocuenta_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.movimientos
    ADD CONSTRAINT movimientos_numerocuenta_fkey FOREIGN KEY (numerocuenta) REFERENCES public.cuentas(numerocuenta) ON DELETE CASCADE;
 S   ALTER TABLE ONLY public.movimientos DROP CONSTRAINT movimientos_numerocuenta_fkey;
       public               postgres    false    222    224    4723               e   x�3�4�453��,�2�4�44212M9M9�JS����J��SoL442ʘq��1�4�!c�i�l�%�%g@bi�	P�54�"�̂��b��=... a'(�         I   x�3�4�t�/*�L�+I�440�,�2�4�t� 
�s��&@50��	H�����?(���/���@�5F��� ���            x�m�1n!�z�{�E�`)c�H�J�օ+G�o�#�b�"v		!��3�d`��H�O�Q4i9�/���m�I6ϣo�	K�ؐ*�EhE
����������z��iAK�¾���p��B!R������V�!�SR��QaY���0_$�e���0	w��2�{Ҳ��B�L���'��:��L��t=�F����%N/86�j��D��{�>�eM�8e��~���od�2.BM`���ԕL��Ì��X���         G  x���KJA�u�)�	����2�
���Wn�I[:�:�tn�9���h ��bm���K�;��8d���� Wfc���!yQ�<�L68�����Y.�ץΫ���3ӄ�����@fl�����J)-Ş������D�������J��74�����&�6����O�?�5ݦr]�U�aҏ��Kg؝��n�t��d�����p	�n��:��zk�SB�J�����)�l��O����C�5�19�@�v���Rjh���6x�`EZ#�HpN�a���;"��}2��s"�J�B��kt��w��c��r$�<��~�e����     