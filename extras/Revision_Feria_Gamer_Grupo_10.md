# Feria Gamer 2026 · Grupo 10

**Segunda entrega · revisión del 7 de noviembre de 2026**

El proyecto conserva el nombre **Supervivencia Digital** y presenta **Batalla por la Atención** como su tema. La versión actual permite defender la concentración durante siete jornadas. **El juego cumple parte de la segunda entrega.** La principal brecha está en registrar los hábitos digitales y convertirlos en un puntaje de riesgo que produzca un diagnóstico. Las decisiones diarias ya conducen a tres desenlaces según el ánimo del personaje.

## Abrir y probar

1. Abre el archivo principal `sketch_261103b.pde` de la carpeta original en Processing, modo Java. Si el editor tenía abierta una versión anterior, vuelve a abrir el archivo guardado en disco.
2. Pulsa ▶, elige **Jugar**, escribe un nombre y pulsa **Enter**. La introducción avanza sola. **S** permite saltarla.
3. Después del zoom, elige una de las tres acciones del día. Aparece el **Señor de las Notificaciones**. Pulsa **Enter** para iniciar el reto.
4. Pulsa **Espacio** cuando el centro del aviso amarillo esté dentro de la franja verde. Cada bloqueo suma 5 de concentración. Anticiparse o dejar pasar la alerta resta 8. Al resolver tres avisos, **Enter** devuelve al campus. **WASD** mueve al estudiante y **Esc** pausa el reto.
5. Al terminar la jornada, pulsa **Espacio** en la imagen intermedia para pasar al siguiente día. Los días 1 y 2 son de nivel principiante, los días 3 a 5 de usuario frecuente y los días 6 y 7 de experto.

## Qué había y qué se añadió

El respaldo `backups/jeugo hub.zip` contiene el proyecto previo al primer avance del tema 10, incluidos sus recursos, autoguardados y respaldo anterior. Sus 168 archivos se comprobaron contra el original. El ZIP contiene la carpeta `sketch_261103b` y se puede extraer en otra ubicación para comparar versiones. Para la entrega académica conviene preparar un ZIP aparte con el nombre y las iniciales exigidas por la guía.

La versión respaldada ya tenía registro de nombre, cinemática, campus con movimiento WASD, teléfono con notificaciones, decisiones de estrés, ánimo, transiciones, logros e informe semanal. El nuevo avance conecta la decisión diaria al estado `MINIJUEGO`, añade el primer enemigo del tema, tres velocidades, concentración, una barra de avance semanal y un resumen de avisos.

## Revisión contra el laboratorio

Las páginas se refieren al PDF **Laboratorio Único – Feria Gamer 2026, Algoritmia y Programación I** entregado por el equipo.

| Requisito | Estado después del avance | Evidencia o trabajo pendiente |
|---|---|---|
| Tema 10 y relación con redes (pp. 6–7) | Primer avance jugable | Las notificaciones distraen al estudiante durante el estudio. Silenciarlas a tiempo protege la concentración. Los otros enemigos del enunciado son sugerencias. |
| Semana, tres niveles y progreso (pp. 4–6) | Implementado | Siete jornadas. El aviso tarda 3,0, 2,4 o 1,8 segundos en cruzar según el nivel. El HUD muestra el nivel y el avance semanal. |
| Mínimo tres logros y reinicio (pp. 4, 5 y 7) | Verificado en la lógica | Hay seis logros definidos. La prueba desbloqueó cuatro y comprobó que Jugar de nuevo restablece el registro, el día, los logros y los contadores. |
| Condicionales y menú con switch (pp. 2–3 y 7) | Parcial | Hay condicionales y switch para estados y nombres de nivel. En el menú principal, mousePressed() sigue escogiendo las acciones con if/else. Conviene que el switch despache directamente la opción del menú, como exige el enunciado. |
| for, while, do/while, acumuladores y contadores (pp. 4–7) | Implementado | Hay for en la máscara, la niebla, los recursos y los logros. Se acumulan distancia y estrés y se cuentan acciones, avisos silenciados y distracciones. contarLogros() usa while para contar los logros desbloqueados. prepararFechasSimuladas() usa do/while para preparar el horario de las siete jornadas. |
| Registro y calendario (pp. 1–3 y 6) | Parcial | Solo se pide y valida el nombre. Faltan edad, año, mes, día, hora, minuto, AM/PM y horas previstas de redes. Validar rangos, días por mes, día de la semana y bisiestos. La etiqueta «Día 1» es el número de jornada. |
| Hora de salida (pp. 2 y 6) | Pendiente | El campus usa 08:00–16:00. La sesión de redes debe calcular su propia salida en formato militar desde la entrada registrada, sumar la duración y un segundo, y ajustar el calendario si cambia de día. |
| Dos contenidos, riesgo y situaciones distintas (pp. 2–3 y 7) | Pendiente | Las mismas tres acciones se repiten cada día. Diseñar al menos cinco situaciones distintas y elegir dos contenidos por sesión. Aplicar +4 puntos si el uso supera 3 h y es menor de 8 h, +7 desde 8 h y +4 si la entrada o salida está fuera de 08:00–20:00. Definir y explicar el puntaje de cada contenido. |
| Estadísticas finales (p. 5) | Parcial | El informe incluye nombre, horarios fijos, acciones, distancia, estrés, nivel, logros, bloqueos, distracciones y concentración. Faltan ingreso/salida calculados, horas acumuladas de redes, días equivalentes por año, decisiones digitales correctas e incorrectas y puntaje digital acumulado. |
| Ranking, diagnóstico y tres finales (pp. 5–7 y 10) | Parcial | Al terminar el día 7 se muestra una cinemática según el estrés: final bueno por debajo de 20, regular desde 20 hasta menos de 60 y malo desde 60. Enter, Espacio o el botón Ver informe abren las estadísticas. Falta mostrar las cuatro clasificaciones de riesgo por puntos: menos de 5, 5–13, 14–20 y más de 20. El diagnóstico resumido de la p. 10 utiliza tres rangos: menos de 5, 5–13 y más de 13. El ejemplo de 18 puntos de la p. 5 contradice la tabla; para 18, la tabla indica «Usuario en Riesgo». |

