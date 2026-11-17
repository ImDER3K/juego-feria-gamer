
import processing.event.*;


final int ANCHO = 1080;
final int ALTO = 600;

final int MENU = 0;
final int CINEMATICA = 1;
final int EXPLORACION = 2;
final int DIALOGO = 3;
final int MINIJUEGO = 4;
final int PAUSA = 5;
final int FINAL = 6;
final int INTRO = 7;
final int CAMBIO_DIA = 8;
final int REGISTRO = 9;

int estadoActual = MENU;

// ---------------- IMAGENES ----------------

PImage fondoMenu;
PImage mapa;
PImage colisiones;

boolean recursosListos = false;
boolean errorRecursos = false;

// ---------------- POPUP DE CONTROLES ----------------

PImage imgControles;
boolean mostrandoControles = false;

// ---------------- IMAGEN DE REGISTRO ----------------

PImage imgRegistro;

// ---------------- CINEMATICAS DE CAMBIO DE DIA ----------------

PImage imgDiaTerminado;
PImage imgPasoDeDia;
PImage imgInicioDia;

// Fase de la transicion entre dias:
// 0 = dia terminado, 1 = paso de dia, 2 = inicio de dia.
int faseCambioDia = 0;

// Los tres arreglos tienen el mismo orden: feliz, neutro y triste.
String[] archivosFinal = {"finbueno.jpg", "finregular.png", "finmalo.jpg"};
String[] titulosFinal = {"Final bueno", "Final regular", "Final malo"};
String[] relatosFinal = {
  "El celular quedó en silencio. Por fin dormiste de corrido después del parcial.",
  "Todavía queda una tarea. Pones el celular boca abajo y vuelves al cuaderno.",
  "Dijiste «un minuto más». Cuando miraste por la ventana, ya casi amanecía."
};
int finalElegido = 0;
PImage imagenDesenlace;
boolean viendoDesenlace = false;
int inicioDesenlace;

// ---------------- JUGADOR ----------------

float jugadorX;
float jugadorY;

float destinoX;
float destinoY;

float velocidad = 3.5;

boolean moviendo = false;

// ---------------- CONTROLES WASD ----------------

boolean teclaW = false;
boolean teclaA = false;
boolean teclaS = false;
boolean teclaD = false;

// ---------------- CAMARA ----------------

float zoomActual = 1.0;
float zoomInicial = 1.0;
float zoomFinal = 1.5;

int tiempoCinematica;
int duracionCinematica = 2500;

// ---------------- PUNTOS DEL MAPA ----------------

float[] puntosX = new float[5];
float[] puntosY = new float[5];

String[] nombresPuntos = {
  "Fuente",
  "Biblioteca",
  "Cafeteria",
  "Salon",
  "Zona deportiva"
};

// ---------------- NIEBLA DE GUERRA ----------------

int tamanoCelda = 16;

int columnasNiebla;
int filasNiebla;

boolean[][] mapaDescubierto;

float radioDescubrimiento = 120;

// ---------------- INTERFAZ ----------------

boolean mostrarColisiones = false;

int diaActual = 1;
float horasRestantes = 8;

// ---------------- INTRODUCCION Y RELOJ ----------------

PImage[] fotogramasIntro = new PImage[146];

final int DURACION_FOTOGRAMA = 100;
final int DURACION_INTRO = 146 * DURACION_FOTOGRAMA;
final int DURACION_CAMBIO_DIA = 2000;
final int MINUTOS_POR_DIA = 480;
final int DIAS_TOTALES = 7;
final float MINUTOS_POR_SEGUNDO = 7;

int ultimaLectura;
int tiempoActivo = 0;
int tiempoIntro = 0;
int tiempoCambioDia = 0;

float minutosJornada = 0;

// ---------------- FECHA Y HORA SIMULADA ----------------
// La jornada NO usa el reloj real: siempre empieza a las 08:00
// y dura MINUTOS_POR_DIA (8 horas), o sea termina a las 16:00.

final int HORA_INICIO_SIM = 8;
final int MINUTO_INICIO_SIM = 0;

// Lugar donde aparece el jugador al despertar cada dia.
final int DESPERTAR_X = 1482;
final int DESPERTAR_Y = 622;

// Una fecha/hora registrada por cada dia de juego.
String[] fechasJuego = new String[DIAS_TOTALES];
String[] horasInicioJuego = new String[DIAS_TOTALES];
String[] horasFinJuego = new String[DIAS_TOTALES];

// ---------------- ESTRÉS Y ÁNIMO ----------------
// Los sprites de animo son el medidor de estres.
PImage imgFeliz;
PImage imgNeutro;
PImage imgTriste;

float estres = 0; // de 0 a 100

// ---------------- LOGROS ----------------
final int TOTAL_LOGROS = 6;

boolean[] logros = new boolean[TOTAL_LOGROS];

String[] nombresLogros = {
  "Primeros pasos",
  "Primer día superado",
  "Explorador del campus",
  "Caminante",
  "Semana completa",
  "Decidido"
};

String[] descripcionesLogros = {
  "Iniciaste tu primera jornada.",
  "Completaste el Día 1.",
  "Visitaste los 5 puntos del mapa.",
  "Caminaste 3000 unidades.",
  "Sobreviviste las 7 jornadas.",
  "Tomaste las 7 decisiones diarias."
};

float distanciaRecorrida = 0;
boolean[] puntosVisitados = new boolean[5];

String mensajeLogro = "";
int tiempoMensajeLogro = 0;

// ---------------- DECISIONES DIARIAS ----------------
// Cada opcion tiene un valor de estres (porcentaje).
// El estres total es la suma de todas las acciones elegidas.

boolean decisionActiva = false;
int diaDecision = 0;       // ultimo dia en que ya se decidio
int accionesTotales = 0;   // cuantas decisiones se han tomado
float estresTotal = 0;     // suma acumulada de los valores

String[] opcionesDecision = {
  "Usar redes sociales",
  "Estudiar y hacer tarea",
  "Dormir temprano"
};

float[] valoresEstres = { 20, 5, -10 };

String[] efectosDecision = {
  "+20% estrés",
  "+5% estrés",
  "-10% estrés"
};

// ---------------- CELULAR ----------------
// El celular cerrado va abajo a la izquierda.
// Cambia entre apagado y con notificacion, y se puede abrir.

PImage imgCelular;
PImage imgCelularOff;
PImage imgCelularNoti;

boolean telefonoAbierto = false;
boolean hayNotificacion = false;
String mensajeNotificacion = "Sin notificaciones.";

///imagenes de los cuatro tipos de aviso o notis.

PImage[] spritesAvisos = new  PImage[4];
String[] nombreAvisos = {
  "wajap","Itagram", "Auraspace", "Cámara"
};

// las apps dentro de el cel

PImage[] iconosApps = new PImage[6];

//vamos a guardar el tipo de cada noti pendiente osea si 0 significa wajap y 1 itagram

int [] bandeja = new int[50];
int pendientes = 0;

//tiempo en salir las notis 

int minimoNoti = 6000;
int maximoNoti = 10000;
int intervaloNoti = 6000;
int esperaNoti = 0;

//tiempo notis en el medio 
int relojNoti = 0;
int finAvisoCentral = 0;
int tipoAvisoCetral = 0;



// Caja del celular cerrado en pantalla.
final float TELEFONO_X = 20;
final float TELEFONO_MARGEN = 20;
final float TELEFONO_ANCHO = 180;
final float TELEFONO_ALTO = 200;

int estadoAntesDePausa = EXPLORACION;
boolean partidaEnCurso = false;

int panelMenu = 0;
String detalleError = "";

// ---------------- BATALLA POR LA ATENCIÓN (GRUPO 10) ----------------
// Cada día hay tres avisos. El reloj activo ya sabe detenerse durante la pausa.
final int AVISOS_POR_DIA = 3;
int avisosDelDia = 0;
int bloqueos = 0;
int distracciones = 0;
int concentracion = 70;
int inicioAviso = 0;
boolean retoIniciado = false;
String resultadoAviso = "";

// ---------------- VARIABLES DE REGISTRO ----------------
// Solo pedimos el nombre del jugador.
String nombre = "";

// Aviso de error mostrado en pantalla durante el registro
String mensajeRegistro = "";

///////////////

void setup() {

  size(1080, 600, P2D);
  pixelDensity(1);

  surface.setTitle("Supervivencia Digital");

  cargarRecursos();

  if (recursosListos) {

    configurarNiebla();
    configurarPuntos();

    if (!iniciarJugador()) {
      errorRecursos = true;
      recursosListos = false;
    }
  }
}

// ==================================================
// CARGAR RECURSOS
// ==================================================

