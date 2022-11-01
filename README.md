# Sistema de Marca blanca de webcams para afiliados

## Necesidades de la tarea

La tarea consiste en montar un sistema de marca blanca de nuestro servicio de webcams para
múltiples afiliados.
El afiliado creará un registro CNAME en su DNS apuntando al servidor que hospeda el sistema, el
cual será nuestro.
Cada afiliado contará con un diseño customizado mediante css. La estructura es la misma para
todos.
El sistema debe ser capaz de reconocer qué template mostrar de acuerdo a la URL.
El listado de webcams se obtiene desde la url:
http://webcams.cumlouder.com/feed/webcams/online/61/1/.
Este listado varía cada 15 minutos, ya que es actualizado con las chicas online.

Consideraciones en el diseño:
Se muestran 5 thumbs de tamaño más grande.
Cada uno corresponde a la posición de la chica en el listado retornado por el json.
THUMB1 -> POSICIÓN 0
THUMB2 -> POSICIÓN 1
THUMB3 -> POSICIÓN 2
THUMB4 -> POSICIÓN 3
THUMB5 -> POSICIÓN 4
Excepto la chica del THUMB1, todas se muestran también como thumb pequeño en el orden que
corresponde.
La chica del THUMB1 la ocultamos del listado de thumbs pequeños.
Cada thumb va a vincular a la join page enviando en la url el nombre de la chica:
http://webcams.cumlouder.com/joinmb/cumlouder/<NOMBRE_CHICA>/

También deberá enviarse el código de tracking del webmaster como parámetro, el cual
tendremos almacenado en un archivo de configuración.
http://webcams.cumlouder.com/joinmb/cumlouder/<NOMBRE_CHICA>/?nats=<CODIGO_TRACK
ING>

La join page debe abrirse en un iframe en modo 'modal'. Se sugiere http://simplemodal.com/

Datos que se deben guardar de cada afiliado:
- Nombre de la web, por ej. "ConejoX"
- URL de la web, por ej. "http://www.conejox.com"

- Código NATS de tracking para webcams.cumlouder.com, por ej.
  "MjYwNS4xLjI1LjQzLjAuMC4wLjAuMA"
- Código NATS de tracking para www.cumlouder.com, por ej. "MjYwNS4xLjIuMi4wLjAuMC4wLjA"
- Ruta al directorio que contiene los CSS customizados, por ej. "conejox"
- Identificador para Google Analytics, por ej. "UA-26020144-23"
  Tener en cuenta que ésta herramienta va a recibir miles de visitas, por lo que debe optimizarse al
  máximo.
  
* ** 

## Requisitos 

* php 8.1
* symfony 5.4
* Módulos de PHP (xml, git)

## Ejecución de Docker

Primero ejecutamos el comando build

```docker-compose build```

Luego lo podemos ejecutar desde la consola o desde docker desktop. La opción -d permite ejecutarlo como un demonio

```docker-compose up -d```

## Ejecución del comando

Para entrar al contenedor primero miramos en el listado de dockers el id del que queremos

```docker container ls```

Que devolverá una tabla de este estilo

| CONTAINER ID | IMAGE | COMMAND | CREATED       | STATUS       | PORTS                                     | NAMES |
| :-----: | ----- | :-----: |-----|-----|-----------------------| :-----: |
| 297747ec8a24 | marca_blanca_marca-blanca-apache | 283 | X minutes ago | Up X minutes | 0.0.0.0:80->80/tcp, 0.0.0.0:443->443/tcp  | marca-blanca-php-apache|

Luego entramos en modo consola usando /bin/bash indicando el nombre del contenedor (también se puede hacer a través de ID)

```docker container exec -it marca-blanca-php-apache /bin/bash```

Una vez dentro ejecutamos el comando de composer para instalar los requerimientos del proyecto.

```composer install```

Posteriormente, ya podremos ejecutar el comando solicitado. 

```bin/console app:control-consumos ficheros/2016-readings.xml```

NOTA: Recordar que el nombre del fichero incluirá la ruta relativas desde la raiz del proyecto. 

Por ejemplo:

```php bin/console app:control-consumos ficheros/2016-readings.xml```