## Próximo trabajo para primer semestre

1. **Registro de sesión y hora de salida.** Conservar el formulario y añadir un dato por pantalla. Usar enteros, comparaciones y funciones cortas. Probar 12 AM, 12 PM, fin de mes y febrero bisiesto. Por ejemplo, una entrada el 28 de febrero de 2028 a las 11:30 PM con dos horas de uso debe salir el 29 a la 01:30:01.
2. **Puntaje y decisiones.** Escribir siete situaciones en un arreglo, elegir una con el índice del día y sumar los puntos de tiempo, horario y contenido una vez por sesión. Un while puede repartir un total de horas entre días cuando se cruza medianoche. Un do/while puede buscar la siguiente opción de contenido, saltándose la que el usuario ya eligió. Cada ciclo debe tener un límite y una tarea que el equipo pueda explicar.
3. **Informe y finales.** Separar el estrés del personaje, la concentración del reto y el riesgo digital del laboratorio. Llevar los contadores de riesgo durante la partida y presentar la clasificación junto con el desenlace por ánimo. Probar los límites 4, 5, 13, 14, 20 y 21.

## Cómo explicar el nuevo código

- **aplicarDecision()** conserva la elección del día y abre el reto.
- **nivelAtencion()** y **duracionAviso()** eligen la dificultad según el día.
- **dibujarMinijuego()** coloca el aviso en la barra. A mitad de su recorrido entra en la zona verde y al 80 % sale de ella.
- **teclaBatalla()** compara el instante de la pulsación con esa ventana. **resolverAviso()** cuenta un solo resultado y prepara la siguiente alerta.
- **avanzarTiempo()** detecta avisos que vencieron. Usa el reloj activo del juego para que Esc congele el intento. **iniciarPartida()** vuelve a poner los contadores en cero.

**Prueba realizada.** Se compiló el sketch en Processing 4.5.7. Una prueba automatizada cargó los recursos reales, avanzó por registro, intro, decisiones, retos, transiciones y final, y probó el reinicio. En cada jornada se bloqueó una alerta, se pulsó antes de tiempo en otra y se dejó vencer la tercera. Resultado esperado y obtenido: siete bloqueos y catorce distracciones. Se verificó también la pausa a mitad de un aviso. Esta prueba ejercitó los métodos del sketch; la jugabilidad y la lectura en el proyector requieren un ensayo del equipo.

## Entrega del equipo

El PDF fija el **18 de noviembre de 2026 a las 2:30 p. m.** para la segunda entrega. Pide ZIP funcional con las iniciales de los cuatro integrantes, nombres completos en los comentarios, manual de usuario, diapositivas y enlace a un video de hasta dos minutos con participación de cada integrante y sus roles. La guía menciona Brightspace, Drive y la carpeta OneDrive del curso. Revisen el enlace de su NRC y el nombre de la carpeta (pp. 8–9).

La sustentación dura hasta seis minutos e incluye un video de trabajo colaborativo de hasta un minuto. El PDF asigna 25 % a jugabilidad, funcionalidad, organización y documentación, 25 % a sustentación, 15 % a ciclos y 15 % a creatividad en GUI. Los materiales del equipo y la rotación de roles se comprueban por separado del sketch. El sonido figura en el bonus Diamante junto con imágenes y animaciones.