void cargarRecursos() {

  fondoMenu = loadImage("menu/fondo_menu.jpg");
  mapa = loadImage("mapas/mapa.png");
  colisiones = loadImage("mapas/colisiones1.png");

  if (fondoMenu == null) {
    println("ERROR: No se encontro fondo_menu.jpg");
    errorRecursos = true;
    return;
  }

  if (mapa == null) {
    println("ERROR: No se encontro mapa.png");
    errorRecursos = true;
    return;
  }

  if (colisiones == null) {
    println("ERROR: No se encontro colisiones.png");
    println("Comprueba el nombre y la extension del archivo.");
    errorRecursos = true;
    return;
  }

  // Cargar popup de controles
  imgControles = loadImage("interfaz/controles.png");
  if (imgControles == null) {
    println("ERROR: No se encontro controles.png");
    errorRecursos = true;
    return;
  }

  // Cargar imagen de fondo del registro
  imgRegistro = loadImage("interfaz/registro.png");
  if (imgRegistro == null) {
    println("ERROR: No se encontro registro.png");
    errorRecursos = true;
    return;
  }

  // Cargar sprites de animo (medidor de estres)
  imgFeliz = loadImage("interfaz/feliz.png");
  imgNeutro = loadImage("interfaz/neutro.png");
  imgTriste = loadImage("interfaz/triste.png");

  if (imgFeliz == null || imgNeutro == null || imgTriste == null) {
    detalleError = "Faltan imagenes de animo en data/interfaz/";
    println(detalleError);
    errorRecursos = true;
    return;
  }

  // Cargar imagenes del celular
  imgCelular = loadImage("interfaz/celular.png");
  imgCelularOff = loadImage("interfaz/celularoff.png");
  imgCelularNoti = loadImage("interfaz/celularnoti.png");

  if (imgCelular == null || imgCelularOff == null || imgCelularNoti == null) {
    detalleError = "Faltan imagenes del celular en data/interfaz/";
    println(detalleError);
    errorRecursos = true;
    return;
  }

  mapa.loadPixels();
  colisiones.loadPixels();

  println("--------------------------------");
  println("MAPA: " + mapa.width + " x " + mapa.height);
  println("COLISIONES: " + colisiones.width + " x " + colisiones.height);
  println("--------------------------------");

  if (mapa.width != colisiones.width ||
      mapa.height != colisiones.height) {

    println("ERROR: Las dimensiones no coinciden.");
    println("Mapa y colisiones deben tener el mismo tamaño.");

    errorRecursos = true;
    return;
  }

  for (int i = 0; i < fotogramasIntro.length; i++) {

    String ruta = "cinematicas/intro/intro_" +
                   nf(i + 1, 3) + ".png";

    fotogramasIntro[i] = loadImage(ruta);

    if (fotogramasIntro[i] == null) {
      detalleError = "Falta data/" + ruta;
      println(detalleError);
      errorRecursos = true;
      return;
    }
  }

  // Cargar imagenes de la transicion entre dias
  imgDiaTerminado = loadImage("cinematicas/diaterminado.jpg");
  imgPasoDeDia = loadImage("cinematicas/pasodedia.jpg");
  imgInicioDia = loadImage("cinematicas/iniciodia.jpg");

  if (imgDiaTerminado == null ||
      imgPasoDeDia == null ||
      imgInicioDia == null) {

    detalleError = "Faltan imagenes en data/cinematicas/";
    println(detalleError);
    errorRecursos = true;
    return;
  }
 
  spritesAvisos[0] = loadImage("interfaz/wajapnoti.png");
  spritesAvisos[1] = loadImage("interfaz/itagramnoti");
  spritesAvisos[2] = loadImage("interfaz/auraspacenoti.png");
  spritesAvisos[3] = loadImage("interfaz/camaranoti");
  
  iconosApps[0] = loadImage("interfaz/wajap.png");
  iconosApps[1] = loadImage("interfaz/itagram");
  iconosApps[2] = loadImage("interfaz/auraspace.png");
  iconosApps[3] = loadImage("interfaz/camara.png");
  iconosApps[4] = loadImage("interfaz/noti.png");
  iconosApps[5] = loadImage("interfaz/tito.png");
  

// aqui muestra el mensaje de error si no encuentra la imagen antes de  iniciar 

for (int i = 0; i < spritesAvisos.length; i++) {
  if (spritesAvisos[i] == null) {
  detalleError = "Falta un sprite de aviso de " + nombreAvisos[i];
  errorRecursos = true;
  return;
  }

}

for (int i = 0; i < spritesAvisos.length; i++) {
  if (iconosApps[i] == null) {
  detalleError = "Falta un sprite de aviso de los iconos en el cel" ;
  errorRecursos = true;
  return;
  }

}
   
  recursosListos = true;
}

// ==================================================
// CONFIGURAR PUNTOS
// ==================================================

void configurarPuntos() {

  puntosX[0] = mapa.width * 0.50;
  puntosY[0] = mapa.height * 0.30;

  puntosX[1] = mapa.width * 0.25;
  puntosY[1] = mapa.height * 0.45;

  puntosX[2] = mapa.width * 0.70;
  puntosY[2] = mapa.height * 0.45;

  puntosX[3] = mapa.width * 0.45;
  puntosY[3] = mapa.height * 0.70;

  puntosX[4] = mapa.width * 0.75;
  puntosY[4] = mapa.height * 0.75;
}

// ==================================================
// CONFIGURAR NIEBLA
// ==================================================

void configurarNiebla() {

  columnasNiebla = ceil(mapa.width / (float)tamanoCelda);
  filasNiebla = ceil(mapa.height / (float)tamanoCelda);

  mapaDescubierto = new boolean[columnasNiebla][filasNiebla];

  for (int x = 0; x < columnasNiebla; x++) {

    for (int y = 0; y < filasNiebla; y++) {

      mapaDescubierto[x][y] = false;
    }
  }
}


boolean iniciarJugador() {

  int mejorX = -1;
  int mejorY = -1;

  float menorDistancia = Float.MAX_VALUE;

  float centroX = mapa.width / 2.0;
  float centroY = mapa.height / 2.0;

  for (int y = 6; y < colisiones.height - 6; y++) {

    for (int x = 6; x < colisiones.width - 6; x++) {

      if (!esPixelVerde(x, y)) {
        continue;
      }

      boolean espacioValido = true;

      for (int dy = -5; dy <= 5; dy++) {

        for (int dx = -5; dx <= 5; dx++) {

          if (!esPixelVerde(x + dx, y + dy)) {
            espacioValido = false;
            break;
          }
        }

        if (!espacioValido) {
          break;
        }
      }

      if (espacioValido) {

        float distancia = dist(
          centroX,
          centroY,
          x,
          y
        );

        if (distancia < menorDistancia) {

          menorDistancia = distancia;

          mejorX = x;
          mejorY = y;
        }
      }
    }
  }

  if (mejorX == -1) {

    println("ERROR: No se encontro una zona verde suficientemente amplia.");
    return false;
  }

  jugadorX = mejorX;
  jugadorY = mejorY;

  destinoX = jugadorX;
  destinoY = jugadorY;

  moviendo = false;

  teclaW = false;
  teclaA = false;
  teclaS = false;
  teclaD = false;

  println("--------------------------------");
  println("JUGADOR INICIADO");
  println("X: " + jugadorX);
  println("Y: " + jugadorY);
  println("Pixel verde: " + esPixelVerde(mejorX, mejorY));
  println("--------------------------------");

  actualizarDescubrimiento();

  return true;
}

// ==================================================
// DETECTAR ZONAS TRANSITABLES
// ==================================================

boolean esPixelVerde(int px, int py) {

  if (px < 0 || py < 0 ||
      px >= colisiones.width ||
      py >= colisiones.height) {

    return false;
  }

  color c = colisiones.pixels[
    py * colisiones.width + px
  ];

  float r = red(c);
  float g = green(c);
  float b = blue(c);

  return r == 0 && g == 255 && b == 0;
}

// ==================================================
// COMPROBAR COLISION
// ==================================================

boolean esZonaVerde(float x, float y) {

  int px = round(x);
  int py = round(y);

  return esPixelVerde(px, py);
}

// ==================================================
// DRAW PRINCIPAL
// ==================================================

void draw() {

  actualizarTiempo();
  background(20);

  if (!recursosListos) {

    dibujarError();
    return;
  }

  // Si el popup de controles está activo, lo mostramos encima de todo
  if (mostrandoControles) {
    dibujarPopupControles();
    return;
  }

  switch(estadoActual) {

  case MENU:
    dibujarMenu();
    if (panelMenu != 0) dibujarInformacionMenu();
    break;

  case INTRO:
    dibujarIntro();
    break;

  case REGISTRO:
    dibujarRegistro();
    break;

  case CAMBIO_DIA:
    dibujarExploracion();
    dibujarCambioDia();
    break;

  case CINEMATICA:
    dibujarCinematica();
    break;

  case EXPLORACION:
    actualizarExploracion();
    dibujarExploracion();
    break;

  case DIALOGO:
    dibujarExploracion();
    dibujarDialogo();
    break;

  case MINIJUEGO:
    dibujarMinijuego();
    break;

  case PAUSA:
    dibujarFondoPausa();
    dibujarPausa();
    break;

  case FINAL:
    dibujarFinal();
    break;
  }
}

// ==================================================
// ERROR DE RECURSOS
// ==================================================

