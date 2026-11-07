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
  const property duracionMeses
  const property presupuestoBase
  const property fuentes = []
  var property director

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
  const property area
  const property cantidadEquiposImportados = 0

  override method recargo() =
    if (cantidadEquiposImportados > 0) presupuestoBase * 0.2 else 0

  override method esDeExcelencia() = area.esEstrategica() && duracionMeses > 24
}

class ProyectoDeExtension inherits Proyecto {
  const property comunidad
  const property actividades = []

  override method recargo() = 0

  override method esDeExcelencia() =
    duracionMeses > 12 && director.altamenteCalificado()
}

class ProyectoComunitario inherits ProyectoDeExtension {
  const property cantidadOrganizaciones

  override method esDeExcelencia() =
    super() &&
    actividades.size() >= 4 &&
    cantidadOrganizaciones > 5 &&
    self.fuentesVigentes().size() >= 3

  override method recargo() =
    if (self.esDeExcelencia()) presupuestoBase * 0.05 else 0
}

class Area {
  const property nombre
  const property esEstrategica
}

class Actividad {
  const property nombre
}

// ---------------------------------------------------------------
// Fuentes de financiamiento
// ---------------------------------------------------------------

class Fuente {
  const property tipo
  const property monto
  var property vigente = true

  method dejarDeEstarVigente() {
    vigente = false
  }
}

// ---------------------------------------------------------------
// Directores y cargos
// ---------------------------------------------------------------

class Director {
  var property proyectosDirigidos
  var property dedicacionExclusiva
  var property aniosAntiguedad
  var cargo

  method initialize() {
    self.validarCargo(cargo)
  }

  method cargo() = cargo

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
  const property cargosValidos = [profesorTitular, profesorAdjunto, jefeDeTrabajosPracticos]

  method esCargoValido(cargo) = cargosValidos.contains(cargo)
}

// ---------------------------------------------------------------
// Secretaría de Ciencia y Técnica
// ---------------------------------------------------------------

class Secretaria {
  const property proyectos = []

  method agregarProyecto(proyecto) {
    proyectos.add(proyecto)
  }

  method brechaTotal() = proyectos.sum({ proyecto => proyecto.brechaDeFinanciamiento() })

  method proyectosSinFinanciamientoCompleto() =
    proyectos.filter({ proyecto => !proyecto.estaFinanciado() })

  method sacarDeVigenciaTodasLasFuentes() {
    proyectos.forEach({ proyecto => proyecto.sacarDeVigenciaFuentes() })
  }
}
