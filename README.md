
CADA QUE HAGAN CAMBIOS
NO LOS SUBAN A EL MAIN
SUBANLOS A EL BRANCH 
Y CUANDO ESTE TODO BIEN 
LO SUBIMOS A EL MAIN


Y SI VAS A AÑADIR O USAR ALGUN ASSET ESCRIBE A EL GRUPO


Para colaborar con su equipo en este repositorio, aquí tiene un flujo de trabajo de Git básico:
1. pull (actualizar desde remoto)
# Actualizar las últimas confirmaciones del remoto
git pull
# o para ser explícito:
git pull origin main
2. push (enviar cambios locales al remoto)
# Enviar confirmaciones nuevas al remoto
git push
# o explícito:
git push origin main
3. Diagrama de flujo típico con equipo
Trabajador A               Trabajador B
    |                           |
    | commit cambios locales    | commit cambios locales
    |----------------------->   |
    |                           |
    |        pull              | pull
    |----------------------->   |----------------------->   (ambos obtienen actualizaciones)
    |                           |
    |        push                | push
    |----------------------->   |----------------------->   (ambos tienen cambios)
4. Manejar conflictos
Si dos miembros editan el mismo archivo y luego ambos intentan push, Git rechazará el push con un error de "rechazado". El flujo recomendado:
# Rechazo de push: obtener las últimas confirmaciones del remoto y fusionarlas
git fetch origin
git merge origin/main

# Resolver cualquier conflicto de fusión manualmente
# Luego push
git push
O use git rebase (más limpio, pero tenga cuidado con la historia del historial del equipo):
git fetch origin
git rebase origin/main
# Resolver conflictos si los hubiera
git push --force-with-lease  # usando esto es seguro para equipos
5. Ramas (para el trabajo paralelo)
# Crear una rama local para su trabajo
git checkout -b feature/my-new-game

# Trabajar en la rama...
git add ...
git commit -m "Agregar nueva pantalla de menú"

# Enviar rama al remoto (primera vez)
git push -u origin feature/my-new-game

# Su equipo puede entonces:
# git fetch origin
# git checkout feature/my-new-game
# ...editar...
# git add ...
# git commit ...
# git push
6. Pull Request (PR) usando gh CLI
Si su equipo prefiere revisar cambios a través de GitHub:
# Instalar gh (si no está instalado):
# Windows: winget install GitHub.GitHubCLI
# macOS: brew install gh
# Linux: apt install gh

# Iniciar sesión una vez:
gh auth login

# Crear un PR desde la línea de comandos:
gh pr create \
  --title "Agregar pantalla de tutorial" \
  --body "Este PR agrega una nueva pantalla de tutorial con animaciones." \
  --head feature/my-new-game \
  --base main
7. Configuración de Git común
# Configurar su identidad global (una vez)
git config --global user.name "Su Nombre"
git config --global user.email "su.email@ejemplo.com"

# Para cada repositorio, puede sobrescribirlo:
git config user.name "Su Nombre"
git config user.email "su.email@ejemplo.com"

# Alias útiles:
git config --global alias.st "status"
git config --global alias.br "branch"
git config --global alias.co "checkout"
git config --global alias.ci "commit"
git config --global alias.unstage "reset HEAD --"
git config --global alias.ps "push --stateless-action"
8. Seguir los cambios
# Ver el estado del repositorio remoto
git log --oneline origin/main -5

# Ver cambios no confirmados
git diff

# Ver cambios confirmados
git diff HEAD~1 HEAD

# Ver historial del remoto
git log --graph --oneline --all
9. Trabajo seguro con equipo
- Nunca use --force-push en la rama principal a menos que coordine con el equipo
- Haga commit con mensajes significativos que describan lo que cambia
- Siempre git pull antes de git push en ramas compartidas para minimizar conflictos
- Use ramas separadas para cada funcionalidad en lugar de todas trabajar en main
10. Lista de verificación rápida antes de push
# 1. Asegurarse de que todo el trabajo está en commits
git status --short

# 2. Asegurarse de que no hay archivos no versionados que puedan ser sensibles
# (ej. .env, archivos de backup personales)

# 3. Asegurarse de que los mensajes de commit sean claros

# 4. Pull para obtener los últimos cambios
git pull

# 5. Verificar el historial
git log --oneline --graph -5

# 6. Push
git push
Con este flujo de trabajo, su equipo puede colaborar eficientemente en juego-feria-gamer mientras mantiene un historial limpio y evita sobrescribir accidentalmente el trabajo de otros.