void dibujarError() {

  background(30);

  fill(255);
  textAlign(CENTER, CENTER);

  textSize(25);
  text("NO SE PUDIERON CARGAR LOS RECURSOS", width/2, 220);

  textSize(15);

  text(
    "Revisa la carpeta data y la consola de Processing.",
    width/2,
    270
  );

  text(
    detalleError.length() > 0 ?
    detalleError :
    "Necesitas mapa.png y colisiones.png del mismo tamaño.",
    width/2,
    300
  );
}

// ==================================================
// MENU
// ==================================================

void dibujarMenu() {

  imageMode(CORNER);
  image(fondoMenu, 0, 0, width, height);

  fill(255);
  textAlign(LEFT, CENTER);

  textSize(40);
  text("SUPERVIVENCIA", 55, 90);
  text("DIGITAL", 55, 135);
  textSize(19);
  text("Batalla por la Atención", 55, 177);

  dibujarBoton("JUGAR", 55, 230, 230, 48);
  dibujarBoton("CONTINUAR", 55, 290, 230, 48);
  dibujarBoton("COMO JUGAR", 55, 350, 230, 48);
  dibujarBoton("CREDITOS", 55, 410, 230, 48);
  dibujarBoton("SALIR", 55, 470, 230, 48);

  // Mostrar popup de controles si está activo
  if (mostrandoControles) {
    dibujarPopupControles();
  }
}

void dibujarPopupControles() {

  // Fondo oscuro semitransparente

  noStroke();
  fill(0, 200);
  rect(0, 0, width, height);

  // Dibujar imagen del popup centrada

  imageMode(CENTER);

  if (imgControles != null) {

    float w = imgControles.width;
    float h = imgControles.height;

    // Escalar si es demasiado grande para la pantalla

    float escala = min((float)width / w, (float)height / h);

    w *= escala;
    h *= escala;

    image(imgControles, width / 2, height / 2, w, h);
  }

  // Texto de ayuda para cerrar

  fill(255);
  textAlign(CENTER, CENTER);
  textSize(16);
  text("Presiona ESPACIO o ENTER para cerrar", width / 2, height - 50);
}

// ==================================================
// BOTONES
// ==================================================

void dibujarBoton(String texto, float x, float y, float w, float h) {

  boolean encima =
    mouseX >= x &&
    mouseX <= x + w &&
    mouseY >= y &&
    mouseY <= y + h;

  if (encima) {
    fill(80, 220, 140);
  } else {
    fill(35, 35, 45, 230);
  }

  stroke(255);
  strokeWeight(2);

  rect(x, y, w, h, 12);

  noStroke();
  fill(255);

  textAlign(CENTER, CENTER);
  textSize(18);

  text(texto, x + w/2, y + h/2);
}

// ==================================================
// CINEMATICA
// ==================================================

void iniciarCinematica() {

  estadoActual = CINEMATICA;

  tiempoCinematica = tiempoActivo;

  zoomActual = zoomInicial;
}

void dibujarCinematica() {

  float progreso = constrain(
    (tiempoActivo - tiempoCinematica) /
    (float)duracionCinematica,
    0,
    1
  );

  float suavizado = progreso * progreso * (3 - 2 * progreso);

  zoomActual = lerp(
    zoomInicial,
    zoomFinal,
    suavizado
  );

  dibujarMapa();

  fill(255);
  textAlign(CENTER, CENTER);
  textSize(20);

  text("Preparando el campus...", width/2, height - 45);
}

// ==================================================
// EXPLORACION
// ==================================================

void actualizarExploracion() {

  // Si hay una decision pendiente, el jugador no se mueve.
  if (decisionActiva) {
    return;
  }

  // Si el celular esta abierto, el jugador no se mueve.
  if (telefonoAbierto) {
    return;
  }

  // Abrir la decision del dia si aun no se tomo.
  if (diaDecision != diaActual) {
    decisionActiva = true;
    hayNotificacion = true;
    mensajeNotificacion = "Decisión pendiente: Día " + diaActual;
    println("DECISION PENDIENTE: Dia " + diaActual);
    return;
  }

  float antX = jugadorX;
  float antY = jugadorY;

  moverJugador();

  distanciaRecorrida += dist(antX, antY, jugadorX, jugadorY);

  if (distanciaRecorrida >= 3000) {
    desbloquearLogro(3);
  }

  actualizarDescubrimiento();
  actualizarLogrosPuntos();
}

void dibujarExploracion() {

  dibujarMapa();

  dibujarHUD();
  dibujarAnimo();

  if (mostrarColisiones) {
    dibujarMascaraDepuracion();
  }

  dibujarTelefono();

  if (decisionActiva) {
    dibujarDecision();
  }

  dibujarMensajeLogro();
  dibujarAvisoCentral();
}

// ==================================================
// DIBUJAR MAPA Y CAMARA
// ==================================================

void dibujarMapa() {

  pushMatrix();

  translate(width/2, height/2);

  scale(zoomActual);

  imageMode(CORNER);

  image(
    mapa,
    -jugadorX,
    -jugadorY
  );

  dibujarNiebla();

  dibujarPuntos();

  popMatrix();

  dibujarJugador();
}

// ==================================================
// DIBUJAR JUGADOR
// ==================================================

void dibujarJugador() {

  float centroX = width/2;
  float centroY = height/2;

  noStroke();

  fill(0, 100);

  ellipse(
    centroX,
    centroY + 9,
    25,
    12
  );

  fill(255, 190, 50);

  ellipse(
    centroX,
    centroY,
    25,
    25
  );

  fill(255);

  ellipse(
    centroX,
    centroY,
    9,
    9
  );

  noFill();
  stroke(30);
  strokeWeight(2);

  ellipse(
    centroX,
    centroY,
    25,
    25
  );

  noStroke();
}

// ==================================================
// MOVIMIENTO DEL JUGADOR CON WASD
// ==================================================

void moverJugador() {

  float dx = 0;
  float dy = 0;

  // Detectar teclas

  if (teclaW) dy--;
  if (teclaS) dy++;
  if (teclaA) dx--;
  if (teclaD) dx++;

  moviendo = (dx != 0 || dy != 0);

  if (!moviendo) {
    return;
  }

  // Mantener la misma velocidad en diagonal

  float distancia = sqrt(dx * dx + dy * dy);

  dx = dx / distancia * velocidad;
  dy = dy / distancia * velocidad;

  // Dividir el movimiento en pasos pequeños
  // para no saltar por encima de zonas negras.

  int pasos = ceil(velocidad);

  for (int i = 0; i < pasos; i++) {

    float pasoX = dx / pasos;
    float pasoY = dy / pasos;

    // Movimiento horizontal

    if (esZonaVerde(jugadorX + pasoX, jugadorY)) {
      jugadorX += pasoX;
    }

    // Movimiento vertical

    if (esZonaVerde(jugadorX, jugadorY + pasoY)) {
      jugadorY += pasoY;
    }
  }
}

// ==================================================
// NIEBLA DE GUERRA
// ==================================================

void actualizarDescubrimiento() {

  int centroCeldaX = int(jugadorX / tamanoCelda);
  int centroCeldaY = int(jugadorY / tamanoCelda);

  int rango = ceil(radioDescubrimiento / tamanoCelda);

  for (int x = centroCeldaX - rango;
       x <= centroCeldaX + rango;
       x++) {

    for (int y = centroCeldaY - rango;
         y <= centroCeldaY + rango;
         y++) {

      if (x < 0 || y < 0 ||
          x >= columnasNiebla ||
          y >= filasNiebla) {

        continue;
      }

      float mundoX = x * tamanoCelda + tamanoCelda/2;
      float mundoY = y * tamanoCelda + tamanoCelda/2;

      float distancia = dist(
        jugadorX,
        jugadorY,
        mundoX,
        mundoY
      );

      if (distancia <= radioDescubrimiento) {
        mapaDescubierto[x][y] = true;
      }
    }
  }
}

void dibujarNiebla() {

  noStroke();

  fill(0, 225);

  for (int x = 0; x < columnasNiebla; x++) {

    for (int y = 0; y < filasNiebla; y++) {

      if (!mapaDescubierto[x][y]) {

        rect(
          x * tamanoCelda - jugadorX,
          y * tamanoCelda - jugadorY,
          tamanoCelda + 1,
          tamanoCelda + 1
        );
      }
    }
  }
}

// ==================================================
// PUNTOS DE INTERES
// ==================================================

void dibujarPuntos() {

  textAlign(CENTER, CENTER);
  textSize(12);

  for (int i = 0; i < puntosX.length; i++) {

    float px = puntosX[i] - jugadorX;
    float py = puntosY[i] - jugadorY;

    fill(255, 220, 80);
    noStroke();

    ellipse(px, py, 14, 14);

    fill(255);

    text(
      nombresPuntos[i],
      px,
      py - 17
    );
  }
}

// ==================================================
// HUD
// ==================================================

