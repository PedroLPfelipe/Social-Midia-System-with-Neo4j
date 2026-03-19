//Usuários da plataforma 

MERGE (Klaus:User {id: "U001-1", name: "Klaus", register_date: date("2009-05-10"), reputation: 50})

MERGE (Jonas:User {id: "U002-1", name: "Jonas", register_date: date("2018-09-18"), reputation: 20})

MERGE (Maria:User {id: "U003-1", name: "Maria", register_date: date("2013-11-19"), reputation: 20})

MERGE (Cyntia:User {id: "U004-1", name: "Cyntia", register_date: date("2018-09-19"), reputation: 10})

MERGE (Raphael:User {id: "U005-1", name: "Raphael", register_date: date("2019-07-22"), reputation: 30})

MERGE (Roger:User {id: "U006-1", name: "Roger", register_date: date("2012-04-26"), reputation: 10})

MERGE (Marcos:User {id: "U007-1", name: "Marcos", register_date: date("2017-11-09"), reputation: 40})

MERGE (Joseph:User {id: "U008-1", name: "Joseph", register_date: date("2013-02-21"), reputation: 50})

MERGE (Ana:User {id: "U009-1", name: "Ana", register_date: date("2020-10-19"), reputation: 10})

MERGE (Kleber:User {id: "U010-1", name: "Kleber", register_date: date("2018-03-14"), reputation: 30})

//Alguns posts feitos dentro da plataforma

MERGE (p1:Post {id: "U001-2", description: "Que dia bonito, bom dia povo", post_date: date("2009-07-10"), type: "foto", trend: ['#ROTINA', '#fotografia']})

MERGE (p2:Post {id: "U002-2", description: "Jogo horrível, a defesa do time não existe!", post_date: date("2019-05-21"), type: "video", trend: ['#futebol', '#brasileirão', '#Santos']})

MERGE (p3:Post {id: "U003-2", description: "Essa placa de vídeo é excelente! Recomendo.", post_date: date("2015-05-02"), type: "foto", trend: ['#NVIDIA', '#RTX4080', '#tecnologia']})

MERGE (p4:Post {id: "U004-2", description: "Nova casa, nova vida! Oi NY!", post_date: date("2021-01-23"), type: "video", trend:['#mudança', '#casanova', '#conquista', '#NovaYork']})

MERGE (p5:Post {id: "U005-2", description: "Filme muito divertido, amei do início ao fim", post_date: date("2019-09-12"), type: "foto", trend: '#GatodeBotas2'})

MERGE (p6:Post {id: "U006-2", description: "Estudando para os testes finais do semestre, socorro!", post_date: date("2012-04-26"), type: "foto", trend: ['EngenhariaElétrica', 'graduação']})

MERGE (p7:Post {id: "U007-2", description: "Nova receita, use o link para ver os ingredientes.", post_date: date("2019-11-09"), type: "foto", trend: '#Culinária'})

MERGE (p8:Post {id: "U008-2", description: "Obras lidas no útlimo semestre. Participe do clube do livro.", post_date: date("2015-08-29"), type: "video", trend: ['#Murakami', '#Hesse', '#Kafka', '#ClariceLispector']})

MERGE (p9:Post {id: "U009-2", description: "Eu amo odiar esse time, não jogam nada, não prometem nada, mas eu me iludo.", post_date: date("2023-01-29"), type: "foto", trend: ['#Vasco', '#brasileirão', '#futebol']})

MERGE (p10:Post {id: "U010-2", description: "Gostaria de compartilhar que consegui a minha certificação!", post_date: date("2026-03-18"), type: "foto", trend: "#DIOCOURSES"}) 

//Tópicos disponibilizados para pesquisa dentro da plataforma 

MERGE (t1:Topic{id:'U001-3', name:'Sports', post_number:12678093})

MERGE (t2:Topic{id:'U002-3', name:'Photografy', post_number:7612003})

