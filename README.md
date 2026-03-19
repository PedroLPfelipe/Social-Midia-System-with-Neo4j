# Social-Midia-System-with-Neo4j
[![Neo4j](https://img.shields.io/badge/Database-Neo4j-blue)](https://neo4j.com/)
[![Bootcamp](https://img.shields.io/badge/DIO-Bootcamp-orange)](https://www.dio.me/)

Projeto de modelagem de dados desenvolvido para o desafio de **Análise de Dados com Grafos** da [DIO](https://dio.me/). O sistema utiliza algoritmos de conexão (em linguagem Cypher) entre usuários, posts e tópicos com base em comportamentos registrados na plataforma.
-

# Sobre o desafio
**PROPOSTA**

Uma startup de análise de mídias sociais deseja criar um produto que forneça insights sobre o engajamento e as conexões entre usuários em uma plataforma. Eles precisam de um protótipo funcional que possa responder as perguntas complexas sobre as interações dos usuários, popularidade de conteúdo e comunidades de interesse.

**O QUE FOI FEITO**

Usando a plataforma [Neo4j aura](https://neo4j.com), a modelagem de dados com nós e seus relacionamentos foi realizada. Também dentro da plataforma foram feitas querys de análise para registrar interações entre usuários, a popularidade de tópicos ligados aos posts, a recomendação de amizades com base em postagens curtidas e o menor caminho que liga um usuário a outro. 

# 🛠️ Modelagem de Dados

Primeiramente foram criadas restrições (Constraints) de endereçamento único para usuários, posts e tópicos dentro da plataforma de Social Media, assim evitando duplicidade para todos esses nós.
___________________________________________________
**CRIAR RESTRIÇÃO x SE ELA NÃO EXISTIR PARA (nó)**

**REQUERIR QUE nó.propriedade SEJA ÚNICA;**
___________________________________________________

CREATE CONSTRAINT user_id_unique IF NOT EXISTS FOR(u:User) 

REQUIRE u.id IS UNIQUE;

CREATE CONSTRAINT post_id_unique IF NOT EXISTS FOR(p:Post)

REQUIRE p.id IS UNIQUE;

CREATE CONSTRAINT topic_id_unique IF NOT EXISTS FOR (t:Topic)

REQUIRE t.id IS UNIQUE;
___________________________________________________
**NÓS**

🟢 *-User-*

Usuários registrados dentro da plataforma, para o protótipo foram gerados 10 usuários.

![image alt](https://github.com/PedroLPfelipe/Social-Midia-System-with-Neo4j/blob/844e5db6555450280a3f4bcebc60506ee3849461/images/all_users.png)

🔵 *-Post-*

Postagens feitas pelos usuários dentro da plataforma, para o protótipo foram geradas 10 postagens.

![image alt](https://github.com/PedroLPfelipe/Social-Midia-System-with-Neo4j/blob/844e5db6555450280a3f4bcebc60506ee3849461/images/all_posts.png)

🔴 *-Topic-*

Tópicos que contêm uma ou mais postagens, servindo para agrupar conteúdos dentro da plataforma, para o protótipo foram gerados 9 tópicos.

![image alt](https://github.com/PedroLPfelipe/Social-Midia-System-with-Neo4j/blob/844e5db6555450280a3f4bcebc60506ee3849461/images/all_topics.png)
-
Todos os nós foram criados usando o comando **MERGE** (combinação de MATCH e CREATE) .

___________________________________________________

**RELACIONAMENTOS**

:thumbsup: *-LIKED-*

O curtir, upvote, deixar o like de um usuário. Conecta usuários os conteúdos de outros usuários

:arrow_down: *-POSTED-*

O envio de uma foto ou vídeo de um usuário. Conecta usuários aos seus próprios conteúdos registrados na plataforma

:handshake:  *-FOLLOWED-*

O seguir de uma conta feito por um usuário. Conecta usuários a outros usuários

:label: *-CATEGORIZED_AS-*

A tipificação de um conteúdo postado. Conecta um post a um tópico relacionado ao conteúdo do post.

![image all](https://github.com/PedroLPfelipe/Social-Midia-System-with-Neo4j/blob/3cdfcc096b63280629f1a9e22c8a9e4691b1b187/images/call.db.schema.visualization.png)

# :mag_right: Queries de Conexão

**Quais são os 3 usuários com mais seguidores?**

MATCH (u:User)<-[:FOLLOWED]-()

RETURN u.name AS Usuário, count(*) AS seguidores

ORDER BY seguidores DESC

LIMIT 3

![image alt](https://github.com/PedroLPfelipe/Social-Midia-System-with-Neo4j/blob/8e408ccc5e1264b5b978e733669e9830e7123cd1/influential_users.jpeg)

___________________________________________________

**Qual a ordem dos usuários indo do meno influentes até o mais influente?**

MATCH (u:User)

RETURN u.name AS Usuario, 

count{(u)<-[:FOLLOWED]-()} AS seguidores

ORDER BY seguidores ASC

![image alt](https://github.com/PedroLPfelipe/Social-Midia-System-with-Neo4j/blob/e326fbab96c3bf7299bddce74df12711bfb27bb0/users_by_followers_order.jpeg)

___________________________________________________

**Quais são os usuários que não possuem nenhum seguidor na plataforma?**

MATCH (u:User)

WHERE NOT ()-[:FOLLOWED]->(u)

RETURN u.name AS Usuario

![image alt](https://github.com/PedroLPfelipe/Social-Midia-System-with-Neo4j/blob/0fb37d4460919b9ce41e33c84bac393da2d2f1f4/zero_followers_users.jpeg)

___________________________________________________

**Quais são os Trending Tópics (tópicos em alta) na plataforma?**

MATCH (t:Topic)<-[:CATEGORIZED_AS]-(p:Post)<-[l:LIKED]-()

RETURN t.name AS Topico, count(l) AS TotalCurtidas

ORDER BY TotalCurtidas DESC

![image alt](https://github.com/PedroLPfelipe/Social-Midia-System-with-Neo4j/blob/2dcc5986bf4f57c65697dea4b39110e792f3afab/trends.jpeg)

___________________________________________________

**Quais usuários curtiram o mesmo post e não estão conectados? (sugestão de amizade na plataforma)**

MATCH (a:User)-[:LIKED]->(p:Post)<-[:LIKED]-(b:User)

WHERE NOT (a)-[:FOLLOWED]->(b) AND a <> b

RETURN DISTINCT a.name AS Usuario, b.name AS Sugestao, count(p) AS Afinidade

ORDER BY Afinidade DESC

![image alt](https://github.com/PedroLPfelipe/Social-Midia-System-with-Neo4j/blob/5bd6dd49e13e81d8403fa1b79d992ee60a06221a/affinity.jpeg)

___________________________________________________

**Qual é a conexão mais rápida e direta entre dois usuários apenas considerando outros usuários?**

MATCH (pontoA:User {name: "Klaus"})

MATCH (pontoB:User {name: "Maria"})

MATCH caminho = shortestPath((pontoA)-[:FOLLOWED*..10]->(pontoB))

RETURN caminho

![image alt](https://github.com/PedroLPfelipe/Social-Midia-System-with-Neo4j/blob/fed2cb9114295a9a36cc4bd8ef0e64c931187ca0/shortest_path_only_users.png)

___________________________________________________

**Qual é a conexão mais rápida e direta entre dois usuários considerando outros usuários, posts e tópicos?**

MATCH (pontoA:User {name: "Kleber"})

MATCH(pontoB:User {name: "Maria"})

MATCH caminho = shortestPath((pontoA)-[:FOLLOWED|POSTED|LIKED*..15]-(pontoB))

RETURN caminho

![image alt](https://github.com/PedroLPfelipe/Social-Midia-System-with-Neo4j/blob/0a882405b194a5692884f9f31c76082e2058212f/shortest_path_all.png)
-