void dibujarHUD() {

  noStroke();
  fill(20, 20, 30, 220);

  rect(0, 0, width, 65);

  fill(255);

  textAlign(LEFT, CENTER);

  textSize(18);
  text("FECHA: " + fechaDelDiaActual() + " / " + DIAS_TOTALES, 25, 25);
  textSize(14);
  text("Nivel " + nivelAtencion() + "  ·  Concentración " + concentracion + "%", 375, 19);
  // La parte llena de la barra representa la fracción de semana transcurrida.
  float progresoSemana = (diaActual - 1 + constrain(minutosJornada / MINUTOS_POR_DIA, 0, 1)) / DIAS_TOTALES;
  fill(55, 75, 80);
  rect(375, 31, 205, 6);
  fill(90, 222, 165);
  rect(375, 31, 205 * progresoSemana, 6);
  fill(255);

  textSize(14);

  int minutosVisibles = int(min(minutosJornada, MINUTOS_POR_DIA));

  int hora = HORA_INICIO_SIM + minutosVisibles / 60;
  int minuto = minutosVisibles % 60;

  text(
    "Inicio " + horaInicioDelDia() +
    "  -  Salida " + horaFinDelDia() +
    "  |  Ahora " + nf(hora, 2) + ":" + nf(minuto, 2) +
    "  |  " + nf(horasRestantes, 1, 1) + " h restantes",
    25,
    47
  );

  textAlign(RIGHT, CENTER);

  text(
    "X: " + int(jugadorX) + "   Y: " + int(jugadorY),
    width - 25,
    25
  );

  text(
    "WASD: moverte | ESC: pausar | M: ver colisiones",
    width - 25,
    47
  );
}

// ==================================================
// VISUALIZAR MASCARA DE COLISIONES
// ==================================================

void dibujarMascaraDepuracion() {

  pushMatrix();

  translate(width/2, height/2);

  scale(zoomActual);

  tint(255, 120);

  image(
    colisiones,
    -jugadorX,
    -jugadorY
  );

  noTint();

  popMatrix();

  fill(0, 200);
  noStroke();

  rect(15, 80, 260, 75, 8);

  fill(255);
  textAlign(LEFT, CENTER);
  textSize(13);

  text(
    "Jugador: " + int(jugadorX) + ", " + int(jugadorY),
    25,
    100
  );

  text(
    "Zona verde: " + esZonaVerde(jugadorX, jugadorY),
    25,
    120
  );

  color c = colisiones.pixels[
    round(jugadorY) * colisiones.width + round(jugadorX)
  ];

  text(
    "RGB: " + int(red(c)) + ", " +
    int(green(c)) + ", " + int(blue(c)),
    25,
    140
  );
}

// ==================================================
// DIALOGO
// ==================================================

void dibujarDialogo() {

  noStroke();
  fill(0, 220);

  rect(0, height - 150, width, 150);

  fill(255);
  textAlign(LEFT, CENTER);

  textSize(20);
  text("Un compañero quiere hablar contigo...", 40, height - 100);

  textSize(14);
  text("Presiona ENTER para continuar.", 40, height - 60);
}

// ==================================================
// MINIJUEGO
// ==================================================

// Los días 1 y 2 enseñan el ritmo. Desde los días 3 y 6 hay menos tiempo.
int nivelAtencion() {
  if (diaActual <= 2) return 1;
  if (diaActual <= 5) return 2;
  return 3;
}

String nombreNivelAtencion() {
  switch (nivelAtencion()) {
    case 1: return "Principiante Digital";
    case 2: return "Usuario Frecuente";
    default: return "Experto Digital";
  }
}

int duracionAviso() {
  if (nivelAtencion() == 1) return 3000;
  if (nivelAtencion() == 2) return 2400;
  return 1800;
}

void dibujarMinijuego() {
  background(19, 33, 48);
  noStroke();
  fill(31, 53, 70);
  rect(85, 60, width-170, height-120, 14);
  textAlign(CENTER, CENTER);
  fill(138, 230, 198);
  textSize(16);
  text("DÍA " + diaActual + "    /    NIVEL " + nivelAtencion() + " · " + nombreNivelAtencion(), width/2, 101);
  fill(255);
  textSize(32);
  text("El Señor de las Notificaciones", width/2, 164);
  textSize(19);
  if (!retoIniciado) {
    text("Llegan tres avisos mientras intentas estudiar.", width/2, 238);
    text("Pulsa ESPACIO cuando el aviso entre en la franja verde.", width/2, 290);
    text("ENTER para empezar", width/2, 390);
  } else if (avisosDelDia == AVISOS_POR_DIA) {
    text(resultadoAviso, width/2, 235);
    text("Concentración al volver a clase: " + concentracion + " / 100", width/2, 300);
    text("ENTER para volver al campus", width/2, 390);
  } else {
    text("Aviso " + (avisosDelDia + 1) + " de " + AVISOS_POR_DIA, width/2, 229);
    // El recorrido va de x=240 a x=840. El verde ocupa del 50% al 80%.
    float avance = constrain((tiempoActivo - inicioAviso) / (float)duracionAviso(), 0, 1);
    fill(14, 25, 37);
    rect(240, 300, 600, 25);
    fill(66, 195, 146);
    rect(540, 300, 180, 25);
    float x = 240 + 600 * avance;
    fill(255, 205, 87);
    rect(x-14, 291, 28, 42, 5);
    fill(23, 35, 45);
    text("!", x, 310);
    fill(255);
    text("ESPACIO para silenciar", width/2, 377);
    text(resultadoAviso, width/2, 415);
  }
  fill(190, 216, 224);
  textSize(16);
  text("Concentración " + concentracion + " / 100     |     ESC para pausar", width/2, 485);
}

void resolverAviso(boolean bloqueo) {
  if (bloqueo) {
    bloqueos++;
    concentracion = min(100, concentracion + 5);
    resultadoAviso = "Silenciado a tiempo. +5 de concentración.";
  } else {
    distracciones++;
    concentracion = max(0, concentracion - 8);
    resultadoAviso = "Perdiste el hilo. -8 de concentración.";
  }
  avisosDelDia++;
  inicioAviso = tiempoActivo;
}

void teclaBatalla() {
  if (keyEvent != null && keyEvent.isAutoRepeat()) return;
  if (key == ENTER || key == RETURN) {
    if (!retoIniciado) {
      retoIniciado = true;
      inicioAviso = tiempoActivo;
    } else if (avisosDelDia == AVISOS_POR_DIA) {
      estadoActual = EXPLORACION;
    }
  } else if (key == ' ' && retoIniciado && avisosDelDia < AVISOS_POR_DIA) {
    int t = tiempoActivo - inicioAviso;
    resolverAviso(t >= duracionAviso()/2 && t <= duracionAviso()*8/10);
  }
}

// ==================================================
// PAUSA
// ==================================================

void dibujarPausa() {

  noStroke();
  fill(0, 190);

  rect(0, 0, width, height);

  fill(255);
  textAlign(CENTER, CENTER);

  textSize(38);
  text("PAUSA", width/2, 190);

  dibujarBoton("CONTINUAR", width/2 - 115, 250, 230, 45);
  dibujarBoton("VOLVER AL MENU", width/2 - 115, 310, 230, 45);
}

// ==================================================
// LOGROS, ESTRÉS Y DECISIONES
// ==================================================

void desbloquearLogro(int i) {

  if (i < 0 || i >= TOTAL_LOGROS) return;
  if (logros[i]) return;

  logros[i] = true;
  mensajeLogro = nombresLogros[i];
  tiempoMensajeLogro = millis();

  // El celular avisa que hay un logro nuevo.
  hayNotificacion = true;
  mensajeNotificacion = "Logro: " + nombresLogros[i];

  println("LOGRO DESBLOQUEADO: " + nombresLogros[i]);
}

void dibujarMensajeLogro() {

  if (mensajeLogro.length() == 0) return;
  if (millis() - tiempoMensajeLogro > 3000) return;

  noStroke();
  fill(20, 20, 30, 220);
  rect(width/2 - 240, 75, 480, 45, 8);

  fill(255, 220, 80);
  textAlign(CENTER, CENTER);
  textSize(16);
  text("LOGRO DESBLOQUEADO: " + mensajeLogro, width/2, 97);
}

void dibujarAnimo() {

  PImage sprite = spriteAnimoActual();

  if (sprite == null) return;

  imageMode(CORNER);

  // Perfil de estados grande en la esquina superior derecha.
  float tam = 220;
  float x = width - tam - 30;
  float y = 80;

  // Tarjeta de fondo
  noStroke();
  fill(20, 20, 30, 200);
  rect(x - 12, y - 12, tam + 24, tam + 80, 14);

  // Sprite del estado
  dibujarSpriteCuadrado(sprite, x, y, tam);

  // Datos debajo del sprite
  fill(255);
  textAlign(CENTER, CENTER);

  textSize(15);
  text("Estrés: " + nivelEstresTexto() + " (" + int(estres) + "%)",
       x + tam/2, y + tam + 20);

  textSize(14);
  text("Acciones: " + accionesTotales,
       x + tam/2, y + tam + 44);
}

// Esta regla sirve tanto para la cara del HUD como para el final de la semana.
int indiceAnimo() {
  if (estres >= 60) return 2;
  if (estres >= 20) return 1;
  return 0;
}

