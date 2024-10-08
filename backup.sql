PGDMP                      |            veiculo    16.3    16.3 !               0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    16662    veiculo    DATABASE     ~   CREATE DATABASE veiculo WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Portuguese_Brazil.1252';
    DROP DATABASE veiculo;
                postgres    false            �            1259    16664    carro    TABLE     �   CREATE TABLE public.carro (
    id integer NOT NULL,
    titulo character varying(255) NOT NULL,
    autor character varying(255) NOT NULL,
    data_cadastro date NOT NULL
);
    DROP TABLE public.carro;
       public         heap    postgres    false            �            1259    16691    carro_estacionamento    TABLE     t   CREATE TABLE public.carro_estacionamento (
    carro_id integer NOT NULL,
    estacionamento_id integer NOT NULL
);
 (   DROP TABLE public.carro_estacionamento;
       public         heap    postgres    false            �            1259    16663    carro_id_seq    SEQUENCE     �   CREATE SEQUENCE public.carro_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.carro_id_seq;
       public          postgres    false    216                       0    0    carro_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.carro_id_seq OWNED BY public.carro.id;
          public          postgres    false    215            �            1259    16673    cor    TABLE     _   CREATE TABLE public.cor (
    id integer NOT NULL,
    nome character varying(255) NOT NULL
);
    DROP TABLE public.cor;
       public         heap    postgres    false            �            1259    16672 
   cor_id_seq    SEQUENCE     �   CREATE SEQUENCE public.cor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 !   DROP SEQUENCE public.cor_id_seq;
       public          postgres    false    218                       0    0 
   cor_id_seq    SEQUENCE OWNED BY     9   ALTER SEQUENCE public.cor_id_seq OWNED BY public.cor.id;
          public          postgres    false    217            �            1259    16680    estacionamento    TABLE     �   CREATE TABLE public.estacionamento (
    id integer NOT NULL,
    nome character varying(255) NOT NULL,
    cor_id integer NOT NULL
);
 "   DROP TABLE public.estacionamento;
       public         heap    postgres    false            �            1259    16679    estacionamento_id_seq    SEQUENCE     �   CREATE SEQUENCE public.estacionamento_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.estacionamento_id_seq;
       public          postgres    false    220                       0    0    estacionamento_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.estacionamento_id_seq OWNED BY public.estacionamento.id;
          public          postgres    false    219            �            1259    16706    vw_estacionamentos_por_cor    VIEW     �   CREATE VIEW public.vw_estacionamentos_por_cor AS
 SELECT cor.nome AS cor,
    count(estacionamento.id) AS numero_estacionamentos
   FROM (public.cor
     JOIN public.estacionamento ON ((estacionamento.cor_id = cor.id)))
  GROUP BY cor.nome;
 -   DROP VIEW public.vw_estacionamentos_por_cor;
       public          postgres    false    220    218    218    220            �            1259    16714    vw_estacionamentos_preto    VIEW     p   CREATE VIEW public.vw_estacionamentos_preto AS
 SELECT nome
   FROM public.estacionamento
  WHERE (cor_id = 1);
 +   DROP VIEW public.vw_estacionamentos_preto;
       public          postgres    false    220    220            f           2604    16667    carro id    DEFAULT     d   ALTER TABLE ONLY public.carro ALTER COLUMN id SET DEFAULT nextval('public.carro_id_seq'::regclass);
 7   ALTER TABLE public.carro ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    215    216    216            g           2604    16676    cor id    DEFAULT     `   ALTER TABLE ONLY public.cor ALTER COLUMN id SET DEFAULT nextval('public.cor_id_seq'::regclass);
 5   ALTER TABLE public.cor ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    218    217    218            h           2604    16683    estacionamento id    DEFAULT     v   ALTER TABLE ONLY public.estacionamento ALTER COLUMN id SET DEFAULT nextval('public.estacionamento_id_seq'::regclass);
 @   ALTER TABLE public.estacionamento ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    220    219    220                      0    16664    carro 
   TABLE DATA           A   COPY public.carro (id, titulo, autor, data_cadastro) FROM stdin;
    public          postgres    false    216   �$                 0    16691    carro_estacionamento 
   TABLE DATA           K   COPY public.carro_estacionamento (carro_id, estacionamento_id) FROM stdin;
    public          postgres    false    221   �%                 0    16673    cor 
   TABLE DATA           '   COPY public.cor (id, nome) FROM stdin;
    public          postgres    false    218   &       
          0    16680    estacionamento 
   TABLE DATA           :   COPY public.estacionamento (id, nome, cor_id) FROM stdin;
    public          postgres    false    220   Q&                  0    0    carro_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.carro_id_seq', 4, true);
          public          postgres    false    215                       0    0 
   cor_id_seq    SEQUENCE SET     8   SELECT pg_catalog.setval('public.cor_id_seq', 4, true);
          public          postgres    false    217                       0    0    estacionamento_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.estacionamento_id_seq', 14, true);
          public          postgres    false    219            p           2606    16695 .   carro_estacionamento carro_estacionamento_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.carro_estacionamento
    ADD CONSTRAINT carro_estacionamento_pkey PRIMARY KEY (carro_id, estacionamento_id);
 X   ALTER TABLE ONLY public.carro_estacionamento DROP CONSTRAINT carro_estacionamento_pkey;
       public            postgres    false    221    221            j           2606    16671    carro carro_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.carro
    ADD CONSTRAINT carro_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.carro DROP CONSTRAINT carro_pkey;
       public            postgres    false    216            l           2606    16678    cor cor_pkey 
   CONSTRAINT     J   ALTER TABLE ONLY public.cor
    ADD CONSTRAINT cor_pkey PRIMARY KEY (id);
 6   ALTER TABLE ONLY public.cor DROP CONSTRAINT cor_pkey;
       public            postgres    false    218            n           2606    16685 "   estacionamento estacionamento_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.estacionamento
    ADD CONSTRAINT estacionamento_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.estacionamento DROP CONSTRAINT estacionamento_pkey;
       public            postgres    false    220            r           2606    16696 7   carro_estacionamento carro_estacionamento_carro_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.carro_estacionamento
    ADD CONSTRAINT carro_estacionamento_carro_id_fkey FOREIGN KEY (carro_id) REFERENCES public.carro(id);
 a   ALTER TABLE ONLY public.carro_estacionamento DROP CONSTRAINT carro_estacionamento_carro_id_fkey;
       public          postgres    false    216    221    4714            s           2606    16701 @   carro_estacionamento carro_estacionamento_estacionamento_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.carro_estacionamento
    ADD CONSTRAINT carro_estacionamento_estacionamento_id_fkey FOREIGN KEY (estacionamento_id) REFERENCES public.estacionamento(id);
 j   ALTER TABLE ONLY public.carro_estacionamento DROP CONSTRAINT carro_estacionamento_estacionamento_id_fkey;
       public          postgres    false    4718    221    220            q           2606    16686 )   estacionamento estacionamento_cor_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.estacionamento
    ADD CONSTRAINT estacionamento_cor_id_fkey FOREIGN KEY (cor_id) REFERENCES public.cor(id);
 S   ALTER TABLE ONLY public.estacionamento DROP CONSTRAINT estacionamento_cor_id_fkey;
       public          postgres    false    218    4716    220               �   x�E��J�0�s��T���ۂ� ��x�2N�n�͔$��ݓ��3��a���q�!P��~�/`JIA,9/�W1S"��נ��nߴ��kmg MI����^�L�ĳBX��g�`� ��QW�U8�3O"3^%�@^z�˥���⧦�����ε*��Un]�ݛ���g��s=N�*�(�;�2,_���6���7��_��S�         +   x�3�4�2�44�2�a#.c��1�1�	�6�4bS�=... o         0   x�3�,(J-��2�,K-�M����2�L*J�K��2�%�$r��qqq 
�      
   �   x�=���@Eם����RY�A%��r3��L4)%��[����'�B�Q'�`M�g��")H�"XI����C|aA����,p=�x��r�c���h��#H��Qb���a��k�K���'n-T=Q���)�f�3V�o�Z�K�u�R�q�:s[c>�'>"     