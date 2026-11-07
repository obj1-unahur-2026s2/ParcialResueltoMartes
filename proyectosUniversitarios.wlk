////////////////////////////////////////////////////////
// Programación con Objetos 1 - Primer Parcial 2026c2 //
////////////////////////////////////////////////////////

// Completar
// ---------
// APELLIDO: 
// NOMBRES: 
// DNI: 


// ---------------------------------------------------------------
// Proyectos
// ---------------------------------------------------------------

// Clase abstracta: no puede instanciarse un proyecto sin orientación
class Proyecto {
  const duracionMeses
  const presupuestoBase
  const fuentes = []
  const director

  method agregarFuente(fuente) {
    fuentes.add(fuente)
  }

  method fuentesVigentes() = fuentes.filter({ fuente => fuente.vigente() })

  method fondosVigentes() = self.fuentesVigentes().sum({ fuente => fuente.monto() })

  method costoTotal() = presupuestoBase + self.recargo()

  method recargo()

  method brechaDeFinanciamiento() = (self.costoTotal() - self.fondosVigentes()).max(0)

  method estaFinanciado() = self.brechaDeFinanciamiento() == 0

  method sacarDeVigenciaFuentes() {
    fuentes.forEach({ fuente => fuente.dejarDeEstarVigente() })
  }

  method esDeExcelencia()
}

class ProyectoDeInvestigacion inherits Proyecto {
  const area
  const cantidadEquiposImportados

  override method recargo() =
    if (cantidadEquiposImportados > 0) presupuestoBase * 0.2 else 0

  override method esDeExcelencia() = area.esEstrategica() && duracionMeses > 24
}

class ProyectoDeExtension inherits Proyecto {
  const comunidad
  const actividades = []

  override method recargo() = 0

  override method esDeExcelencia() =
    duracionMeses > 12 && director.altamenteCalificado()
}

class ProyectoComunitario inherits ProyectoDeExtension {
  const cantidadOrganizaciones

  override method esDeExcelencia() =
    super() &&
    actividades.size() >= 4 &&
    cantidadOrganizaciones > 5 &&
    self.fuentesVigentes().size() >= 3

  override method recargo() =
    if (self.esDeExcelencia()) presupuestoBase * 0.05 else 0
}

class Area {
  const nombre
  const property esEstrategica
}

class Actividad {
  const nombre
}

// ---------------------------------------------------------------
// Fuentes de financiamiento
// ---------------------------------------------------------------

class Fuente {
  const tipo
  const property monto
  var vigente = true

  method vigente() = vigente

  method dejarDeEstarVigente() {
    vigente = false
  }

  method ponerEnVigencia() {
    vigente = true
  }
}

// ---------------------------------------------------------------
// Directores y cargos
// ---------------------------------------------------------------

class Director {
  const proyectosDirigidos
  const property dedicacionExclusiva
  const property aniosAntiguedad
  var cargo

  method initialize() {
    self.validarCargo(cargo)
  }

  method validarCargo(unCargo) {
    if (!universidad.esCargoValido(unCargo))
      self.error("El cargo no es válido para la universidad")
  }

  method cambiarCargo() {
    cargo = cargo.siguiente()
  }

  method altamenteCalificado() =
    proyectosDirigidos > 3 && cargo.cumpleCondicion(self)
}

object profesorTitular {
  method siguiente() = self
  method cumpleCondicion(director) = director.dedicacionExclusiva()
}

object profesorAdjunto {
  method siguiente() = profesorTitular
  method cumpleCondicion(director) = director.aniosAntiguedad() >= 5
}

object jefeDeTrabajosPracticos {
  method siguiente() = profesorAdjunto
  method cumpleCondicion(director) = true
}

object universidad {
  const cargosValidos = [profesorTitular, profesorAdjunto, jefeDeTrabajosPracticos]

  method esCargoValido(cargo) = cargosValidos.contains(cargo)
}

// ---------------------------------------------------------------
// Secretaría de Ciencia y Técnica
// ---------------------------------------------------------------

object secretaria {
  const proyectos = []

  method agregarProyectos(coleccionDeProyectos) { proyectos.addAll(coleccionDeProyectos) }

  method brechaTotal() = proyectos.sum({ proyecto => proyecto.brechaDeFinanciamiento() })

  method proyectosSinFinanciamientoCompleto() =
    proyectos.filter({ proyecto => !proyecto.estaFinanciado() })

  method sacarDeVigenciaTodasLasFuentes() {
    proyectos.forEach({ proyecto => proyecto.sacarDeVigenciaFuentes() })
  }
}