String nivelEstresTexto() {
  int animo = indiceAnimo();
  if (animo == 2) return "Alto";
  if (animo == 1) return "Medio";
  return "Bajo";
}

PImage spriteAnimoActual() {
  int animo = indiceAnimo();
  if (animo == 2) return imgTriste;
  if (animo == 1) return imgNeutro;
  return imgFeliz;
}

// Dibuja un sprite dentro de un cuadrado sin deformar su proporcion.
void dibujarSpriteCuadrado(PImage img, float x, float y, float tam) {

  if (img == null) return;

  imageMode(CORNER);

  float escala = tam / max(img.width, img.height);
  float w = img.width * escala;
  float h = img.height * escala;

  image(img, x + (tam - w) / 2, y + (tam - h) / 2, w, h);
}

// ==================================================
// CELULAR
// ==================================================

void dibujarTelefono() {

  if (telefonoAbierto) {
    dibujarTelefonoAbierto();
    return;
  }

  PImage img = (pendientes > 0 || hayNotificacion)
    ? imgCelularNoti
    : imgCelularOff;

  if (img == null) return;

  float x = TELEFONO_X;
  float y = height - TELEFONO_ALTO - TELEFONO_MARGEN;

  dibujarImagenEnCaja(img, x, y, TELEFONO_ANCHO, TELEFONO_ALTO);
}

void dibujarTelefonoAbierto() {
  if (imgCelular == null) return;

  noStroke();
  fill(0, 170);
  rect(0, 0, width, height);

  float alto = height - 70;
  float ancho = alto * imgCelular.width / imgCelular.height;
  float x = width/2 - ancho/2 - 130;
  float y = 35;

  imageMode(CORNER);
  image(imgCelular, x, y, ancho, alto);

  // Seis apps distribuidas en dos columnas y tres filas.
  for (int i = 0; i < iconosApps.length; i++) {
    int columna = i % 2;
    int fila = i / 2;

    float appX = x + ancho * (0.26 + columna * 0.23);
    float appY = y + alto * (0.20 + fila * 0.16);

    dibujarImagenEnCaja(
      iconosApps[i],
      appX,
      appY,
      ancho * 0.20,
      alto * 0.14
    );
  }

  float panelX = x + ancho + 25;
  float panelW = width - panelX - 30;

  fill(10, 15, 25, 235);
  rect(panelX, 80, panelW, 440, 12);

  fill(255, 220, 80);
  textAlign(CENTER, CENTER);
  textSize(22);
  text("NOTIFICACIONES", panelX + panelW/2, 115);

  fill(255);
  textSize(17);
  text("Pendientes: " + pendientes, panelX + panelW/2, 155);

  if (pendientes > 0) {
    int tipo = bandeja[0];

    dibujarImagenEnCaja(
      spritesAvisos[tipo],
      panelX + 20,
      180,
      panelW - 40,
      165
    );

    dibujarBoton("RESPONDER", panelX + 20, 365, panelW - 40, 42);
    dibujarBoton("ELIMINAR", panelX + 20, 417, panelW - 40, 42);
  } else {
    text("Bandeja vacía", panelX + panelW/2, 260);
  }

  fill(255);
  textSize(15);
  text(
    "Estrés: " + int(estres) + "%",
    panelX + panelW/2,
    485
  );

  fill(190);
  textSize(13);
  text("C o ESC para cerrar", panelX + panelW/2, 505);
}
// Dibuja una imagen centrada dentro de una caja sin deformarla.
void dibujarImagenEnCaja(PImage img, float x, float y, float cajaW, float cajaH) {

  if (img == null) return;

  imageMode(CORNER);

  float escala = min(cajaW / img.width, cajaH / img.height);
  float w = img.width * escala;
  float h = img.height * escala;

  image(img, x + (cajaW - w) / 2, y + (cajaH - h) / 2, w, h);
}

boolean sobreTelefonoCerrado() {

  float x = TELEFONO_X;
  float y = height - TELEFONO_ALTO - TELEFONO_MARGEN;

  return mouseX >= x &&
         mouseX <= x + TELEFONO_ANCHO &&
         mouseY >= y &&
         mouseY <= y + TELEFONO_ALTO;
}

void actualizarLogrosPuntos() {

  boolean todos = true;

  for (int i = 0; i < puntosVisitados.length; i++) {

    if (dist(jugadorX, jugadorY, puntosX[i], puntosY[i]) < 150) {
      puntosVisitados[i] = true;
    }

    if (!puntosVisitados[i]) {
      todos = false;
    }
  }

  if (todos) {
    desbloquearLogro(2);
  }
}

int contarPuntosVisitados() {

  int c = 0;

  for (int i = 0; i < puntosVisitados.length; i++) {
    if (puntosVisitados[i]) c++;
  }

  return c;
}

int contarLogros() {
  int total = 0;
  int i = 0;

  // Mientras queden logros por revisar, contamos los que están desbloqueados.
  while (i < logros.length) {
    if (logros[i]) total++;
    i++;
  }
  return total;
}

void dibujarDecision() {

  noStroke();
  fill(10, 15, 25, 235);
  rect(0, 0, width, height);

  fill(255, 220, 80);
  textAlign(CENTER, CENTER);
  textSize(32);
  text("DECISIÓN DEL DÍA " + diaActual, width/2, 145);

  fill(255);
  textSize(18);
  text("¿Qué haces hoy?  (clic o teclas 1, 2, 3)", width/2, 182);

  textSize(15);
  text("Estrés actual: " + int(estres) + "%  (" + nivelEstresTexto() + ")" +
       "   |   Acciones: " + accionesTotales,
       width/2, 212);

  // Mostrar el sprite de animo actual para que el cambio sea visible.
  PImage spriteActual = spriteAnimoActual();

  if (spriteActual != null) {
    dibujarSpriteCuadrado(spriteActual, width - 120, 55, 64);
  }

  dibujarBoton(opcionesDecision[0] + "   " + efectosDecision[0],
               width/2 - 220, 250, 440, 50);

  dibujarBoton(opcionesDecision[1] + "   " + efectosDecision[1],
               width/2 - 220, 315, 440, 50);

  dibujarBoton(opcionesDecision[2] + "   " + efectosDecision[2],
               width/2 - 220, 380, 440, 50);

  fill(180);
  textSize(14);
  text("El estrés cambia según el total de tus acciones.", width/2, 470);
}

void aplicarDecision(int opcion) {

  if (!decisionActiva) return;
  if (opcion < 0 || opcion >= opcionesDecision.length) return;
  configuracionnotis(opcion);

  estresTotal += valoresEstres[opcion];
  estresTotal = constrain(estresTotal, 0, 100);
  estres = estresTotal;

  accionesTotales++;
  diaDecision = diaActual;
  decisionActiva = false;
  avisosDelDia = 0;
  retoIniciado = false;
  resultadoAviso = "";
  estadoActual = MINIJUEGO;

  println("DECISION: " + opcionesDecision[opcion] +
          " -> estres " + int(estres) + "%");

  // El celular muestra la decision tomada.
  hayNotificacion = true;
  mensajeNotificacion = "Decisión: " + opcionesDecision[opcion] +
                        " (" + efectosDecision[opcion] + ")";

  if (accionesTotales == 1) {
    desbloquearLogro(0);
  }

  if (accionesTotales >= DIAS_TOTALES) {
    desbloquearLogro(5);
  }
}

// ==================================================
// FINAL
// ==================================================

void iniciarDesenlace() {
  finalElegido = indiceAnimo();
  String ruta = "cinematicas/" + archivosFinal[finalElegido];
  imagenDesenlace = loadImage(ruta);
  if (imagenDesenlace == null) {
    println("Revisa la imagen del final: data/" + ruta);
    imagenDesenlace = spriteAnimoActual();
  }
  inicioDesenlace = millis();
  viendoDesenlace = true;
  estadoActual = FINAL;
}

void dibujarDesenlace() {
  background(16, 22, 36);
  // Acercamiento suave durante cuatro segundos. Luego la imagen espera al jugador.
  float avance = constrain((millis() - inicioDesenlace) / 4000.0, 0, 1);
  float zoom = 1 + 0.04 * avance;
  int altoEscena = height - 98;
  pushMatrix();
  translate(width/2, altoEscena/2);
  scale(zoom);
  dibujarImagenEnCaja(imagenDesenlace, -width/2, -altoEscena/2, width, altoEscena);
  popMatrix();

  noStroke();
  fill(16, 22, 36);
  rect(0, altoEscena, width, height - altoEscena);
  textAlign(LEFT, CENTER);
  fill(255, 220, 100);
  textSize(24);
  text(titulosFinal[finalElegido], 32, altoEscena + 28);
  fill(255);
  textSize(17);
  text(relatosFinal[finalElegido], 32, altoEscena + 66);
  dibujarBoton("Ver informe", width - 196, height - 76, 164, 42);
  textAlign(CENTER, CENTER);
  fill(190, 205, 218);
  textSize(12);
  text("ENTER o ESPACIO", width - 114, height - 18);
}

