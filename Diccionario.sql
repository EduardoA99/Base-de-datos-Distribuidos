CREATE TABLE diccionario_dist (
  id_dic tinyint primary key, -- identificador 
  servidor varchar(30), -- nombre del servidor vinculado
  bd varchar(30), -- nombre de la base
  esquema varchar(30), -- nombre del esquema
  ntabla varchar(30) -- nombre de la tabla 
)
