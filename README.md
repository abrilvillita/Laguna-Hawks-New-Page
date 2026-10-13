# Laguna Hawks — nueva página

Sitio público de Laguna Hawks con una página independiente para el equipo. El repositorio contiene `index.html`, recursos visuales, `panel.html` y un esquema SQL propuesto para Supabase.

## Estado

La página pública se puede previsualizar como archivo estático. El panel de equipo es una **base en desarrollo**: requiere crear un proyecto Supabase, configurar Auth y ejecutar el esquema, registrar integrantes autorizados y comprobar las políticas RLS con cuentas reales de prueba. La presencia del panel y del SQL no demuestra que esas integraciones estén activas ni que el acceso haya sido validado en producción.

## Vista local

Abre `index.html` para revisar la página. `panel.html` solo funcionará conectado a un proyecto Supabase configurado. Utiliza exclusivamente la URL y clave **publicable** de Supabase en el navegador; nunca pegues una clave secreta o `service_role` en la página ni en el repositorio.

## Seguridad del panel

El esquema habilita RLS y limita las filas de proyectos a integrantes registrados; la política de membresía permite leer el registro propio para evitar recursión. Antes de usar datos reales, verifica con usuarios no miembros, miembros, editores y administradores que lectura, inserción, edición y borrado tengan los permisos esperados. Confirma también la configuración de exposición de tablas en Data API, las concesiones SQL y el acceso de Realtime. No se han ejecutado aquí pruebas contra la base de datos conectada.

## Derechos y licencia

No se asigna una licencia de código hasta revisar la titularidad del trabajo, el logotipo, fotografías y otros materiales del equipo. Su presencia en GitHub no autoriza reutilizar la marca.