void dibujarFinal() {
  if (viendoDesenlace) {
    dibujarDesenlace();
    return;
  }

  background(25, 30, 40);

  noStroke();
  fill(15, 20, 30);
  rect(60, 20, width - 120, height - 40, 12);

  // Sprite de animo final
  PImage spriteFinal = spriteAnimoActual();

  if (spriteFinal != null) {
    dibujarSpriteCuadrado(spriteFinal, width - 170, 40, 80);
  }

  fill(255, 220, 80);
  textAlign(CENTER, CENTER);
  textSize(34);
  text("INFORME FINAL · " + titulosFinal[finalElegido], width/2, 60);

  fill(255);
  textSize(18);
  text("Jugador: " + nombre, width/2, 100);

  textSize(15);
  text("Días completados: " + DIAS_TOTALES + " / " + DIAS_TOTALES, width/2, 130);
  text("Puntos visitados: " + contarPuntosVisitados() + " / " + puntosVisitados.length, width/2, 152);
  text("Distancia recorrida: " + int(distanciaRecorrida), width/2, 174);
  text("Acciones: " + accionesTotales + "   |   Nivel " + nivelAtencion() + " · " + nombreNivelAtencion(), width/2, 196);
  text("Horario simulado: " + horasInicioJuego[0] + " - " + horasFinJuego[0], width/2, 218);
  text("Estrés final: " + nivelEstresTexto() + " (" + int(estres) + "%)", width/2, 240);

  fill(255, 220, 80);
  textSize(16);
  text("LOGROS (" + contarLogros() + " / " + TOTAL_LOGROS + ")", width/2, 272);

  textAlign(LEFT, CENTER);
  textSize(14);

  float y = 300;

  for (int i = 0; i < TOTAL_LOGROS; i++) {

    if (logros[i]) {
      fill(255, 220, 80);
    } else {
      fill(140);
    }

    String marca = logros[i] ? "[X] " : "[ ] ";
    text(marca + nombresLogros[i] + " - " + descripcionesLogros[i], 150, y);

    y += 24;
  }

  fill(255);
  textAlign(CENTER, CENTER);
  text("Avisos silenciados: " + bloqueos + "   |   Distracciones: " + distracciones +
       "   |   Concentración: " + concentracion + " / 100", width/2, 473);

  dibujarBoton("JUGAR DE NUEVO", width/2 - 240, height - 70, 220, 42);
  dibujarBoton("VOLVER AL MENU", width/2 + 20, height - 70, 220, 42);
}

// ==================================================
// CONVERTIR CLIC A COORDENADAS DEL MAPA
// ==================================================

float pantallaAMapaX(float pantallaX) {

  return (pantallaX - width/2) / zoomActual + jugadorX;
}

float pantallaAMapaY(float pantallaY) {

  return (pantallaY - height/2) / zoomActual + jugadorY;
}

// ==================================================
// MOUSE PRESSED
// ==================================================

void mousePressed() {

  if (!recursosListos) return;

  actualizarTiempo();
// Clics del panel de notificaciones.
if (estadoActual == EXPLORACION && telefonoAbierto) {
  float alto = height - 70;
  float ancho = alto * imgCelular.width / imgCelular.height;
  float x = width/2 - ancho/2 - 130;

  float panelX = x + ancho + 25;
  float panelW = width - panelX - 30;

  if (sobreBoton(panelX + 20, 365, panelW - 40, 42)) {
    atenderNotis(true);
  } else if (sobreBoton(panelX + 20, 417, panelW - 40, 42)) {
    atenderNotis(false);
  }

  return;
}
  if (estadoActual == MENU) {

    // Si el popup de controles está abierto, cerrarlo con clic
    if (mostrandoControles) {
      mostrandoControles = false;
      return;
    }

    if (panelMenu != 0) {

      if (sobreBoton(width/2 - 115, 470, 230, 45)) {
        panelMenu = 0;
      }

      return;
    }

    // El clic identifica el botón. El switch ejecuta su acción.
    String opcion = "";
    if (sobreBoton(55, 230, 230, 48)) opcion = "Jugar";
    else if (sobreBoton(55, 290, 230, 48)) opcion = "Continuar";
    else if (sobreBoton(55, 350, 230, 48)) opcion = "Cómo jugar";
    else if (sobreBoton(55, 410, 230, 48)) opcion = "Créditos";
    else if (sobreBoton(55, 470, 230, 48)) opcion = "Salir";

    switch (opcion) {
      case "Jugar":
        iniciarPartida();
        break;
      case "Continuar":
        if (partidaEnCurso) reanudarPartida();
        break;
      case "Cómo jugar":
        mostrandoControles = true;
        break;
      case "Créditos":
        panelMenu = 2;
        break;
      case "Salir":
        exit();
        break;
    }

    return;
  }

  if (estadoActual == PAUSA) {

    if (sobreBoton(width/2 - 115, 250, 230, 45)) {
      reanudarPartida();
    } else if (sobreBoton(width/2 - 115, 310, 230, 45)) {
      estadoActual = MENU;
    }

    return;
  }

  // Registro: solo se escribe con el teclado, no hace falta clic.
  if (estadoActual == REGISTRO) {
    return;
  }

  // Decision del dia: clic en una opcion.
  if (estadoActual == EXPLORACION && decisionActiva) {

    if (sobreBoton(width/2 - 220, 250, 440, 50)) {
      aplicarDecision(0);
    } else if (sobreBoton(width/2 - 220, 315, 440, 50)) {
      aplicarDecision(1);
    } else if (sobreBoton(width/2 - 220, 380, 440, 50)) {
      aplicarDecision(2);
    }

    return;
  }

  if (estadoActual == FINAL) {
    if (viendoDesenlace) {
      if (sobreBoton(width - 196, height - 76, 164, 42)) viendoDesenlace = false;
      return;
    }

    if (sobreBoton(width/2 - 240, height - 70, 220, 42)) {
      iniciarPartida();
    } else if (sobreBoton(width/2 + 20, height - 70, 220, 42)) {
      estadoActual = MENU;
    }

    return;
  }
}

// ==================================================
// TECLADO
// ==================================================

void keyPressed() {

  if (mostrandoControles) {

    if (key == ESC || key == ' ' || key == ENTER) {
      mostrandoControles = false;
      key = 0;
      return;
    }
  }

  if (key == ESC) {

    key = 0;

    if (!recursosListos) return;

    actualizarTiempo();

    // Si el celular esta abierto, ESC solo lo cierra.
    if (telefonoAbierto) {
      telefonoAbierto = false;
      hayNotificacion = false;
      return;
    }

    if (estadoActual == PAUSA) {

      reanudarPartida();

    } else if (estadoActual == MENU) {

      panelMenu = 0;

    } else if (estadoActual == REGISTRO) {

      // Cancelar el registro y volver al menu
      estadoActual = MENU;
      partidaEnCurso = false;

    } else if (estadoActual != FINAL) {

      estadoAntesDePausa = estadoActual;
      estadoActual = PAUSA;

      teclaW = false;
      teclaA = false;
      teclaS = false;
      teclaD = false;

      moviendo = false;
    }

    return;
  }

  if (!recursosListos) return;

  if (estadoActual == FINAL && viendoDesenlace) {
    if (key == ENTER || key == RETURN || key == ' ') viendoDesenlace = false;
    return;
  }

  int avisosAntesDeLaTecla = avisosDelDia;
  actualizarTiempo();

  if (estadoActual == MINIJUEGO) {
    // Un aviso vencido ya se contó. Esta tecla no debe fallar el siguiente.
    if (avisosDelDia == avisosAntesDeLaTecla) teclaBatalla();
    return;
  }

  // Registro inicial: toda la escritura la maneja esta funcion
  if (estadoActual == REGISTRO) {
    manejarTeclaRegistro();
    return;
  }

  // Cambio de dia: solo la imagen del medio espera ESPACIO.
  if (estadoActual == CAMBIO_DIA) {

    if (faseCambioDia == 1 &&
        (key == ' ' || key == ENTER || key == RETURN)) {

      avanzarFaseCambioDia();
    }

    return;
  }

  if (estadoActual == INTRO) {

    if (key == ENTER || key == ' ') {
      avanzarEscenaIntro();
    }

    if (key == 's' || key == 'S') {
      iniciarCinematica();
    }

    return;
  }

  // Decision del dia: elegir con 1, 2 o 3.
  if (estadoActual == EXPLORACION && decisionActiva) {

    if (key == '1') {
      aplicarDecision(0);
    } else if (key == '2') {
      aplicarDecision(1);
    } else if (key == '3') {
      aplicarDecision(2);
    }

    return;
  }

  // Abrir/cerrar celular con tecla C.
  if (estadoActual == EXPLORACION && !decisionActiva && (key == 'c' || key == 'C')) {

    telefonoAbierto = !telefonoAbierto;

    if (telefonoAbierto) {
      hayNotificacion = false;
    }

    key = 0;
    return;
  }

  if (key == 'm' || key == 'M') {
    mostrarColisiones = !mostrarColisiones;
  }

  if (estadoActual == DIALOGO && key == ENTER) {
    estadoActual = EXPLORACION;
  }

  // Activar WASD solo durante la exploracion y con el celular cerrado.

  if (estadoActual == EXPLORACION && !telefonoAbierto) {

    if (key == 'w' || key == 'W') teclaW = true;
    if (key == 'a' || key == 'A') teclaA = true;
    if (key == 's' || key == 'S') teclaS = true;
    if (key == 'd' || key == 'D') teclaD = true;
  }
}