MERGE (t3:Topic{id:'U003-3', name:'Studies', post_number:1658011})

MERGE (t4:Topic{id:'U004-3', name:'Technology', post_number:12678093})

MERGE (t5:Topic{id:'U005-3', name:'Foods', post_number:19458129})

MERGE (t6:Topic{id:'U006-3', name:'Engineering', post_number:789321})

MERGE (t7:Topic{id:'U007-3', name:'Movies', post_number:17783991})

MERGE (t8:Topic{id:'U008-3', name:'Interior', post_number:1897458})

MERGE (t9:Topic{id:'U009-3', name:'Books', post_number:2094667})

// Relacionamentos entre usuários e postagens feitas na plataforma

MERGE (Klaus)-[:POSTED]->(p1)
MERGE (Jonas)-[:POSTED]->(p2)
MERGE (Maria)-[:POSTED]->(p3)
MERGE (Cyntia)-[:POSTED]->(p4)
MERGE (Raphael)-[:POSTED]->(p5)
MERGE (Roger)-[:POSTED]->(p6)
MERGE (Marcos)-[:POSTED]->(p7)
MERGE (Joseph)-[:POSTED]->(p8)
MERGE (Ana)-[:POSTED]->(p9)
MERGE (Kleber)-[:POSTED]->(p10)

// Relacionamentos entre postagens e tópicos existentes na plataforma

MERGE (p1)-[:CATEGORIZED_AS]->(t2)
MERGE (p2)-[:CATEGORIZED_AS]->(t1)
MERGE (p3)-[:CATEGORIZED_AS]->(t4)
MERGE (p4)-[:CATEGORIZED_AS]->(t8)
MERGE (p5)-[:CATEGORIZED_AS]->(t7)
MERGE (p6)-[:CATEGORIZED_AS]->(t3)
MERGE (p6)-[:CATEGORIZED_AS]->(t6)
MERGE (p7)-[:CATEGORIZED_AS]->(t5)
MERGE (p8)-[:CATEGORIZED_AS]->(t9)
MERGE (p9)-[:CATEGORIZED_AS]->(t1)
MERGE (p10)-[:CATEGORIZED_AS]->(t3)

//Relacionamento de seguidores

MERGE (Klaus)-[:FOLLOWED]->(Jonas)
MERGE (Klaus)-[:FOLLOWED]->(Kleber)
MERGE (Jonas)-[:FOLLOWED]->(Maria)
MERGE (Maria)-[:FOLLOWED]->(Jonas)
MERGE (Cyntia)-[:FOLLOWED]->(Klaus)
MERGE (Cyntia)-[:FOLLOWED]->(Maria)
MERGE (Raphael)-[:FOLLOWED]->(Ana)
MERGE (Raphael)-[:FOLLOWED]->(Roger)
MERGE (Roger)-[:FOLLOWED]->(Raphael)
MERGE (Joseph)-[:FOLLOWED]->(Klaus)
MERGE (Ana)-[:FOLLOWED]->(Kleber)

//Relacionamento de curtidas

MERGE (Klaus)-[:LIKED {like_date:date("2026-03-18")}]->(p10)
MERGE (Klaus)-[:LIKED {like_date:date("2023-02-02")}]->(p9)
MERGE (Klaus)-[:LIKED {like_date:date("2019-07-19")}]->(p2)
MERGE (Jonas)-[:LIKED {like_date:date("2021-02-13")}]->(p8)
MERGE (Maria)-[:LIKED {like_date:date("2014-12-11")}]->(p1)
MERGE (Cyntia)-[:LIKED {like_date:date("2020-08-17")}]->(p2)
MERGE (Kleber)-[:LIKED {like_date:date("2018-05-19")}]->(p3)
MERGE (Raphael)-[:LIKED {like_date:date("2019-08-05")}]->(p6)
MERGE (Raphael)-[:LIKED {like_date:date("2020-06-22")}]->(p8)
