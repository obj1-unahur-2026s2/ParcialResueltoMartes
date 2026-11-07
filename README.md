# Parcial 1 - 2026c2 - Programación con Objetos 1

## Sistema de Gestión de Proyectos Universitarios

La **Secretaría de Ciencia y Técnica** de una universidad pública nacional del conurbano quiere ordenar sus proyectos. En un contexto de **fuerte ajuste en el financiamiento universitario**, necesita saber con precisión **cuánto dinero le falta a cada proyecto (la brecha)** para poder llevarse a cabo y de ese modo conocer cuáles son los que más riesgo corren de frenarse.

Por el momento, la universidad gestiona dos tipos de proyectos: **de investigación** y **de extensión**. No se debe permitir crear un proyecto si no es de alguna orientación determinada.

De cada proyecto nos interesa saber la duración en meses, el presupuesto base (lo que cuesta realizarlo), todas sus fuentes de financiamiento y su director a cargo.

> 💡 Los montos del ejercicio se expresan en miles de pesos.

### Proyectos de Investigación

En estos proyectos nos interesa saber el área de estudio, de la que se conoce su nombre y si es **estratégica** o no para el desarrollo del país, y la cantidad de equipos importados que necesita.

### Proyectos de Extensión

Por otro lado, en los proyectos de extensión queremos conocer la comunidad destinataria (texto) y una lista de actividades a realizar (de cada una se conoce su nombre).

---

## Directores

Cada proyecto tiene un **director**, quien se encarga de conducir al equipo. De cada director nos interesa saber la cantidad de proyectos dirigidos, si tiene dedicación exclusiva o no, los años de antigüedad en la universidad y su cargo, que puede ser:
  - Profesor titular
  - Profesor adjunto
  - Jefe de trabajos prácticos

Cada director puede cambiar de cargo si la universidad lo dispone, cumpliendo el siguiente criterio:
- De Jefe de trabajos prácticos puede pasar a Profesor Adjunto. 
- De Profesor adjunto puede pasar a Profesor titular. 
- De Profesor titular no cambia, queda con el mismo cargo si la universidad le indica cambiar. 

Al crear un nuevo director, debe verificarse que su cargo sea alguno de los dispuestos por la universidad (inicialmente esos 3 que se mencionan), caso contrario debe lanzarse un error e impedir crear el director. 

---

## Fuentes de financiamiento

Los proyectos se sostienen con **fuentes de financiamiento**, como por ejemplo:

- Subsidio nacional
- Convenio con un municipio
- Donación de graduados
- Aporte de la cooperadora

De cada fuente nos interesa:

- Nombre del Tipo de financiamiento, como los mencionados arriba.
- Monto
- Si está vigente (una fuente puede dejar de estarlo).

---

## Requerimientos

### 1. Calcular la brecha de financiamiento de un proyecto

El **costo total** del proyecto se calcula a partir de su **presupuesto base**. Si el proyecto es de **investigación** y necesita **al menos un equipo importado**, se aplica un **recargo del 20%** sobre el presupuesto base (por el impacto del tipo de cambio en los insumos).

La **brecha de financiamiento** es lo que le falta al proyecto: se obtiene restando al costo total los montos de las fuentes **vigentes**. Si las fuentes cubren más que el costo total, la brecha es **cero** (nunca negativa). Un proyecto está **financiado** cuando su brecha es cero.

#### Tests sugeridos

- Un proyecto de extensión sin fuentes vigentes tiene una brecha igual a su presupuesto.
- Un proyecto de extensión con 2 fuentes vigentes resta correctamente sus montos a la brecha.
- Un proyecto con fondos de sobra tiene brecha cero y está financiado.
- Un proyecto de investigación con equipos importados calcula correctamente el costo total con el 20% de recargo.
- Si una fuente deja de estar vigente, la brecha aumenta.

---

### 2. Determinar si un director está altamente calificado

Un director es **altamente calificado** si:

- Dirigió **más de 3 proyectos**
- Y cumple según su cargo:
  - **Profesor titular**: tiene que tener dedicación exclusiva
  - **Profesor adjunto**: tener al menos 5 años de antigüedad
  - **Jefe de trabajos prácticos**: no tiene condiciones adicionales

#### Tests sugeridos

- Un titular con dedicación exclusiva y 4 proyectos dirigidos es considerado altamente calificado.
- Un adjunto con menos de 5 años de antigüedad no es calificado, aunque haya dirigido muchos proyectos.
- Un jefe de trabajos prácticos con más de 3 proyectos es siempre calificado.
- Cambiar el cargo de un director modifica su calificación.

---

### 3. Proyectos de excelencia

Queremos saber si un proyecto es **de excelencia**. Las condiciones van a depender de cada tipo de proyecto.

Si el proyecto es de extensión, las condiciones son:
- Tiene más de **12 meses de duración**
- Su director es **altamente calificado**

Si el proyecto es de investigación, las condiciones son:
- Que sea de un **área estratégica**
- Tiene más de **24 meses de duración**

#### Tests

- Testear las nuevas funcionalidades agregadas

---

### 4. Proyectos comunitarios

Queremos agregar además los **proyectos comunitarios**. Estos son como los proyectos de extensión, pero Tendrán como dato adicional la cantidad de organizaciones sociales con las que articulan.

#### Modificaciones en los requerimientos

**Proyectos de excelencia**
- Para este tipo de proyectos, la condición para ser de excelencia agrega como condición tener al menos 4 actividades, articular con más de 5 organizaciones y tener al menos 3 fuentes vigentes.

**Costo**
- Se le agrega un 5% del presupuesto base al costo total si el proyecto es de excelencia (por gastos de movilidad del equipo).

#### Tests

- Testear las nuevas funcionalidades agregadas

---

### 5. Secretaría de Ciencia y Técnica

La Secretaría conoce todos los proyectos de la universidad. Queremos saber:

- La **brecha total** de financiamiento (la suma de las brechas de todos sus proyectos).
- Qué proyectos **no están completamente financiados**.
- Indicar a todos los proyectos que saquen de vigencia todas sus fuentes de financiamiento.

#### Tests

- Testear las nuevas funcionalidades agregadas

---