// ==================================================
// SOLTAR TECLAS
// ==================================================

void keyReleased() {

  if (key == 'w' || key == 'W') teclaW = false;
  if (key == 'a' || key == 'A') teclaA = false;
  if (key == 's' || key == 'S') teclaS = false;
  if (key == 'd' || key == 'D') teclaD = false;
}

// ==================================================
// FECHA Y HORA SIMULADA
// ==================================================

// Convierte un total de minutos (desde las 00:00) a texto "HH:MM".
String horaTexto(int totalMinutos) {

  int h = (totalMinutos / 60) % 24;
  int m = totalMinutos % 60;

  return nf(h, 2) + ":" + nf(m, 2);
}

// Prepara la fecha y las horas de los 7 dias de juego.
// Dia 1 empieza 08:00 y termina 16:00, y asi cada dia.
void prepararFechasSimuladas() {

  int inicioMinutos = HORA_INICIO_SIM * 60 + MINUTO_INICIO_SIM;
  int finMinutos = inicioMinutos + MINUTOS_POR_DIA;

  // La semana siempre tiene un primer día. Preparamos ese día antes de comprobar si queda otro.
  int i = 0;
  do {
    fechasJuego[i] = "Día " + (i + 1);
    horasInicioJuego[i] = horaTexto(inicioMinutos);
    horasFinJuego[i] = horaTexto(finMinutos);
    i++;
  } while (i < DIAS_TOTALES);
}

// Devuelve la fecha registrada del dia actual.
String fechaDelDiaActual() {

  int i = constrain(diaActual - 1, 0, DIAS_TOTALES - 1);
  return fechasJuego[i];
}

// Devuelve la hora de inicio registrada del dia actual.
String horaInicioDelDia() {

  int i = constrain(diaActual - 1, 0, DIAS_TOTALES - 1);
  return horasInicioJuego[i];
}

// Devuelve la hora de salida registrada del dia actual.
String horaFinDelDia() {

  int i = constrain(diaActual - 1, 0, DIAS_TOTALES - 1);
  return horasFinJuego[i];
}

// ==================================================
// INICIAR Y REANUDAR UNA PARTIDA
// ==================================================

void iniciarPartida() {
  pendientes = 0;
  esperaNoti = 0;
  relojNoti = 0;
  finAvisoCentral = 0;
  tipoAvisoCetral = 0;

  configuracionnotis(1);
  viendoDesenlace = false;
  imagenDesenlace = null;

  diaActual = 1;
  minutosJornada = 0;
  horasRestantes = 8;

  // Registrar fecha y horas simuladas de los 7 dias.
  prepararFechasSimuladas();

  tiempoActivo = 0;
  tiempoIntro = 0;

  mostrarColisiones = false;
  panelMenu = 0;
  mostrandoControles = false;

  // Inicializar registro
  nombre = "";
  mensajeRegistro = "";

  // Reiniciar logros, decisiones y estres
  for (int i = 0; i < TOTAL_LOGROS; i++) {
    logros[i] = false;
  }

  for (int i = 0; i < puntosVisitados.length; i++) {
    puntosVisitados[i] = false;
  }

  concentracion = 70;
  bloqueos = 0;
  distracciones = 0;
  avisosDelDia = 0;
  retoIniciado = false;
  resultadoAviso = "";
  distanciaRecorrida = 0;
  estres = 0;
  estresTotal = 0;
  accionesTotales = 0;
  diaDecision = 0;
  decisionActiva = false;
  mensajeLogro = "";
  tiempoMensajeLogro = 0;

  // Reiniciar celular
  telefonoAbierto = false;
  hayNotificacion = false;
  mensajeNotificacion = "Sin notificaciones.";

  configurarNiebla();

  if (!iniciarJugador()) {

    detalleError = "La máscara no tiene un lugar válido para iniciar.";
    recursosListos = false;
    errorRecursos = true;

    return;
  }

  zoomActual = zoomInicial;

  partidaEnCurso = true;
  estadoActual = REGISTRO;

  ultimaLectura = millis();
}

void reanudarPartida() {

  estadoActual = estadoAntesDePausa;
  ultimaLectura = millis();
}

boolean sobreBoton(float x, float y, float ancho, float alto) {

  return mouseX >= x &&
         mouseX <= x + ancho &&
         mouseY >= y &&
         mouseY <= y + alto;
}

// ==================================================
// TIEMPO REAL, ANIMACIONES Y JORNADAS
// ==================================================

void actualizarTiempo() {

  int ahora = millis();
  int transcurrido = ahora - ultimaLectura;

  ultimaLectura = ahora;

  if (recursosListos && transcurrido > 0) {
    avanzarTiempo(transcurrido);
  }
}

void avanzarTiempo(int milisegundos) {

  if (estadoActual == MENU ||
      estadoActual == PAUSA ||
      estadoActual == FINAL) {

    return;
  }
  
  tiempoActivo += milisegundos;

  if (estadoActual == INTRO) {

    if (tiempoActivo - tiempoIntro >= DURACION_INTRO) {
      iniciarCinematica();
    }

  } else if (estadoActual == CINEMATICA) {

    if (tiempoActivo - tiempoCinematica >= duracionCinematica) {

      zoomActual = zoomFinal;
      estadoActual = EXPLORACION;
    }

  } else if (estadoActual == MINIJUEGO) {
    if (retoIniciado && avisosDelDia < AVISOS_POR_DIA &&
        tiempoActivo - inicioAviso >= duracionAviso()) {
      resolverAviso(false);
    }
  } else if (estadoActual == EXPLORACION) {

    // El reloj se detiene mientras el jugador decide o usa el celular.
    if (decisionActiva || telefonoAbierto) {
      return;
    }
    
    actualizarNotis(milisegundos);
    minutosJornada += milisegundos / 1000.0 * MINUTOS_POR_SEGUNDO;

    horasRestantes = max(
      0,
      (MINUTOS_POR_DIA - minutosJornada) / 60.0
    );

    if (minutosJornada >= MINUTOS_POR_DIA) {

      if (diaActual == DIAS_TOTALES) {

        partidaEnCurso = false;
        moviendo = false;
        desbloquearLogro(4);
        iniciarDesenlace();

      } else {

        tiempoCambioDia = tiempoActivo;
        faseCambioDia = 0;
        estadoActual = CAMBIO_DIA;
      }
    }

  } else if (estadoActual == CAMBIO_DIA) {

    // La primera imagen pasa sola y la ultima inicia el juego sola.
    // La imagen del medio espera a que el jugador pulse ESPACIO.
    if ((faseCambioDia == 0 || faseCambioDia == 2) &&
        tiempoActivo - tiempoCambioDia >= DURACION_CAMBIO_DIA) {

      avanzarFaseCambioDia();
    }
  }
}

// ==================================================
// CAMBIO DE DIA CON IMAGENES
// ==================================================

// Avanza una imagen de la transicion. Cuando ya se mostraron
// las 3 imagenes, empieza el siguiente dia.
void avanzarFaseCambioDia() {

  faseCambioDia++;
  tiempoCambioDia = tiempoActivo;

  if (faseCambioDia <= 2) {
    return;
  }

  // Terminaron las imagenes: comienza el nuevo dia.
  diaActual++;

  // Logro al completar el primer dia.
  if (diaActual == 2) {
    desbloquearLogro(1);
  }

  minutosJornada -= MINUTOS_POR_DIA;

  horasRestantes = max(
    0,
    (MINUTOS_POR_DIA - minutosJornada) / 60.0
  );

  // Al despertar, el jugador aparece en el punto fijo.
  jugadorX = DESPERTAR_X;
  jugadorY = DESPERTAR_Y;

  destinoX = jugadorX;
  destinoY = jugadorY;

  moviendo = false;
  teclaW = false;
  teclaA = false;
  teclaS = false;
  teclaD = false;

  faseCambioDia = 0;
  estadoActual = EXPLORACION;
}

// ==================================================
// INTRODUCCION CON FOTOGRAMAS
// ==================================================

void dibujarIntro() {

  int indice = (tiempoActivo - tiempoIntro) / DURACION_FOTOGRAMA;

  indice = constrain(
    indice,
    0,
    fotogramasIntro.length - 1
  );

  imageMode(CORNER);

  image(
    fotogramasIntro[indice],
    0,
    0,
    width,
    height
  );

  noStroke();
  fill(15, 25, 35, 220);

  rect(0, height - 27, width, 27);

  fill(255);
  textAlign(CENTER, CENTER);
  textSize(13);

  text(
    "ENTER o ESPACIO: siguiente escena   |   S: saltar intro   |   ESC: pausa",
    width/2,
    height - 14
  );
}

