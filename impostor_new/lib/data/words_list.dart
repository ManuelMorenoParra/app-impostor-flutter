const List<String> wordsList = [
  // 1 - 100
  "avión","limón","caja","montaña","cuchara","guitarra","lluvia","cámara","zorro","ventana",
  "botella","lámpara","café","pizarra","mariposa","planta","teléfono","coche","camino","nube",
  "estrella","puerta","sombrero","libro","isla","pescado","llave","río","zapato","pelota",
  "pan","queso","tigre","mapa","tren","peine","cangrejo","arena","bosque","pasto",
  "fuego","humo","ratón","luna","sol","techo","pared","plato","escoba","jarrón",
  "almohada","mar","tierra","ciudad","campo","flor","rosa","naranja","cielo","árbol",
  "silla","mesa","pluma","pájaro","nido","granja","puente","piedra","castillo","barco",
  "carne","hielo","viento","fruta","playa","gato","perro","conejo","burro","caballo",
  "oveja","diente","mano","ojo","nariz","cabeza","pierna","brazo","corazón","fantasma",
  "robot","ninja","pirata","globo","cable","pantalla","teclado","martillo","clavo","tornillo",

  // 101 - 200
  "cuerda","puñal","flecha","arco","camisa","pantalón","abrigo","guante","bufanda","caverna",
  "lancha","fantasía","espada","moneda","cuadro","alfombra","copa","ventilador","radio","televisor",
  "reloj","tijeras","pegamento","funda","pastel","galleta","cereza","sandía","melón","tomate",
  "cebolla","zanahoria","pepino","pollo","huevo","bolsillo","baúl","serpiente","medusa","tiburón",
  "ballena","delfín","tortuga","lagarto","murciélago","camello","mono","gorila","jirafa","elefante",
  "rinoceronte","hipopótamo","panda","castor","ardilla","búho","águila","halcón","foca","pingüino",
  "renacuajo","dragón","duende","bruja","hechizo","mago","trono","mina","cueva","lavadora",
  "microondas","horno","sartén","cuchillo","tenedor","servilleta","jabón","champú","cepillo","toalla",
  "espejo","taburete","cucharón","bolsa","mochila","carrito","triciclo","bicicleta","patineta","patín",

  // 201 - 300
  "camión","tractor","helicóptero","cohete","satélite","planeta","galaxia","universo","asteroide","meteorito",
  "cometa","espacio","astronauta","microbio","virus","bacteria","molécula","energía","átomo","química",
  "pintura","escultura","cine","teatro","música","danza","idioma","historia","física","biología",
  "geografía","poema","cuento","leyenda","mito","invierno","otoño","primavera","verano","trueno",
  "tormenta","huracán","tsunami","volcán","lava","cráter","glaciar","desierto","jungla","pradera",
  "océano","laguna","charco","acantilado","molino","fábrica","mercado","supermercado","tienda","estación",
  "hotel","restaurante","hospital","iglesia","templo","museo","estadio","cancha","piscina","parque",
  "jardín","carnaval","fiesta","bandera","soldado","escudo","lanza","batalla","ejército","aviador",
  "capitán","teniente","marinero","cocinero","pintor","cartero","bombero","policía","científico","profesor",

  // 301 - 400
  "estudiante","médico","enfermero","ingeniero","mecánico","panadero","pescador","cazador","arquero","pastor",
  "alcalde","rey","reina","príncipe","princesa","emperador","barbero","fontanero","torero","carnicero",
  "payaso","diseñador","programador","jugador","atleta","boxeador","piloto","actor","cantante","autor",
  "editor","fotógrafo","reportero","periodista","vendedor","jardinero","carpintero","electricista","minero","pastelero",
  "cajero","taxista","conductor","juez","abogado","notario","guía","inventor","constructor","capataz",
  "granadero","mayordomo","mensajero","guardia","vigilante","explorador","geólogo","astrónomo","biólogo","matemático",
  "filósofo","arqueólogo","pastel","espinaca","almendra","avena","harina","maíz","yogur","mantequilla",
  "aceite","vinagre","sal","azúcar","pimienta","mostaza","miel","mermelada","chocolate","vainilla",

  // 401 - 500
  "caramelo","dulce","tarta","empanada","pizza","hamburguesa","sopa","ensalada","arroz","pasta",
  "cereal","tortilla","quesadilla","burrito","café","té","jugo","refresco","agua","leche",
  "ventilador","generador","batería","enchufe","interruptor","foco","linterna","circuito","motor","tubería",
  "llanta","volante","asiento","cinturón","parabrisas","maletero","tobogán","columpio","resbaladilla","hamaca",
  "carpas","linterna","brújula","cantimplora","antorcha","bandchaleco","botiquín","soga","machete","parrilla",
  "hoguera","carbón","púa","claxon","sirena","alarma","sensor","timbre","candado","cerradura",
  "cerrillo","cerilla","fosforo","piedrita","tela","hilo","aguja","costura","lazo","cinta",
  "botón","cremallera","bolsillo","collar","anillo","pulsera","arete","sombrilla","paraguas","maleta",

  // 501 - 600
  "agenda","cuaderno","lápiz","lapicera","borrador","regla","tijera","compás","marcador","resaltador",
  "carpeta","libreta","papiro","pergamino","pluma","tinta","hoja","papel","cartón","cartulina",
  "sobre","sello","estampilla","correo","paquete","carta","mensaje","pantalla","monitor","teclado",
  "ratón","impresora","escáner","archivo","carpeta","servidor","red","router","cableado","sistema",
  "programa","aplicación","mensaje","contraseña","usuario","ventana","icono","cursor","pestaña","toolbar",
  "navegador","página","enlace","descarga","subida","almacenamiento","memoria","procesador","chip","tarjeta",
  "bocina","auricular","micrófono","control","mando","joystick","consola","pantalla","proyector","drone",

  // 601 - 700
  "baranda","escalera","ascensor","pasillo","techo","suelo","alféizar","balcón","terraza","jardín",
  "cortina","persiana","estante","librero","butaca","sofá","sillón","cajón","armario","ropero",
  "estufa","refrigerador","congelador","lavaplatos","freidora","licuadora","batidora","plancha","secadora","radiador",
  "calentador","ventana","marco","puerta","manija","cerrojo","pasador","candelabro","vela","incienso",
  "brasero","cenicero","cuenco","tazón","jarra","botellón","cántaro","cubeta","cubierto","vajilla",
  "escalpelo","pinza","estetoscopio","termómetro","jeringa","inyección","medicina","curita","vendas","alcohol",
  "gasa","suero","pastilla","tableta","vitamina","pomada","antibiótico","vacuna","botiquín","quirófano",

  // 701 - 800
  "ambulancia","camilla","silla","andador","bastón","muleta","tobillera","cabestrillo","cirujano","terapeuta",
  "paciente","clínica","laboratorio","microscopio","centrífuga","pipeta","bisturí","placa","radiografía","láser",
  "túrmix","compresor","válvula","tuerca","pluma","alicates","llave inglesa","soplete","taladro","caldera",
  "bomba","turbina","hélice","polea","engranaje","tornillo","resorte","muelle","arnés","gancho",
  "remache","sierra","serrucho","formón","escarpelo","destornillador","limadora","prensa","soldador","yunque",
  "bigote","barba","trenza","coleta","peinado","perfume","loción","crema","jabón","toallita",
  "cepillo","peine","brocha","esmalte","maquillaje","rimel","labial","sombra","rímel","mascarilla",

  // 801 - 900
  "cubrebocas","casco","chaleco","guantes","botas","sandalias","tenis","zapatilla","pijama","bata",
  "traje","uniforme","kimono","túnica","armadura","yelmo","escudo","lanza","arco","flecha",
  "cetro","cáliz","reliquia","manuscrito","biblioteca","archivo","museo","galería","exposición","teatro",
  "auditorio","salón","cabina","estudio","plató","escenario","foro","camerino","vestuario","decorado",
  "cortina","telón","reflector","micrófono","altavoz","amplificador","mezcladora","bocina","subwoofer","trípode",
  "cámara","drone","lente","filtro","trípode","estabilizador","grabadora","tarjeta","memoria","batería",

  // 901 - 1000
  "motor","compás","brújula","mapa","globo","atlas","frontera","país","ciudad","pueblo",
  "aldea","región","continente","planeta","estrella","constelación","galaxia","universo","vórtice","dimensión",
  "puerta","portal","laberinto","mazmorra","fortaleza","torre","muralla","puente","foso","patio",
  "jardín","estanque","fuente","cascada","acantilado","cueva","gruta","caverna","túnel","mina",
  "puerto","muelle","barco","velero","góndola","canoa","bote","lancha","catamarán","submarino",
  "radar","sonar","radio","brújula","antena","señal","torreta","panel","pantalla","terminal"
];