void avanzarEscenaIntro() {

  int[] comienzos = {0, 26, 51, 60, 108};

  int indice = (tiempoActivo - tiempoIntro) / DURACION_FOTOGRAMA;

  for (int i = 1; i < comienzos.length; i++) {

    if (indice < comienzos[i]) {

      tiempoIntro = tiempoActivo -
                    comienzos[i] * DURACION_FOTOGRAMA;

      return;
    }
  }

  iniciarCinematica();
}

// ==================================================
// CAMBIO DE DIA
// ==================================================

void dibujarCambioDia() {

  // Elegir la imagen segun la fase.
  PImage imagen = imgDiaTerminado;

  if (faseCambioDia == 1) {
    imagen = imgPasoDeDia;
  } else if (faseCambioDia >= 2) {
    imagen = imgInicioDia;
  }

  // Dibujar la imagen cubriendo la ventana sin deformarla.
  imageMode(CORNER);

  float escala = max((float)width / imagen.width,
                     (float)height / imagen.height);

  float w = imagen.width * escala;
  float h = imagen.height * escala;

  image(imagen, (width - w) / 2, (height - h) / 2, w, h);
}

// ==================================================
// FONDO DE PAUSA
// ==================================================

void dibujarFondoPausa() {

  if (estadoAntesDePausa == INTRO) {

    dibujarIntro();

  } else if (estadoAntesDePausa == CINEMATICA) {

    dibujarMapa();

  } else if (estadoAntesDePausa == MINIJUEGO) {

    dibujarMinijuego();

  } else {

    dibujarExploracion();

    if (estadoAntesDePausa == DIALOGO) {
      dibujarDialogo();
    }

    if (estadoAntesDePausa == CAMBIO_DIA) {
      dibujarCambioDia();
    }
  }
}

// ==================================================
// INFORMACION DEL MENU
// ==================================================

void dibujarInformacionMenu() {

  noStroke();
  fill(12, 24, 30, 245);

  rect(25, 35, width - 50, height - 70, 16);

  fill(255);
  textAlign(CENTER, CENTER);
  textSize(30);

  if (panelMenu == 1) {

    text("CÓMO JUGAR", width/2, 100);

    textSize(18);

    text(
      "Usa WASD para mover al estudiante por los caminos.",
      width/2,
      175
    );

    text(
      "Completa siete jornadas de 08:00 a 16:00.",
      width/2,
      215
    );

    text(
      "ESC pausa la partida. M muestra la máscara de colisiones.",
      width/2,
      255
    );

    text(
      "En la intro, ENTER avanza la escena y S la salta.",
      width/2,
      295
    );

    text(
      "CONTINUAR retoma tu partida mientras el programa esté abierto.",
      width/2,
      350
    );

    text(
      "JUGAR inicia una partida nueva.",
      width/2,
      390
    );

  } else {

    text("CRÉDITOS", width/2, 100);

    textSize(20);

    text(
      "Supervivencia Digital",
      width/2,
      180
    );

    textSize(18);

    text(
      "Desarrollado en Processing.",
      width/2,
      230
    );
     text("INTEGRANTES DE EL GRUPO", width/2, 300);
      textSize(20);
      
     text(
      "Derek Pérez",
      width/2,
      350
    );
     text(
      "Samuel Lombana",
      width/2,
      400
    );
     text(
      "Yull Escamilla",
      width/2,
      450
    );
  }

  dibujarBoton(
    "VOLVER",
    width/2 - 115,
    470,
    230,
    45
  );
}

// ==================================================
// REGISTRO INICIAL DEL JUGADOR
// ==================================================
// La pantalla guarda los datos como texto mientras se escribe.
// Al presionar ENTER en el ultimo campo se validan y se pasa a la intro.

// ==================================================
// DIBUJAR REGISTRO
// ==================================================
void dibujarRegistro() {

  // Fondo: imagen registro.png cubriendo toda la ventana
  // sin deformarla (mantiene su proporcion).
  imageMode(CORNER);

  float escala = max((float)width / imgRegistro.width,
                     (float)height / imgRegistro.height);

  float w = imgRegistro.width * escala;
  float h = imgRegistro.height * escala;

  image(imgRegistro, (width - w) / 2, (height - h) / 2, w, h);

  // Pregunta
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(34);
  text("¿Cómo te llamas?", width / 2, 210);

  // Nombre escrito por el jugador
  textSize(30);
  fill(255, 240, 120);
  text(nombre, width / 2, 285);

  // Linea debajo del nombre
  stroke(255);
  strokeWeight(2);
  line(width / 2 - 200, 305, width / 2 + 200, 305);
  noStroke();

  // Cursor parpadeante
  if ((frameCount / 30) % 2 == 0) {
    float cursorX = width / 2 + textWidth(nombre) / 2 + 4;
    fill(255);
    textAlign(LEFT, CENTER);
    text("|", cursorX, 285);
  }

  // Instrucciones
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(16);
  text("Escribe tu nombre y presiona ENTER", width / 2, height - 60);

  // Mensaje de error
  if (mensajeRegistro.length() > 0) {
    fill(255, 90, 90);
    textAlign(CENTER, CENTER);
    textSize(16);
    text(mensajeRegistro, width / 2, height - 30);
  }
}

// ==================================================
// VALIDAR REGISTRO
// ==================================================
boolean validarRegistro() {

  mensajeRegistro = "";

  if (nombre.trim().length() == 0) {
    mensajeRegistro = "Escribe tu nombre para continuar.";
    return false;
  }

  println("Registro valido: " + nombre);
  return true;
}

// ==================================================
// MANEJAR TECLADO EN EL REGISTRO
// ==================================================
void manejarTeclaRegistro() {

  // ENTER confirma el nombre y comienza la intro
  if (key == ENTER || key == RETURN) {
    if (validarRegistro()) {
      comenzarJuegoTrasRegistro();
    }
    return;
  }

  // Borrar
  if (key == BACKSPACE) {
    if (nombre.length() > 0) {
      nombre = nombre.substring(0, nombre.length() - 1);
    }
    return;
  }

  // Escribir letras y espacios (maximo 20 caracteres)
  if ((Character.isLetter(key) || key == ' ') && nombre.length() < 20) {
    nombre = nombre + key;
  }
}

// ==================================================
// COMENZAR EL JUEGO DESPUES DEL REGISTRO
// ==================================================
void comenzarJuegoTrasRegistro() {

  tiempoActivo = 0;
  tiempoIntro = 0;
  ultimaLectura = millis();

  estadoActual = INTRO;
}

//frecuencia de notis segun la decision

void configuracionnotis(int opcion) {
switch (opcion) {
  
  case 0: //usar red social
    minimoNoti = 3000;
    maximoNoti = 6000; 
    break;
    
  case 1: //estudiar
   minimoNoti = 6000;
   maximoNoti = 10000; 
   break;
  
  case 2: //dormir
    minimoNoti = 10000;
    maximoNoti = 16000; 
    break;
}

esperaNoti = 0;
intervaloNoti = int(random(minimoNoti, maximoNoti));

}

//actualizar los segundos desde el ultimo act

  void actualizarNotis(int milisegundos) {
    if(decisionActiva || telefonoAbierto) return;
  
    relojNoti += milisegundos;
    esperaNoti += milisegundos;

//cuando tenga mas de 2 notis el estres empieza a aumentar cada vez mas
    if(pendientes  >= 3) {
    float aumento = (pendientes - 2) * 0.20;
    estresTotal += aumento * milisegundos / 1000.0;
    estresTotal = constrain(estresTotal, 0, 100);
    estres = estresTotal;
    } 
    
    if(esperaNoti >= intervaloNoti) {
    agregarNoti();
    
    esperaNoti = 0;
    intervaloNoti = int(random(minimoNoti, maximoNoti));
  
}

}

void agregarNoti() {
  //maximo de notis 30
 if(pendientes >= bandeja.length) return;
 int tipo = int(random(spritesAvisos.length));
 
 bandeja[pendientes] = tipo;
 pendientes++;
 
 tipoAvisoCetral = tipo;
 finAvisoCentral = relojNoti + 3000;
   
}

///ahora dibujar eso en la pantalla 

void dibujarAvisoCentral(){
  if(estadoActual != EXPLORACION) return;
  if(decisionActiva || telefonoAbierto) return;
  if(relojNoti >= finAvisoCentral) return;
  
 dibujarImagenEnCaja(
  spritesAvisos[tipoAvisoCetral],
  //posicion en oantalla
  width/2 - 200,
  height/2 - 115,
  400, //x
  230 //y
 );
  
}

//atebder notis

void atenderNotis(boolean responder) {
if (pendientes == 0) return;

int i = 0;
while (i < pendientes - 1) {
bandeja [i] = bandeja [i + 1];
i++;
}
pendientes--;
if (responder) {
 estresTotal -= 4;
}else {
  estresTotal -= 2;
}
estresTotal = constrain(estresTotal, 0, 100);
estres = estresTotal;
finAvisoCentral = relojNoti; //esto quita el cartel cuando respondemos
}


  
